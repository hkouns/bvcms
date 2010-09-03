﻿/* Author: David Carroll
 * Copyright (c) 2008, 2009 Bellevue Baptist Church 
 * Licensed under the GNU General Public License (GPL v2)
 * you may not use this code except in compliance with the License.
 * You may obtain a copy of the License at http://bvcms.codeplex.com/license 
 */
using System;
using System.Collections.Generic;
using System.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
using CmsData;
using UtilityExtensions;
using System.Text;
using System.Web.Mvc;
using CmsWeb.Models;

namespace CmsWeb.Areas.Main.Models.Report
{
    public class ProspectResult : ActionResult
    {
        private PageEvent pageEvents = new PageEvent();
        private Document doc;
        private DateTime dt;
        private PdfContentByte dc;
        private ColumnText ct;
        private Font bfont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10);
        private Font font = FontFactory.GetFont(FontFactory.HELVETICA, 10);
        private Font smallfont = FontFactory.GetFont(FontFactory.HELVETICA, 8);

        private int? qid;
        public ProspectResult(int? id)
        {
            qid = id;
        }

        public class ProspectInfo
        {
            public int PeopleId { get; set; }
            public string Name { get; set; }
            public string Address { get; set; }
            public string Address2 { get; set; }
            public string CityStateZip { get; set; }
            public string Age { get; set; }
            public string CellPhone { get; set; }
            public string HomePhone { get; set; }
            public string WorkPhone { get; set; }

            public string MemberStatus { get; set; }
            public string Gender { get; set; }
            public string MaritalStatus { get; set; }
            public string PositionInFamily { get; set; }
            public string Origin { get; set; }
            public string Comment { get; set; }
            public string ChristAsSavior { get; set; }
            public string InterestedInJoining { get; set; }
            public string InfoBecomeAChristian { get; set; }
            public string PleaseVisit { get; set; }
            public IEnumerable<FamilyMember> Family { get; set; }
            public IEnumerable<OrganizationView> Memberships { get; set; }
            public IEnumerable<ContactInfo> Contacts { get; set; }
            public IEnumerable<AttendInfo> Attends { get; set; }
        }
        public class FamilyMember
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public int? Age { get; set; }
            public bool Deceased { get; set; }
            public string PositionInFamily { get; set; }
            public int PositionInFamilyId { get; set; }
            public string MemberStatus { get; set; }
            public int PeopleId { get; set; }
        }
        public class OrganizationView
        {
            public string Name { get; set; }
            public int Id { get; set; }
            public string Location { get; set; }
            public string LeaderName { get; set; }
            public DateTime? MeetingTime { get; set; }
            public string Schedule { get { return "{0:dddd h:mm tt}".Fmt(MeetingTime); } }
            public int? LeaderId { get; set; }
            public string MemberType { get; set; }
            public DateTime? EnrollDate { get; set; }
            public DateTime? DropDate { get; set; }
            public string DivisionName { get; set; }
            public decimal? AttendPct { get; set; }
        }
        public class ContactInfo
        {
            public int ContactId { get; set; }
            public string Comments { get; set; }
            public DateTime ContactDate { get; set; }
            public string TypeOfContact { get; set; }
            public string ContactReason { get; set; }
            public string Team { get; set; }
        }
        public class AttendInfo
        {
            public int MeetingId { get; set; }
            public DateTime? MeetingDate { get; set; }
            public string OrganizationName { get; set; }
            public string MeetingName { get; set; }
            public int PeopleId { get; set; }
            public string Name { get; set; }
            public string MemberType { get; set; }
            public string AttendType { get; set; }
            public bool AttendFlag { get; set; }
            public bool RegisteredFlag { get; set; }
            public int RollSheetSectionId { get; set; }
            public string Teacher { get; set; }
        }

        public override void ExecuteResult(ControllerContext context)
        {
            var Response = context.HttpContext.Response;
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "filename=foo.pdf");

            dt = Util.Now;

            doc = new Document(PageSize.LETTER, 36, 36, 36, 36);
            var w = PdfWriter.GetInstance(doc, Response.OutputStream);
            w.PageEvent = pageEvents;
            doc.Open();
            dc = w.DirectContent;
            ct = new ColumnText(dc);

            if (!qid.HasValue)
                doc.Add(new Phrase("no data"));
            else
            {
                pageEvents.StartPageSet("Prospect Report: {0:d}".Fmt(dt));
                IQueryable<ProspectInfo> q = GetProspectInfo();
                foreach (var p in q)
                {
                    doc.NewPage();
                    var t = new PdfPTable(new float[] { 62f, 61f, 67f });
                    t.SetNoPadding();
                    var t1 = new PdfPTable(1);
                    t1.SetNoBorder();
                    var t2 = new PdfPTable(new float[] { 30f, 31f });
                    t2.SetNoBorder();
                    var t3 = new PdfPTable(new float[] { 27f, 40f });
                    t3.SetNoBorder();


                    var ph = new Paragraph();
                    ph.Add(new Chunk(p.Name, bfont));
                    ph.Add(new Chunk(" ({0})".Fmt(p.PeopleId), smallfont));
                    t1.AddCell(ph);
                    ph = new Paragraph();
                    ph.AddLine(p.Address, font);
                    ph.AddLine(p.Address2, font);
                    ph.AddLine(p.CityStateZip, font);
                    ph.Add("\n");
                    ph.AddLine(p.HomePhone.FmtFone("H"), font);
                    ph.AddLine(p.CellPhone.FmtFone("C"), font);
                    ph.AddLine(p.WorkPhone.FmtFone("W"), font);
                    t1.AddCell(ph);
                    t.AddCell(t1);

                    t2.Add("Position in Family:", font);
                    t2.Add(p.PositionInFamily, font);
                    t2.Add("Gender:", font);
                    t2.Add(p.Gender, font);
                    t2.Add("Marital Status:", font);
                    t2.Add(p.MaritalStatus, font);
                    t2.Add("", font);
                    t2.CompleteRow();

                    if (p.ChristAsSavior.HasValue())
                        t2.Add(p.ChristAsSavior, 2, font);
                    if (p.InfoBecomeAChristian.HasValue())
                        t2.Add(p.InfoBecomeAChristian, 2, font);
                    if (p.InterestedInJoining.HasValue())
                        t2.Add(p.InterestedInJoining, 2, font);
                    if (p.PleaseVisit.HasValue())
                        t2.Add(p.PleaseVisit, 2, font);

                    t.AddCell(t2);

                    t3.Add("Member Status:", font);
                    t3.Add(p.MemberStatus, font);
                    t3.Add("Origin:", font);
                    t3.Add(p.Origin, font);
                    t3.Add("Age:", font);
                    t3.Add(p.Age, font);
                    t3.Add("Comments:", 2, font);
                    t3.Add(p.Comment, 2, font);

                    t.AddCell(t3);
                    doc.Add(t);

                    if (p.Family.Count() > 0)
                    {
                        t = new PdfPTable(4);
                        t.SetNoBorder();
                        t.AddRow("Family Summary", bfont);
                        t.AddHeader("Name", bfont);
                        t.AddHeader("Age", bfont);
                        t.AddHeader("Position in Family", bfont);
                        t.AddHeader("Member Status", bfont);
                        foreach (var fm in p.Family)
                        {
                            t.Add(fm.Name, font);
                            t.Add(fm.Age.ToString(), font);
                            t.Add(fm.PositionInFamily, font);
                            t.Add(fm.MemberStatus, font);
                        }
                        doc.Add(t);
                    }

                    if (p.Attends.Count() > 0)
                    {
                        t = new PdfPTable(new float[] { 24f, 73f, 56f, 34f });
                        t.SetNoBorder();
                        t.AddRow("Attendance Summary", bfont);
                        t.AddHeader("Date", bfont);
                        t.AddHeader("Event", bfont);
                        t.AddHeader("Teacher", bfont);
                        t.AddHeader("Schedule", bfont);
                        foreach (var a in p.Attends)
                        {
                            t.Add(a.MeetingDate.FormatDate(), font);
                            t.Add(a.MeetingName, font);
                            t.Add(a.Teacher, font);
                            t.Add(a.MeetingDate.ToString2("h:mm tt"), font);
                        }
                        doc.Add(t);
                    }

                    if (p.Contacts.Count() > 0)
                    {
                        t = new PdfPTable(new float[] { 31f, 134f });
                        t.SetNoBorder();
                        t.AddRow("Contacts", font);
                        t.AddHeader("Date/Type/Team", font);
                        t.AddHeader("Comments", font);
                        foreach (var a in p.Contacts)
                        {
                            t.AddHeader("{0:d}\n{1}\n{2}".Fmt(a.ContactDate, a.TypeOfContact, a.Team), font);
                            t.AddHeader(a.Comments, font);
                        }
                        doc.Add(t);
                    }

                    if (p.Memberships.Count() > 0)
                    {
                        t = new PdfPTable(4);
                        t.SetNoBorder();
                        t.AddRow("Current Enrollment", bfont);
                        t.AddHeader("Division", bfont);
                        t.AddHeader("Organization", bfont);
                        t.AddHeader("Member Type", bfont);
                        t.AddHeader("Enroll Date", bfont);
                        foreach (var m in p.Memberships)
                        {
                            t.Add(m.DivisionName, font);
                            t.Add(m.Name, font);
                            t.Add(m.MemberType, font);
                            t.Add(m.EnrollDate.FormatDate(), font);
                        }
                        doc.Add(t);
                    }

                }
            }
            pageEvents.EndPageSet();
            doc.Close();
            Response.End();
        }

        private IQueryable<ProspectInfo> GetProspectInfo()
        {
            var Db = DbUtil.Db;
            var qB = Db.LoadQueryById(qid.Value);
            var q = from p in Db.People.Where(qB.Predicate())
                    orderby p.PrimaryZip, p.LastName, p.Name
                    select new ProspectInfo
                    {
                        PeopleId = p.PeopleId,
                        Name = p.Name,
                        Address = p.PrimaryAddress,
                        Address2 = p.PrimaryAddress2,
                        Age = p.Age != null ? p.Age.ToString() : "",
                        MemberStatus = p.MemberStatus.Description,
                        CityStateZip = Util.FormatCSZ4(p.PrimaryCity, p.PrimaryState, p.PrimaryZip),
                        Gender = p.GenderId == 1 ? "Male" : p.GenderId == 2 ? "Female" : "",
                        MaritalStatus = p.MaritalStatus.Description,
                        PositionInFamily = p.FamilyPosition.Description,
                        Origin = p.Origin.Description,
                        Comment = p.Comments,
                        ChristAsSavior = p.ChristAsSavior ? "Prayed to receive Christ as Savior" : "",
                        InterestedInJoining = p.InterestedInJoining ? "Interested in joining Church" : "",
                        PleaseVisit = p.PleaseVisit ? "Requests a visit" : "",
                        InfoBecomeAChristian = p.InfoBecomeAChristian ? "Interested in becoming a Christian" : "",
                        CellPhone = p.CellPhone,
                        HomePhone = p.HomePhone,
                        WorkPhone = p.WorkPhone,

                        Family = from m in p.Family.People
                                 where m.DeceasedDate == null
                                 where m.PeopleId != p.PeopleId
                                 orderby m.PositionInFamilyId, m.Age descending
                                 select new FamilyMember
                                 {
                                     Id = m.PeopleId,
                                     Name = m.Name,
                                     Age = m.Age,
                                     Deceased = m.DeceasedDate != null,
                                     PositionInFamily = m.FamilyPosition.Description,
                                     MemberStatus = m.MemberStatus.Description
                                 },
                        Memberships = from om in p.OrganizationMembers
                                      where dt > om.EnrollmentDate
                                      let o = om.Organization
                                      let l = Db.People.SingleOrDefault(l => l.PeopleId == o.LeaderId)
                                      orderby om.Organization.OrganizationName
                                      select new OrganizationView
                                      {
                                          Id = o.OrganizationId,
                                          Name = o.OrganizationName,
                                          Location = o.Location,
                                          LeaderName = l.Name,
                                          MeetingTime = o.MeetingTime,
                                          MemberType = om.MemberType.Description,
                                          EnrollDate = om.EnrollmentDate,
                                          DivisionName = o.Division.Name
                                      },
                        Contacts = from ch in p.contactsHad
                                   let c = ch.contact
                                   orderby c.ContactDate descending
                                   select new ContactInfo
                                   {
                                       ContactId = c.ContactId,
                                       Comments = c.Comments,
                                       ContactDate = c.ContactDate,
                                       ContactReason = c.NewContactReason.Description,
                                       TypeOfContact = c.NewContactType.Description,
                                       Team = string.Join(",", c.contactsMakers.Select(cm => cm.person.Name).ToArray())
                                   },
                        Attends = (from a in p.Attends
                                   where a.AttendanceFlag == true
                                   let o = a.Organization
                                   orderby a.MeetingDate descending, o.OrganizationName
                                   select new AttendInfo
                                   {
                                       MeetingId = a.MeetingId,
                                       OrganizationName = o.OrganizationName,
                                       Teacher = o.LeaderName,
                                       AttendType = a.AttendType.Description,
                                       MeetingName = o.Division.Name + ": " + o.OrganizationName,
                                       MeetingDate = a.MeetingDate,
                                       MemberType = a.MemberType.Description,
                                   }).Take(10)
                    };
            return q;
        }

        class PageEvent : PdfPageEventHelper
        {
            private PdfTemplate npages;
            private PdfWriter writer;
            private Document document;
            private PdfContentByte dc;
            private BaseFont font;
            private string HeadText;

            public override void OnOpenDocument(PdfWriter writer, Document document)
            {
                this.writer = writer;
                this.document = document;
                base.OnOpenDocument(writer, document);
                font = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                dc = writer.DirectContent;
            }
            public void EndPageSet()
            {
                if (npages == null)
                    return;
                npages.BeginText();
                npages.SetFontAndSize(font, 8);
                npages.ShowText((writer.PageNumber + 1).ToString());
                npages.EndText();
            }
            public void StartPageSet(string header1)
            {
                EndPageSet();
                document.NewPage();
                document.ResetPageCount();
                this.HeadText = header1;
                npages = dc.CreateTemplate(50, 50);
            }
            public override void OnEndPage(PdfWriter writer, Document document)
            {
                base.OnEndPage(writer, document);

                string text;
                float len;

                //---Header left
                text = HeadText;
                const float HeadFontSize = 11f;
                len = font.GetWidthPoint(text, HeadFontSize);
                dc.BeginText();
                dc.SetFontAndSize(font, HeadFontSize);
                dc.SetTextMatrix(30, document.PageSize.Height - 30);
                dc.ShowText(text);
                dc.EndText();

                //---Column 1
                text = String.Format("Page {0} of ", writer.PageNumber + 1);
                len = font.GetWidthPoint(text, 8);
                dc.BeginText();
                dc.SetFontAndSize(font, 8);
                dc.SetTextMatrix(30, 30);
                dc.ShowText(text);
                dc.EndText();
                dc.AddTemplate(npages, 30 + len, 30);

                //---Column 2
                text = HeadText;
                len = font.GetWidthPoint(text, 8);
                dc.BeginText();
                dc.SetFontAndSize(font, 8);
                dc.SetTextMatrix(document.PageSize.Width / 2 - len / 2, 30);
                dc.ShowText(text);
                dc.EndText();

                //---Column 3
                text = Util.Now.ToShortDateString();
                len = font.GetWidthPoint(text, 8);
                dc.BeginText();
                dc.SetFontAndSize(font, 8);
                dc.SetTextMatrix(document.PageSize.Width - 30 - len, 30);
                dc.ShowText(text);
                dc.EndText();
            }
        }
    }
}