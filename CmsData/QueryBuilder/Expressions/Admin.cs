﻿/* Author: David Carroll
 * Copyright (c) 2008, 2009 Bellevue Baptist Church 
 * Licensed under the GNU General Public License (GPL v2)
 * you may not use this code except in compliance with the License.
 * You may obtain a copy of the License at http://bvcms.codeplex.com/license 
 */
using System;
using System.Linq;
using System.Linq.Expressions;
using CmsData.Codes;
using System.Data.Linq;
using UtilityExtensions;

namespace CmsData
{
    public partial class Condition
    {
        internal Expression UserRole()
        {
            Expression<Func<Person, bool>> pred = p =>
                p.Users.Any(u => u.UserRoles.Any(ur => CodeIntIds.Contains(ur.RoleId))
                    || (!u.UserRoles.Any() && CodeIntIds.Contains(0))
                );
            return op == CompareType.NotEqual || op == CompareType.NotOneOf 
                ? (Expression)Expression.Not(Expression.Invoke(pred, parm)) 
                : (Expression)Expression.Invoke(pred, parm);
        }
        internal Expression IsUser()
        {
            var tf = CodeIds == "1";
            Expression<Func<Person, bool>> pred = p =>
                    p.Users.Any();
            Expression expr = Expression.Convert(Expression.Invoke(pred, parm), typeof(bool));
            if (!(op == CompareType.Equal && tf))
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression CreatedBy()
        {
            Expression<Func<Person, string>> pred = p =>
                db.People.FirstOrDefault(u => u.Users.Any(u2 => u2.UserId == p.CreatedBy)).Name2;
            Expression left = Expression.Invoke(pred, parm);
            var right = Expression.Constant(TextValue, typeof(string));
            return Compare(parm, left, op, right);
        }
        internal Expression RecentCreated()
        {
            var tf = CodeIds == "1";
            var dt = DateTime.Today.AddDays(-Days);
            Expression<Func<Person, bool>> pred = p => p.CreatedDate >= dt;
            Expression expr = Expression.Invoke(pred, parm);
            if (!(op == CompareType.Equal && tf))
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression IsCurrentPerson()
        {
            var tf = CodeIds == "1";
            Expression<Func<Person, bool>> pred = p =>
                    p.PeopleId == db.CurrentPeopleId;
            Expression expr = Expression.Convert(Expression.Invoke(pred, parm), typeof(bool));
            if (!(op == CompareType.Equal && tf))
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression DuplicateEmails()
        {
            var tf = CodeIds == "1";
            Expression<Func<Person, bool>> pred = p =>
                    p.EmailAddress != null && p.EmailAddress != ""
                    && db.People.Any(pp => pp.PeopleId != p.PeopleId && pp.EmailAddress == p.EmailAddress);
            Expression expr = Expression.Convert(Expression.Invoke(pred, parm), typeof(bool));
            if (!(op == CompareType.Equal && tf))
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression DuplicateNames()
        {
            var tf = CodeIds == "1";
            Expression<Func<Person, bool>> pred = p =>
                    db.People.Any(pp => pp.PeopleId != p.PeopleId && pp.FirstName == p.FirstName && pp.LastName == p.LastName);
            Expression expr = Expression.Convert(Expression.Invoke(pred, parm), typeof(bool));
            if (!(op == CompareType.Equal && tf))
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression HasLowerName()
        {
            var tf = CodeIds == "1";
            Expression<Func<Person, bool>> pred = p =>
                    db.StartsLower(p.FirstName).Value
                    || db.StartsLower(p.LastName).Value;
            Expression expr = Expression.Convert(Expression.Invoke(pred, parm), typeof(bool));
            if (!(op == CompareType.Equal && tf))
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression PeopleIds()
        {
            var ids = (TextValue ?? "").Split(',').Select(aa => aa.ToInt()).ToArray();
            Expression<Func<Person, bool>> pred = p => ids.Contains(p.PeopleId);
            Expression expr = Expression.Invoke(pred, parm);
            if (op == CompareType.NotEqual || op == CompareType.NotOneOf)
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression MatchAnything()
        {
            Expression<Func<Person, bool>> pred = p => true;
            return Expression.Invoke(pred, parm);
        }
        internal Expression HasEmailOptout()
        {
            var email = TextValue;
            Expression<Func<Person, bool>> pred = p =>
                (from oo in p.EmailOptOuts
                 where email == null || email == "" || oo.FromEmail == email
                 where EndDate == null || (oo.DateX >= EndDate)
                 select oo).Any();
            Expression expr = Expression.Invoke(pred, parm);
            return expr;
        }
        internal Expression MeetingId()
        {
            var meetingid = TextValue.ToInt();
            Expression<Func<Person, bool>> pred = p =>
                p.Attends.Any(a =>
                    (a.AttendanceFlag == true)
                    && a.MeetingId == meetingid
                    );
            Expression expr = Expression.Invoke(pred, parm);
            if (op == CompareType.NotEqual)
                expr = Expression.Not(expr);
            return expr;
        }
        internal Expression RegisteredForMeetingId()
        {
            var meetingid = TextValue.ToInt();
            Expression<Func<Person, bool>> pred = p =>
                p.Attends.Any(a =>
                    (a.Commitment == AttendCommitmentCode.Attending
                    || a.Commitment == AttendCommitmentCode.Substitute
                    || a.Commitment == AttendCommitmentCode.FindSub)
                    && a.MeetingId == meetingid
                    );
            Expression expr = Expression.Invoke(pred, parm);
            if (op == CompareType.NotEqual)
                expr = Expression.Not(expr);
            return expr;
        }
    }
}
