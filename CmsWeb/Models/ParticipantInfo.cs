﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UtilityExtensions;

namespace CMSWeb.Models
{
    public class ParticipantInfo
    {
        public int? Id { get; set; }
        public bool IsSelected { get; set; }
        public string Checked
        {
            get { return IsSelected ? "checked='checked'" : ""; }
        }
        public int? PeopleId { get; set; }
        public int? OrgId { get; set; }
        public string Name { get; set; }
        public string Name2 { get; set; }
        public string MemberType { get; set; }
        public string TeamName { get; set; }
        public bool FeePaid { get; set; }
        public string Request { get; set; }
        public string ShirtSize { get; set; }
        public int? BDay { get; set; }
        public int? BMon { get; set; }
        public int? BYear { get; set; }
        public string Birthday 
        { 
            get { return Util.FormatBirthday(BYear, BMon, BDay); } 
        }
        public int? Hash { get; set; }
        public DateTime? Uploaded { get; set; }
    }
}