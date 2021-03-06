﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using CmsData;
using System.Web.Mvc;
using System.Xml.Serialization;
using System.IO;
using Newtonsoft.Json;
using NPOI.SS.Formula.Functions;
using UtilityExtensions;

namespace CmsWeb.Code
{
    public class StandardExtraValues
    {
        [Serializable]
        public class Fields
        {
            [XmlElement("Field")]
            public Field[] fields { get; set; }
        }
        [Serializable]
        public class Field
        {
            [XmlAttribute]
            public string name { get; set; }
            [XmlAttribute]
            public string type { get; set; }
            [XmlAttribute]
            public string location { get; set; }
            [XmlAttribute]
            public string VisibilityRoles { get; set; }
            public List<string> Codes { get; set; }
            internal int order;
            public int peopleid;
            public bool nonstandard;

            internal PeopleExtra extravalue;
            internal static Field AddField(Field f, PeopleExtra v)
            {
                if (f == null)
                {
                    f = new Field
                    {
                        name = v.Field,
                        nonstandard = true,
                        peopleid = v.PeopleId,
                        extravalue = v,
                    };
                    f.type = v.StrValue.HasValue() ? "Code"
                        : v.Data.HasValue() ? "Data"
                        : v.DateValue.HasValue ? "Date"
                        : v.IntValue.HasValue ? "Int"
                        : v.BitValue.HasValue ? "Bit"
                        : "Code";
                }
                f.extravalue = v;
                return f;
            }
            public bool UserCanView()
            {
                if (!VisibilityRoles.HasValue())
                    return true;
                var a = VisibilityRoles.SplitStr(",");
                var user = HttpContext.Current.User;
				foreach (var role in a)
					if (user.IsInRole(role.Trim()))
						return true;
				return false;
            }
            public bool UserCanEdit()
            {
                var user = HttpContext.Current.User;
                return user.IsInRole("Edit");
            }
            public override string ToString()
            {
                if (extravalue == null && type != "Bits")
                    return "Click to edit";
                switch (type)
                {
                    case "Code":
                        return extravalue.StrValue;
                    case "Data":
                        return extravalue.Data;
                    case "Date":
                        return extravalue.DateValue.FormatDate();
                    case "Bit":
                        return extravalue.BitValue.ToString();
                    case "Bits":
                        {
                            var q = from e in DbUtil.Db.PeopleExtras
                                    where e.BitValue == true
                                    where e.PeopleId == peopleid
                                    where Codes.Contains(e.Field)
                                    select e.Field;
                            return string.Join(",", q);
                        }
                    case "Int":
                        if (extravalue.IntValue2.HasValue)
                            return "{0} {1}".Fmt(extravalue.IntValue, extravalue.IntValue2);
                        return extravalue.IntValue.ToString();
                }
				return null;
            }

                }
        public static IEnumerable<Field> GetExtraValues()
        {
            if (DbUtil.Db.Setting("UseStandardExtraValues", "false") != "true")
				return new List<Field>();
            var xml = DbUtil.StandardExtraValues();
            var sr = new StringReader(xml);
			var fields = (new XmlSerializer(typeof(Fields)).Deserialize(sr) as Fields).fields;
			if (fields == null)
				return new List<Field>();
			return fields;
        }


        public static IEnumerable<Field> GetExtraValues(int PeopleId, string location = "default")
        {
			var fields = GetExtraValues();

            var n = 1;
			foreach (var f in fields)
            {
                f.order = n++;
                f.peopleid = PeopleId;
                if (f.location == null)
                    f.location = "default";
            }

			var exvalues = DbUtil.Db.PeopleExtras.Where(ee => ee.PeopleId == PeopleId).ToList();


			var qfields = from f in fields
						  join v in exvalues on f.name equals v.Field into j
                           from v in j.DefaultIfEmpty()
						  where f.location == location || location == null
                           orderby f.order
                           select Field.AddField(f, v);
			if (location == "default")
            {
				var qvalues = from v in exvalues
							  join f in fields on v.Field equals f.name into j
                        from f in j.DefaultIfEmpty()
                        where f == null
							  where !fields.Any(ff => ff.Codes.Any(cc => cc == v.Field))
                        orderby v.Field
                        select Field.AddField(f, v);
				return qfields.Concat(qvalues);
            }
			return qfields;
        }
        public static List<SelectListItem> ExtraValueCodes()
        {
            var q = from e in DbUtil.Db.PeopleExtras
                    where e.StrValue != null || e.BitValue != null
                    group e by new { e.Field, val = e.StrValue ?? (e.BitValue == true ? "1" : "0") }
                        into g
                        select g.Key;
            var list = q.ToList();

            var ev = GetExtraValues();
            var q2 = from e in list
                     let f = ev.SingleOrDefault(ff => ff.name == e.Field)
                     where f == null || f.UserCanView()
                     orderby e.Field, e.val
                     select new SelectListItem()
                            {
                                Text = e.Field + ":" + e.val,
                                Value = e.Field + ":" + e.val,
                            };
            return q2.ToList();
        }
        public static Dictionary<string, string> Codes(string name)
        {
            var f = GetExtraValues().Single(ee => ee.name == name);
            return f.Codes.ToDictionary(ee => ee, ee => ee);
        }

        public static Dictionary<string, bool> ExtraValueBits(string name, int PeopleId)
        {
            var f = GetExtraValues().Single(ee => ee.name == name);
            var list = DbUtil.Db.PeopleExtras.Where(pp => pp.PeopleId == PeopleId && f.Codes.Contains(pp.Field)).ToList();
            var q = from c in f.Codes
                    join e in list on c equals e.Field into j
                    from e in j.DefaultIfEmpty()
                    select new { value = c, selected = (e != null && (e.BitValue ?? false)) };
            return q.ToDictionary(ee => ee.value, ee => ee.selected);
        }
        }



}