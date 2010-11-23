﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CmsWeb.Areas.Main.Models.MassEmailer>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

fieldset label {
  display: block;
}
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    $(function () {
        setInterval(KeepSessionAlive, 120000);
    });
    function KeepSessionAlive() {
        $.post("/Account/KeepAlive", null, null);
    }  
</script>

<div>
<span class="style1">Please Note</span>: 
You can include a file, image, mp3 or whatever you like in your email. 
<a href="http://www.bvcms.com/Doc/EmailFileUpload">Read this article for instructions</a>.
<% using (Html.BeginForm("QueueEmails", "Email"))
   { %>
   <div>
   <fieldset>
   <%=Html.Hidden("QBId") %>
   <%=Html.Hidden("Count", Model.Count) %>
   <p>Number of Emails: <%=Model.Count%></p>
   <p>
        <input type="submit" name="Submit" value="Send" style="width:62px;height: 42px;" onclick="$.blockUI()" /> 
        <% if (Page.User.IsInRole("Admin"))
           { %>
        Scheduled Date and Time (mm/dd/yy h:mm AM|PM)<%=Html.TextBox("Schedule", Model.Schedule, new { style = "width:120px" })%> (Optional)</p>
        <% } %>
   <p>From: <%=Html.DropDownList("FromAddress", Model.EmailFroms()) %>
    <input type="submit" name="Submit" value="Test (Send To Yourself)" onclick="$.blockUI()" />
    </p>
    <p><label>Subject:</label>
    <%=Html.TextBox("Subject", Model.Subject, new { style = "width:90%" })%>
    </p>
    <p><label>Body:</label>
    <%=Html.TextArea("Body", Model.Body, new { rows="16", cols="20" }) %>
    </p>
    </fieldset>
    </div>
<% } %>
        <table>
        <tr>
            <td> </td>
            <td>
                <br />
                In the body of the text, the following:<br />
                <br />
                <div class="boxThinBorder">
                    <pre>
Hi {first},

I could call you by your whole name like this: {name}.

</pre>
                </div>
                <br />
                would look like this in the email:<br />
                <div class="boxThinBorder">
                    <p>
                        Hi David,<br />
                        <br />
                        I could call you by your whole name like this: David Carroll.<br />
                </div>
                <br />
            </td>
        </tr>
    </table>
</div>
<script src="/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="/scripts/edit.js" type="text/javascript"></script>
<script type="text/javascript">
    ShowEditor('Body');
</script>
</asp:Content>
