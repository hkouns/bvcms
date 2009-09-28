﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using CmsData;
using UtilityExtensions;
using System.Configuration;
using CMSWeb;
using System.Web.Security;
using System.Web.DynamicData;
using System.Data.Linq.Mapping;
using System.Collections;
using System.Web.SessionState;
using System.Xml.Linq;
using System.Net.Mail;
using System.Web.Configuration;
using CMSPresenter;

namespace CMSWeb2
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
        }
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{myWebForms}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{myWebForms}.ashx/{*pathInfo}");
            routes.IgnoreRoute("{myWebForms}.asmx/{*pathInfo}");
            routes.IgnoreRoute("{myWebForms}.js/{*pathInfo}");
            routes.IgnoreRoute("{name}.ico");
            routes.IgnoreRoute("{name}.png");
            routes.IgnoreRoute("Admin/{*pathInfo}");
            routes.IgnoreRoute("AppReview/{*pathInfo}");
            routes.IgnoreRoute("CustomErrors/{*pathInfo}");
            routes.IgnoreRoute("Contributions/{*pathInfo}");
            routes.IgnoreRoute("Report/{*pathInfo}");
            routes.IgnoreRoute("Dialog/{*pathInfo}");
            routes.IgnoreRoute("fckeditor/{*pathInfo}");
            routes.IgnoreRoute("StaffOnly/{*pathInfo}");
            routes.IgnoreRoute("images/{*pathInfo}");
            routes.IgnoreRoute("App_Themes/{*pathInfo}");
            routes.IgnoreRoute("Content/{*pathInfo}");
            routes.IgnoreRoute("Scripts/{*pathInfo}");
            routes.IgnoreRoute("Upload/{*pathInfo}");
            routes.IgnoreRoute("{myWebPage}.htm");
            routes.IgnoreRoute("{myReport}.rdlc");
            routes.IgnoreRoute("{dir1}/{dir2}/{file}.js");
            routes.IgnoreRoute("{dir1}/{dir2}/{file}.css");

            routes.RouteExistingFiles = true;

            CMSWebCommon.Routes.RegisterRoutes(routes);
            CMSRegCustom.Routes.RegisterRoutes(routes);
            CMSWebSetup.Routes.RegisterRoutes(routes);

            AddRoute(routes, "Task", "Task", "Task/{action}/{id}", "List");
            AddRoute(routes, "TaskDetail", "Task", "Task/Detail/{id}/Row/{rowid}", "Detail");
            AddRoute(routes, "QueryBuilder", "QueryBuilder", "QueryBuilder/{action}/{id}", "Main");
            AddRoute(routes, "VolunteerConfirm", "Volunteer", "Volunteer/Confirm", "confirm");
            AddRoute(routes, "Volunteer", "Volunteer", "Volunteer/{id}", "Start");
            AddRoute(routes, "Default", "Home", "{controller}/{action}/{id}", "Index");
            
            //RouteDebug.RouteDebugger.RewriteRoutesForTesting(RouteTable.Routes);
        }
        private static void AddRoute(RouteCollection routes, string name, string controller, string path, string action)
        {
            routes.MapAreaRoute("Main", name, path, 
                new { controller = controller, action = action, id = "" },
                new string[] { "CMSWeb.Controllers" });
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (Util.UserId == 0 && Util.UserName.HasValue())
            {
                var u = DbUtil.Db.Users.SingleOrDefault(us => us.Username == Util.UserName);
                if (u != null)
                {
                    Util.UserId = u.UserId;
                    Util.UserPeopleId = u.PeopleId;
                }
            }
            Util.SessionStarting = true;
        }
        //protected void Application_BeginRequest(object sender, EventArgs e)
        //{
        //}
        protected void Application_EndRequest(object sender, EventArgs e)
        {
            if (HttpContext.Current != null)
                DbUtil.DbDispose();
            if (Response.Status.StartsWith("401")
                    && Request.Url.AbsolutePath.EndsWith(".aspx"))
                Login.CheckStaffRole(User.Identity.Name);
        }
        protected void Application_Error(object sender, EventArgs e)
        {
            var ex = Server.GetLastError();
            var InDebug = false;
#if DEBUG
            InDebug = false;
#endif
            if (InDebug)
            {
                Response.Write("<html><body><pre>\n");
                Response.Write(ex.ToString());
                Response.Write("</pre></body></html>\n");
                Server.ClearError();
                return;
            }
            var u = DbUtil.Db.CurrentUser;
            var smtp = new SmtpClient();
            var msg = new MailMessage();
            msg.Subject = "bvcms error on " + Request.Url.Authority;
            if (u != null)
            {
                msg.From = new MailAddress(u.EmailAddress, u.Name);
                msg.Body = "\n{0} ({1}, {2})\n".Fmt(u.EmailAddress, u.UserId, u.Name) + ex.ToString();
            }
            else
            {
                msg.From = new MailAddress(WebConfigurationManager.AppSettings["sysfromemail"]);
                msg.Body = ex.ToString();
            }
            foreach (var a in CMSRoleProvider.provider.GetRoleUsers("Developer"))
                msg.To.Add(new MailAddress(a.Person.EmailAddress, a.Name));
            smtp.Send(msg);
        }
    }
}