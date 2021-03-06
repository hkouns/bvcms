using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using CmsData;
using UtilityExtensions;

namespace CmsWeb.Areas.Setup.Controllers
{
    [Authorize(Roles = "Admin")]
    public class MinistryController : CmsStaffController
    {
        public ActionResult Index()
        {
            var m = DbUtil.Db.Ministries.AsEnumerable();
            return View(m);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create()
        {
            var m = new Ministry { MinistryName = "NEW" };
            DbUtil.Db.Ministries.InsertOnSubmit(m);
            DbUtil.Db.SubmitChanges();
            return Redirect("/Setup/Ministry/");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ContentResult Edit(string id, string value)
        {
            var a = id.Split('.');
            var c = new ContentResult();
            c.Content = value;
            var min = DbUtil.Db.Ministries.SingleOrDefault(m => m.MinistryId == a[1].ToInt());
            if (min == null)
                return c;
            switch (a[0])
            {
                case "MinistryName":
                    min.MinistryName = value;
                    break;
            }
            DbUtil.Db.SubmitChanges();
            return c;
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public EmptyResult Delete(string id)
        {
            id = id.Substring(1);
            var min = DbUtil.Db.Ministries.SingleOrDefault(m => m.MinistryId == id.ToInt());
            if (min == null)
                return new EmptyResult();
            DbUtil.Db.Ministries.DeleteOnSubmit(min);
            DbUtil.Db.SubmitChanges();
            return new EmptyResult();
        }
    }
}
