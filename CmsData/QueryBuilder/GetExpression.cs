/* Author: David Carroll
 * Copyright (c) 2008, 2009 Bellevue Baptist Church 
 * Licensed under the GNU General Public License (GPL v2)
 * you may not use this code except in compliance with the License.
 * You may obtain a copy of the License at http://bvcms.codeplex.com/license 
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Caching;
using System.Xml.Linq;
using UtilityExtensions;

namespace CmsData
{
    public partial class Condition
    {
        private CMSDataContext db;
        private ParameterExpression parm;

        private FieldType FieldType { get { return Compare2.FieldType; } }
        private CompareType op { get { return Compare2.CompType; } }

        internal Expression GetExpression(ParameterExpression parm, CMSDataContext Db)
        {
            var expressionDictionary = new Dictionary<QueryType, Func<Expression>>()
            {
                { QueryType.AttendCntHistory, AttendCntHistory },
                { QueryType.AttendedAsOf, MemberAttendedAsOf },
                { QueryType.AttendMemberTypeAsOf, AttendMemberTypeAsOf },
                { QueryType.AttendPct, AttendPct },
                { QueryType.AttendPctHistory, AttendPctHistory },
                { QueryType.AttendTypeAsOf, AttendanceTypeAsOf },
                { QueryType.AttendTypeCodes, AttendTypeIds },
                { QueryType.Birthday, Birthday },
                { QueryType.CampusId, CampusId },
                { QueryType.CheckInByActivity, CheckInByActivity },
                { QueryType.CheckInByDate, CheckInByDate },
                { QueryType.CheckInVisits, CheckInVisits },
                { QueryType.ContributionAmount2, ContributionAmount },
                { QueryType.ContributionChange, ContributionChange },
                { QueryType.CreatedBy, CreatedBy },
                { QueryType.DaysAfterNthVisitDateRange, DaysAfterNthVisitDateRange },
                { QueryType.DaysBetween12Attendance, DaysBetween12Attendance },
                { QueryType.DaysSinceContact, DaysSinceContact },
                { QueryType.DaysTillAnniversary, DaysTillAnniversary },
                { QueryType.DaysTillBirthday, DaysTillBirthday },
                { QueryType.DuplicateEmails, DuplicateEmails },
                { QueryType.DuplicateNames, DuplicateNames },
                { QueryType.EmailRecipient, EmailRecipient },
                { QueryType.FamHasPrimAdultChurchMemb, FamHasPrimAdultChurchMemb },
                { QueryType.FamilyHasChildren, FamilyHasChildren },
                { QueryType.FamilyHasChildrenAged, FamilyHasChildrenAged },
                { QueryType.FamilyHasChildrenAged2, FamilyHasChildrenAged2 },
                { QueryType.FamilyHasChildrenAged3, FamilyHasChildrenAged3 },
                { QueryType.GuestAsOf, GuestAttendedAsOf },
                { QueryType.HasBalanceInCurrentOrg, HasBalanceInCurrentOrg },
                { QueryType.HasContacts, HasContacts },
                { QueryType.HasCurrentTag, HasCurrentTag },
                { QueryType.HasIncompleteTask, HasIncompleteTask },
                { QueryType.HasInvalidEmailAddress, HasInvalidEmailAddress },
                { QueryType.HasLowerName, HasLowerName },
                { QueryType.HasManagedGiving, HasManagedGiving },
                { QueryType.HasMemberDocs, HasMemberDocs },
                { QueryType.HasMyTag, HasMyTag },
                { QueryType.HasOptoutsForEmail, HasEmailOptout },
                { QueryType.HasParents, HasParents },
                { QueryType.HasPeopleExtraField, HasPeopleExtraField },
                { QueryType.HasPicture, HasPicture },
                { QueryType.HasRelatedFamily, HasRelatedFamily },
                { QueryType.HasTaskWithName, HasTaskWithName },
                { QueryType.HaveVolunteerApplications, HasVolunteerApplications },
                { QueryType.InactiveCurrentOrg, InactiveCurrentOrg },
                { QueryType.InBFClass, InBFClass },
                { QueryType.InCurrentOrg, InCurrentOrg },
                { QueryType.InOneOfMyOrgs, InOneOfMyOrgs },
                { QueryType.IsCurrentPerson, IsCurrentPerson },
                { QueryType.IsHeadOfHousehold, IsHeadOfHousehold },
                { QueryType.IsInactiveMemberOf, IsInactiveMemberOf },
                { QueryType.IsMemberOf, IsMemberOf },
                { QueryType.IsPendingMemberOf, IsPendingMemberOf },
                { QueryType.IsProspectOf, IsProspectOf },
                { QueryType.IsTopGiver, IsTopGiver },
                { QueryType.IsTopPledger, IsTopPledger },
                { QueryType.IsUser, IsUser },
                { QueryType.KidsRecentAttendCount, KidsRecentAttendCount },
                { QueryType.LeadersUnderCurrentOrg, LeadersUnderCurrentOrg },
                { QueryType.MadeContactTypeAsOf, MadeContactTypeAsOf },
                { QueryType.MatchAnything, MatchAnything },
                { QueryType.MedicalLength, MedicalLength },
                { QueryType.MeetingId, MeetingId },
                { QueryType.MembersUnderCurrentOrg, MembersUnderCurrentOrg },
                { QueryType.MemberTypeAsOf, MemberTypeAsOf },
                { QueryType.MemberTypeCodes, MemberTypeIds },
                { QueryType.MembOfOrgWithCampus, MembOfOrgWithCampus },
                { QueryType.MembOfOrgWithSched, MembOfOrgWithSched },
                { QueryType.NonTaxDedAmount, NonTaxDedAmount },
                { QueryType.NumberOfFamilyMembers, NumberOfFamilyMembers },
                { QueryType.NumberOfMemberships, NumberOfMemberships },
                { QueryType.NumberOfPrimaryAdults, NumberOfPrimaryAdults },
                { QueryType.OrgInactiveDate, OrgInactiveDate },
                { QueryType.OrgJoinDate, OrgJoinDate },
                { QueryType.OrgJoinDateCompare, OrgJoinDateCompare },
                { QueryType.OrgJoinDateDaysAgo, OrgJoinDateDaysAgo },
                { QueryType.PendingCurrentOrg, PendingCurrentOrg },
                { QueryType.PeopleExtra, PeopleExtra },
                { QueryType.PeopleExtraData, PeopleExtraData },
                { QueryType.PeopleExtraDate, PeopleExtraDate },
                { QueryType.PeopleExtraInt, PeopleExtraInt },
                { QueryType.PeopleIds, PeopleIds },
                { QueryType.PmmBackgroundCheckStatus, BackgroundCheckStatus },
                { QueryType.PreviousCurrentOrg, PreviousCurrentOrg },
                { QueryType.ProspectCurrentOrg, ProspectCurrentOrg },
                { QueryType.RecActiveOtherChurch, RecActiveOtherChurch },
                { QueryType.RecentAttendCount, RecentAttendCount },
                { QueryType.RecentAttendCountAttCred, RecentAttendCountAttCred },
                { QueryType.RecentAttendMemberType, RecentAttendMemberType },
                { QueryType.RecentAttendType, RecentAttendType },
                { QueryType.RecentBundleType, RecentBundleType },
                { QueryType.RecentContactMinistry, RecentContactMinistry },
                { QueryType.RecentContactReason, RecentContactReason },
                { QueryType.RecentContactType, RecentContactType },
                { QueryType.RecentContributionAmount, RecentContributionAmount },
                { QueryType.RecentContributionCount, RecentContributionCount },
                { QueryType.RecentCreated, RecentCreated },
                { QueryType.RecentDecisionType, RecentDecisionType },
                { QueryType.RecentEmailCount, RecentEmailCount },
                { QueryType.RecentFirstTimeGiver, RecentFirstTimeGiver },
                { QueryType.RecentGivingAsPctOfPrevious, RecentGivingAsPctOfPrevious },
                { QueryType.RecentHasIndContributions, RecentHasIndContributions },
                { QueryType.RecentJoinChurch, RecentJoinChurch },
                { QueryType.RecentNewVisitCount, RecentNewVisitCount },
                { QueryType.RecentNonTaxDedAmount, RecentNonTaxDedAmount },
                { QueryType.RecentNonTaxDedCount, RecentNonTaxDedCount },
                { QueryType.RecentPledgeAmount, RecentPledgeAmount },
                { QueryType.RecentPledgeCount, RecentPledgeCount },
                { QueryType.RecentRegistrationType, RecentRegistrationType },
                { QueryType.RecentVisitNumber, RecentVisitNumber },
                { QueryType.RecInterestedCoaching, RecInterestedCoaching },
                { QueryType.RegisteredForMeetingId, RegisteredForMeetingId },
                { QueryType.RelatedFamilyMembers, RelatedFamilyMembers },
                { QueryType.SavedQuery, SavedQuery2 },
                { QueryType.SmallGroup, SmallGroup },
                { QueryType.SpouseHasEmail, SpouseHasEmail },
                { QueryType.StatusFlag, StatusFlag },
                { QueryType.UserRole, UserRole },
                { QueryType.VisitedCurrentOrg, VisitedCurrentOrg },
                { QueryType.VisitNumber, VisitNumber },
                { QueryType.VolAppStatusCode, VolAppStatusCode },
                { QueryType.VolunteerApprovalCode, VolunteerApprovalCode },
                { QueryType.VolunteerProcessedDateMonthsAgo, VolunteerProcessedDateMonthsAgo },
                { QueryType.WasMemberAsOf, WasMemberAsOf },
                { QueryType.WeddingDate, WeddingDate },
                { QueryType.WidowedDate, WidowedDate },
            };
            this.parm = parm;
            this.db = Db;
            Func<Expression> f = null;
            if (expressionDictionary.TryGetValue(FieldInfo.QueryType, out f))
                return f();

            var IsMultiple = op == CompareType.OneOf || op == CompareType.NotOneOf;
            switch (FieldInfo.QueryType)
            {
                case QueryType.MemberStatusId:
                case QueryType.MaritalStatusId:
                case QueryType.GenderId:
                case QueryType.DropCodeId:
                case QueryType.JoinCodeId:
                    if (op == CompareType.IsNull || op == CompareType.IsNotNull)
                        return CompareConstant(ConditionName, -1);
                    return CompareConstant(ConditionName, IsMultiple ? (object)CodeIntIds : (object)CodeIds.ToInt());
                case QueryType.PrimaryAddress:
                case QueryType.PrimaryAddress2:
                case QueryType.PrimaryZip:
                case QueryType.PrimaryCountry:
                case QueryType.PrimaryCity:
                case QueryType.FirstName:
                case QueryType.MiddleName:
                case QueryType.MaidenName:
                case QueryType.NickName:
                case QueryType.CellPhone:
                case QueryType.WorkPhone:
                case QueryType.HomePhone:
                case QueryType.EmailAddress:
                case QueryType.EmailAddress2:
                    if (op == CompareType.IsNull || op == CompareType.IsNotNull)
                        return CompareConstant(ConditionName, null);
                    return CompareStringConstant(ConditionName, TextValue ?? "");
                default:
                    if (op == CompareType.IsNull || op == CompareType.IsNotNull)
                        return CompareConstant(ConditionName, null);
                    switch (FieldType)
                    {
                        case FieldType.NullBit:
                        case FieldType.Bit: return CompareConstant(ConditionName, CodeIds == "1");
                        case FieldType.Code: return CompareConstant(ConditionName, IsMultiple ? (object)CodeIntIds : (object)CodeIds.ToInt());
                        case FieldType.NullCode: return CompareCodeConstant(ConditionName, IsMultiple ? (object)CodeIntIds : (object)CodeIds.ToInt());
                        case FieldType.CodeStr: return CompareConstant(ConditionName, IsMultiple ? (object)CodeStrIds : (object)CodeIdValue);
                        case FieldType.String: return CompareConstant(ConditionName, TextValue);
                        case FieldType.Number:
                        case FieldType.NullNumber: return CompareConstant(ConditionName, decimal.Parse(TextValue));
                        case FieldType.Integer:
                        case FieldType.IntegerSimple:
                        case FieldType.NullInteger: return CompareIntConstant(ConditionName, TextValue);
                        case FieldType.Date:
                        case FieldType.DateSimple:
                            return CompareDateConstant(ConditionName, DateValue);
                        default:
                            throw new ArgumentException();
                    }
            }
        }
    }
}
