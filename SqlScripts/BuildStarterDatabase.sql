SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Creating schemata'
GO
CREATE SCHEMA [lookup]
AUTHORIZATION [dbo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
CREATE SCHEMA [disc]
AUTHORIZATION [dbo]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating CLR assemblies'
GO
--Assembly cmsdatasqlclr, version=0.0.0.0, culture=neutral, publickeytoken=null, processorarchitecture=msil
CREATE ASSEMBLY [CmsDataSqlClr]
AUTHORIZATION [dbo]
FROM 0x4d5a90000300000004000000ffff0000b800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000e1fba0e00b409cd21b8014ccd21546869732070726f6772616d2063616e6e6f742062652072756e20696e20444f53206d6f64652e0d0d0a2400000000000000\
504500004c010300b03652510000000000000000e00002210b010b00000a000000060000000000006e280000002000000040000000000010002000000002000004000000000000000400000000000000008000000002000000000000030040850000100000100000000010000010000000000000100000000000000000000000\
182800005300000000400000a003000000000000000000000000000000000000006000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002e74657874000000\
7408000000200000000a000000020000000000000000000000000000200000602e72737263000000a00300000040000000040000000c0000000000000000000000000000400000402e72656c6f6300000c0000000060000000020000001000000000000000000000000000004000004200000000000000000000000000000000\
50280000000000004800000002000500cc2000004c07000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001330020067000000010000110214280e00000a280f00000a281000000a2c0717281100000a2a0f00281200000a6f1300\
000a0a06281400000a2c0717281100000a2a720100007017731500000a0b729800007017731500000a0c07066f1600000a2d0908066f1600000a2b0117281100000a2a1e02281700000a2a0042534a4201000100000000000c00000076322e302e35303732370000000005006c0000001c020000237e000088020000e4020000\
23537472696e6773000000006c050000fc000000235553006806000010000000234755494400000078060000d400000023426c6f620000000000000002000001471502000900000000fa2533001600000100000013000000020000000200000001000000170000000b00000001000000010000000300000000000a0001000000\
0000060041003a000a00690054000a00740054000600a80096000600bf0096000600dc0096000600fb00960006001401960006002d01960006004801960006006301960006009b017c010600af0196000600e801c80106000802c8010a004f02340206008e023a000e00c702a8020e00cd02a802000000000100000000000100\
0100010010001c00000005000100010050200000000096007e000a000100c3200000000086188b001100020000000100910021008b00150029008b00150031008b00150039008b00150041008b00150049008b00150051008b00150059008b00150061008b001a0069008b00150071008b001f0079008b00110081008b001100\
190064022900190070022f0011007c023800110064023e0019008402440089009502440089009a02480091008b004d009100da02540009008b00110020006b0024002e002b0061002e00130074002e001b0074002e0023007a002e000b0061002e00330089002e003b0074002e004b0074002e005b00aa002e006300b3005900\
0480000001000000e112a87e000000000000260200000200000000000000000000000100310000000000020000000000000000000000010048000000000002000000000000000000000001003a00000000000000003c4d6f64756c653e00436d734461746153716c436c722e646c6c0055736572446566696e656446756e6374\
696f6e73006d73636f726c69620053797374656d004f626a6563740053797374656d2e446174610053797374656d2e446174612e53716c54797065730053716c426f6f6c65616e0053716c537472696e6700497356616c6964456d61696c002e63746f7200616464720053797374656d2e5265666c656374696f6e0041737365\
6d626c795469746c6541747472696275746500417373656d626c794465736372697074696f6e41747472696275746500417373656d626c79436f6e66696775726174696f6e41747472696275746500417373656d626c79436f6d70616e7941747472696275746500417373656d626c7950726f64756374417474726962757465\
00417373656d626c79436f7079726967687441747472696275746500417373656d626c7954726164656d61726b41747472696275746500417373656d626c7943756c747572654174747269627574650053797374656d2e52756e74696d652e496e7465726f70536572766963657300436f6d56697369626c6541747472696275\
746500417373656d626c7956657273696f6e4174747269627574650053797374656d2e52756e74696d652e436f6d70696c6572536572766963657300436f6d70696c6174696f6e52656c61786174696f6e734174747269627574650052756e74696d65436f6d7061746962696c69747941747472696275746500436d73446174\
6153716c436c72004d6963726f736f66742e53716c5365727665722e5365727665720053716c46756e6374696f6e417474726962757465006f705f496d706c69636974006f705f457175616c697479006f705f54727565006765745f56616c756500537472696e67005472696d0049734e756c6c4f72456d7074790053797374\
656d2e546578742e526567756c617245787072657373696f6e730052656765780052656765784f7074696f6e730049734d617463680000000080955e0028002e002a005c00620028003f003d005c007700290029005c0062005b0041002d005a0030002d0039002e005f0025002b002d005d002b0028003f003c003d005b005e\
002e005d00290040005b0041002d005a0030002d0039002e005f002d005d002b005c002e005b0041002d005a005d007b0032002c0034007d005c0062005c00620028003f0021005c0077002900240001635e005b0041002d005a0030002d0039002e005f0025002b002d005d002b0028003f003c003d005b005e002e005d0029\
0040005b0041002d005a0030002d0039002e002d005d002b005c002e005b0041002d005a005d007b0032002c0034007d00240001fbe92c52ccbc984bae3b736c1379237d0008b77a5c561934e0890600011109110d03200001042001010e042001010204200101080401000000050001110d0e0800021109110d110d05000102\
11090500011109020320000e040001020e062002010e114d042001020e0707030e124912491201000d436d734461746153716c436c7200000501000000000e0100094d6963726f736f667400002001001b436f7079726967687420c2a9204d6963726f736f6674203230313200000801000800000000001e0100010054021657\
7261704e6f6e457863657074696f6e5468726f77730100004028000000000000000000005e2800000020000000000000000000000000000000000000000000005028000000000000000000000000000000005f436f72446c6c4d61696e006d73636f7265652e646c6c0000000000ff2500200010000000000000000000000000\
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000480300000000000000000000480334000000560053005f00560045005200530049004f004e005f0049004e0046004f0000000000\
bd04effe0000010000000100a87ee11200000100a87ee1123f000000000000000400000002000000000000000000000000000000440000000100560061007200460069006c00650049006e0066006f00000000002400040000005400720061006e0073006c006100740069006f006e00000000000000b004a802000001005300\
7400720069006e006700460069006c00650049006e0066006f00000084020000010030003000300030003000340062003000000034000a00010043006f006d00700061006e0079004e0061006d006500000000004d006900630072006f0073006f0066007400000044000e000100460069006c00650044006500730063007200\
69007000740069006f006e000000000043006d0073004400610074006100530071006c0043006c007200000040000f000100460069006c006500560065007200730069006f006e000000000031002e0030002e0034003800330033002e00330032003400320034000000000044001200010049006e007400650072006e006100\
6c004e0061006d006500000043006d0073004400610074006100530071006c0043006c0072002e0064006c006c0000005c001b0001004c006500670061006c0043006f007000790072006900670068007400000043006f0070007900720069006700680074002000a90020004d006900630072006f0073006f00660074002000\
3200300031003200000000004c00120001004f0072006900670069006e0061006c00460069006c0065006e0061006d006500000043006d0073004400610074006100530071006c0043006c0072002e0064006c006c0000003c000e000100500072006f0064007500630074004e0061006d0065000000000043006d0073004400\
610074006100530071006c0043006c007200000044000f000100500072006f006400750063007400560065007200730069006f006e00000031002e0030002e0034003800330033002e00330032003400320034000000000048000f00010041007300730065006d0062006c0079002000560065007200730069006f006e000000\
31002e0030002e0034003800330033002e003300320034003200340000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
002000000c000000703800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

WITH PERMISSION_SET=SAFE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ProgDiv]'
GO
CREATE TABLE [dbo].[ProgDiv]
(
[ProgId] [int] NOT NULL,
[DivId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ProgDiv] on [dbo].[ProgDiv]'
GO
ALTER TABLE [dbo].[ProgDiv] ADD CONSTRAINT [PK_ProgDiv] PRIMARY KEY CLUSTERED  ([ProgId], [DivId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[People]'
GO
CREATE TABLE [dbo].[People]
(
[PeopleId] [int] NOT NULL IDENTITY(1, 1),
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NULL,
[DropCodeId] [int] NOT NULL,
[GenderId] [int] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_GENDER_ID] DEFAULT ((0)),
[DoNotMailFlag] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_DO_NOT_MAIL_FLAG] DEFAULT ((0)),
[DoNotCallFlag] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_DO_NOT_CALL_FLAG] DEFAULT ((0)),
[DoNotVisitFlag] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_DO_NOT_VISIT_FLAG] DEFAULT ((0)),
[AddressTypeId] [int] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_ADDRESS_TYPE_ID] DEFAULT ((10)),
[PhonePrefId] [int] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_PHONE_PREF_ID] DEFAULT ((10)),
[MaritalStatusId] [int] NOT NULL,
[PositionInFamilyId] [int] NOT NULL,
[MemberStatusId] [int] NOT NULL,
[FamilyId] [int] NOT NULL,
[BirthMonth] [int] NULL,
[BirthDay] [int] NULL,
[BirthYear] [int] NULL,
[OriginId] [int] NULL,
[EntryPointId] [int] NULL,
[InterestPointId] [int] NULL,
[BaptismTypeId] [int] NULL,
[BaptismStatusId] [int] NULL,
[DecisionTypeId] [int] NULL,
[NewMemberClassStatusId] [int] NULL,
[LetterStatusId] [int] NULL,
[JoinCodeId] [int] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_JOIN_CODE_ID] DEFAULT ((0)),
[EnvelopeOptionsId] [int] NULL,
[BadAddressFlag] [bit] NULL,
[ResCodeId] [int] NULL,
[AddressFromDate] [datetime] NULL,
[AddressToDate] [datetime] NULL,
[WeddingDate] [datetime] NULL,
[OriginDate] [datetime] NULL,
[BaptismSchedDate] [datetime] NULL,
[BaptismDate] [datetime] NULL,
[DecisionDate] [datetime] NULL,
[LetterDateRequested] [datetime] NULL,
[LetterDateReceived] [datetime] NULL,
[JoinDate] [datetime] NULL,
[DropDate] [datetime] NULL,
[DeceasedDate] [datetime] NULL,
[TitleCode] [nvarchar] (10) NULL,
[FirstName] [nvarchar] (25) NULL,
[MiddleName] [nvarchar] (30) NULL,
[MaidenName] [nvarchar] (20) NULL,
[LastName] [nvarchar] (100) NOT NULL,
[SuffixCode] [nvarchar] (10) NULL,
[NickName] [nvarchar] (25) NULL,
[AddressLineOne] [nvarchar] (100) NULL,
[AddressLineTwo] [nvarchar] (100) NULL,
[CityName] [nvarchar] (30) NULL,
[StateCode] [nvarchar] (30) NULL,
[ZipCode] [nvarchar] (15) NULL CONSTRAINT [DF_People_ZipCode] DEFAULT (''),
[CountryName] [nvarchar] (30) NULL,
[StreetName] [nvarchar] (40) NULL,
[CellPhone] [nvarchar] (20) NULL,
[WorkPhone] [nvarchar] (20) NULL,
[EmailAddress] [nvarchar] (150) NULL,
[OtherPreviousChurch] [nvarchar] (60) NULL,
[OtherNewChurch] [nvarchar] (60) NULL,
[SchoolOther] [nvarchar] (100) NULL,
[EmployerOther] [nvarchar] (120) NULL,
[OccupationOther] [nvarchar] (120) NULL,
[HobbyOther] [nvarchar] (40) NULL,
[SkillOther] [nvarchar] (40) NULL,
[InterestOther] [nvarchar] (40) NULL,
[LetterStatusNotes] [nvarchar] (3000) NULL,
[Comments] [nvarchar] (3000) NULL,
[ChristAsSavior] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_CHRIST_AS_SAVIOR] DEFAULT ((0)),
[MemberAnyChurch] [bit] NULL,
[InterestedInJoining] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_INTERESTED_IN_JOINING] DEFAULT ((0)),
[PleaseVisit] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_PLEASE_VISIT] DEFAULT ((0)),
[InfoBecomeAChristian] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_INFO_BECOME_A_CHRISTIAN] DEFAULT ((0)),
[ContributionsStatement] [bit] NOT NULL CONSTRAINT [DF_PEOPLE_TBL_CONTRIBUTIONS_STATEMENT] DEFAULT ((0)),
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[PictureId] [int] NULL,
[ContributionOptionsId] [int] NULL,
[PrimaryCity] [nvarchar] (30) NULL,
[PrimaryZip] [nvarchar] (15) NULL,
[PrimaryAddress] [nvarchar] (100) NULL,
[PrimaryState] [nvarchar] (20) NULL,
[HomePhone] [nvarchar] (20) NULL,
[SpouseId] [int] NULL,
[PrimaryAddress2] [nvarchar] (100) NULL,
[PrimaryResCode] [int] NULL,
[PrimaryBadAddrFlag] [int] NULL,
[LastContact] [datetime] NULL,
[Grade] [int] NULL,
[CellPhoneLU] [char] (7) NULL,
[WorkPhoneLU] [char] (7) NULL,
[BibleFellowshipClassId] [int] NULL,
[CampusId] [int] NULL,
[CellPhoneAC] [char] (3) NULL,
[CheckInNotes] [nvarchar] (1000) NULL,
[Age] AS ((datepart(year,isnull([DeceasedDate],getdate()))-[BirthYear])-case when [BirthMonth]>datepart(month,isnull([DeceasedDate],getdate())) OR [BirthMonth]=datepart(month,isnull([DeceasedDate],getdate())) AND [BirthDay]>datepart(day,isnull([DeceasedDate],getdate())) then (1) else (0) end),
[AltName] [nvarchar] (100) NULL,
[CustodyIssue] [bit] NULL,
[OkTransport] [bit] NULL,
[BDate] AS (dateadd(month,(([BirthYear]-(1900))*(12)+[BirthMonth])-(1),[Birthday]-(1))),
[HasDuplicates] [bit] NULL,
[FirstName2] [nvarchar] (50) NULL,
[EmailAddress2] [nvarchar] (60) NULL,
[SendEmailAddress1] [bit] NULL,
[SendEmailAddress2] [bit] NULL,
[NewMemberClassDate] [datetime] NULL,
[PrimaryCountry] [nvarchar] (30) NULL,
[ReceiveSMS] [bit] NOT NULL CONSTRAINT [DF_People_ReceiveSMS] DEFAULT ((0)),
[DoNotPublishPhones] [bit] NULL,
[IsDeceased] AS (CONVERT([bit],case when [DeceasedDate] IS NULL then (0) else (1) end,(0))),
[SSN] [nvarchar] (50) NULL,
[DLN] [nvarchar] (75) NULL,
[DLStateID] [int] NULL,
[HashNum] AS (checksum([FirstName]+[LastName])),
[PreferredName] AS (case when [Nickname]<>'' then [nickname] else [FirstName] end),
[Name2] AS ((([LastName]+', ')+case when [Nickname]<>'' then [nickname] else [FirstName] end)+case when len([SuffixCode])>(0) then ', '+[SuffixCode] else '' end),
[Name] AS (((case when [Nickname]<>'' then [nickname] else isnull([FirstName],'') end+' ')+[LastName])+case when len([SuffixCode])>(0) then ', '+[SuffixCode] else '' end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [_dta_index_People_c_9_1770345967__K1_K48] on [dbo].[People]'
GO
CREATE CLUSTERED INDEX [_dta_index_People_c_9_1770345967__K1_K48] ON [dbo].[People] ([PeopleId], [DeceasedDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PEOPLE_PK] on [dbo].[People]'
GO
ALTER TABLE [dbo].[People] ADD CONSTRAINT [PEOPLE_PK] PRIMARY KEY NONCLUSTERED  ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [_dta_index_People_6_1770345967__K92_K1_K98_49_53_54_130] on [dbo].[People]'
GO
CREATE NONCLUSTERED INDEX [_dta_index_People_6_1770345967__K92_K1_K98_49_53_54_130] ON [dbo].[People] ([ContributionOptionsId], [PeopleId], [SpouseId]) INCLUDE ([LastName], [SuffixCode], [TitleCode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [_dta_index_People_6_1770345967__K1_K92_50_55] on [dbo].[People]'
GO
CREATE NONCLUSTERED INDEX [_dta_index_People_6_1770345967__K1_K92_50_55] ON [dbo].[People] ([PeopleId], [ContributionOptionsId]) INCLUDE ([FirstName], [NickName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [PEOPLE_FAMILY_FK_IX] on [dbo].[People]'
GO
CREATE NONCLUSTERED INDEX [PEOPLE_FAMILY_FK_IX] ON [dbo].[People] ([FamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_PEOPLE_TBL] on [dbo].[People]'
GO
CREATE NONCLUSTERED INDEX [IX_PEOPLE_TBL] ON [dbo].[People] ([EmailAddress])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_People_2] on [dbo].[People]'
GO
CREATE NONCLUSTERED INDEX [IX_People_2] ON [dbo].[People] ([CellPhoneLU])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Organizations]'
GO
CREATE TABLE [dbo].[Organizations]
(
[OrganizationId] [int] NOT NULL IDENTITY(1, 1),
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[OrganizationStatusId] [int] NOT NULL,
[DivisionId] [int] NULL,
[LeaderMemberTypeId] [int] NULL,
[GradeAgeStart] [int] NULL,
[GradeAgeEnd] [int] NULL,
[RollSheetVisitorWks] [int] NULL,
[SecurityTypeId] [int] NOT NULL,
[FirstMeetingDate] [datetime] NULL,
[LastMeetingDate] [datetime] NULL,
[OrganizationClosedDate] [datetime] NULL,
[Location] [nvarchar] (200) NULL,
[OrganizationName] [nvarchar] (100) NOT NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[EntryPointId] [int] NULL,
[ParentOrgId] [int] NULL,
[AllowAttendOverlap] [bit] NOT NULL CONSTRAINT [DF_Organizations_AllowAttendOverlap] DEFAULT ((0)),
[MemberCount] [int] NULL,
[LeaderId] [int] NULL,
[LeaderName] [nvarchar] (50) NULL,
[ClassFilled] [bit] NULL,
[OnLineCatalogSort] [int] NULL,
[PendingLoc] [nvarchar] (40) NULL,
[CanSelfCheckin] [bit] NULL,
[NumCheckInLabels] [int] NULL,
[CampusId] [int] NULL,
[AllowNonCampusCheckIn] [bit] NULL,
[NumWorkerCheckInLabels] [int] NULL,
[ShowOnlyRegisteredAtCheckIn] [bit] NULL,
[Limit] [int] NULL,
[GenderId] [int] NULL,
[Description] [nvarchar] (max) NULL,
[BirthDayStart] [datetime] NULL,
[BirthDayEnd] [datetime] NULL,
[LastDayBeforeExtra] [datetime] NULL,
[RegistrationTypeId] [int] NULL,
[ValidateOrgs] [nvarchar] (60) NULL,
[PhoneNumber] [nvarchar] (25) NULL,
[RegistrationClosed] [bit] NULL,
[AllowKioskRegister] [bit] NULL,
[WorshipGroupCodes] [nvarchar] (100) NULL,
[IsBibleFellowshipOrg] [bit] NULL,
[NoSecurityLabel] [bit] NULL,
[AlwaysSecurityLabel] [bit] NULL,
[DaysToIgnoreHistory] [int] NULL,
[NotifyIds] [nvarchar] (50) NULL,
[lat] [float] NULL,
[long] [float] NULL,
[RegSetting] [nvarchar] (max) NULL,
[OrgPickList] [nvarchar] (300) NULL,
[Offsite] [bit] NULL,
[RegStart] [datetime] NULL,
[RegEnd] [datetime] NULL,
[LimitToRole] [nvarchar] (20) NULL,
[OrganizationTypeId] [int] NULL,
[MemberJoinScript] [nvarchar] (50) NULL,
[AddToSmallGroupScript] [nvarchar] (50) NULL,
[RemoveFromSmallGroupScript] [nvarchar] (50) NULL,
[SuspendCheckin] [bit] NULL,
[NoAutoAbsents] [bit] NULL,
[PublishDirectory] [int] NULL,
[ConsecutiveAbsentsThreshold] [int] NULL,
[IsRecreationTeam] [bit] NOT NULL CONSTRAINT [DF_Organizations_IsRecreationTeam] DEFAULT ((0)),
[VisitorDate] AS (CONVERT([datetime],dateadd(day, -(7)*isnull([RollSheetVisitorWks],(3)),CONVERT([date],getdate(),(0))),(0))),
[NotWeekly] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [ORGANIZATIONS_PK] on [dbo].[Organizations]'
GO
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [ORGANIZATIONS_PK] PRIMARY KEY NONCLUSTERED  ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Organizations_1] on [dbo].[Organizations]'
GO
CREATE NONCLUSTERED INDEX [IX_Organizations_1] ON [dbo].[Organizations] ([OrganizationStatusId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Organizations] on [dbo].[Organizations]'
GO
CREATE NONCLUSTERED INDEX [IX_Organizations] ON [dbo].[Organizations] ([DivisionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Meetings]'
GO
CREATE TABLE [dbo].[Meetings]
(
[MeetingId] [int] NOT NULL IDENTITY(1, 1),
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[OrganizationId] [int] NOT NULL,
[NumPresent] [int] NOT NULL CONSTRAINT [DF__MEETINGS___NUM_P__4D4B3A2F] DEFAULT ((0)),
[NumMembers] [int] NOT NULL CONSTRAINT [DF__MEETINGS___NUM_M__4F3382A1] DEFAULT ((0)),
[NumVstMembers] [int] NOT NULL CONSTRAINT [DF__MEETINGS___NUM_V__5027A6DA] DEFAULT ((0)),
[NumRepeatVst] [int] NOT NULL CONSTRAINT [DF__MEETINGS___NUM_R__511BCB13] DEFAULT ((0)),
[NumNewVisit] [int] NOT NULL CONSTRAINT [DF__MEETINGS___NUM_N__520FEF4C] DEFAULT ((0)),
[Location] [nvarchar] (40) NULL,
[MeetingDate] [datetime] NULL,
[GroupMeetingFlag] [bit] NOT NULL CONSTRAINT [DF__MEETINGS___GROUP__5AA5354D] DEFAULT ((0)),
[Description] [nvarchar] (100) NULL,
[NumOutTown] [int] NULL,
[NumOtherAttends] [int] NULL,
[AttendCreditId] [int] NULL,
[ScheduleId] AS ((datepart(weekday,[MeetingDate])*(10000)+datepart(hour,[MeetingDate])*(100))+datepart(minute,[MeetingDate])),
[NoAutoAbsents] [bit] NULL,
[HeadCount] [int] NULL,
[MaxCount] AS (case when [HeadCount]>[NumPresent] then [HeadCount] else [NumPresent] end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [MEETINGS_PK] on [dbo].[Meetings]'
GO
ALTER TABLE [dbo].[Meetings] ADD CONSTRAINT [MEETINGS_PK] PRIMARY KEY NONCLUSTERED  ([MeetingId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [MeetingDateOrgId] on [dbo].[Meetings]'
GO
CREATE NONCLUSTERED INDEX [MeetingDateOrgId] ON [dbo].[Meetings] ([MeetingDate]) INCLUDE ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_MEETINGS_ORG_ID] on [dbo].[Meetings]'
GO
CREATE NONCLUSTERED INDEX [IX_MEETINGS_ORG_ID] ON [dbo].[Meetings] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Meetings_MeetingDate] on [dbo].[Meetings]'
GO
CREATE NONCLUSTERED INDEX [IX_Meetings_MeetingDate] ON [dbo].[Meetings] ([MeetingDate] DESC)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DivOrg]'
GO
CREATE TABLE [dbo].[DivOrg]
(
[DivId] [int] NOT NULL,
[OrgId] [int] NOT NULL,
[id] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DivOrg] on [dbo].[DivOrg]'
GO
ALTER TABLE [dbo].[DivOrg] ADD CONSTRAINT [PK_DivOrg] PRIMARY KEY CLUSTERED  ([DivId], [OrgId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Attend]'
GO
CREATE TABLE [dbo].[Attend]
(
[PeopleId] [int] NOT NULL,
[MeetingId] [int] NOT NULL,
[OrganizationId] [int] NOT NULL,
[MeetingDate] [datetime] NOT NULL,
[AttendanceFlag] [bit] NOT NULL CONSTRAINT [DF_Attend_AttendanceFlag] DEFAULT ((0)),
[OtherOrgId] [int] NULL,
[AttendanceTypeId] [int] NULL,
[CreatedBy] [int] NULL,
[CreatedDate] [datetime] NULL,
[MemberTypeId] [int] NOT NULL,
[AttendId] [int] NOT NULL IDENTITY(1, 1),
[OtherAttends] [int] NOT NULL CONSTRAINT [DF_Attend_OtherAttends] DEFAULT ((0)),
[BFCAttendance] [bit] NULL,
[Registered] [bit] NULL,
[EffAttendFlag] AS (CONVERT([bit],case when [AttendanceTypeId]=(90) then NULL when [AttendanceTypeId]=(70) AND [OtherAttends]>(0) then (1) when [OtherAttends]>(0) AND [BFCAttendance]=(1) then NULL when [AttendanceFlag]=(1) then (1) when [OtherAttends]>(0) then NULL else (0) end,(0))),
[SeqNo] [int] NULL,
[Commitment] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [AttendanceFlagIndex] on [dbo].[Attend]'
GO
CREATE NONCLUSTERED INDEX [AttendanceFlagIndex] ON [dbo].[Attend] ([AttendanceFlag]) INCLUDE ([MeetingDate], [OrganizationId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IDX_AttendAttendanceFlagMeetingDate] on [dbo].[Attend]'
GO
CREATE NONCLUSTERED INDEX [IDX_AttendAttendanceFlagMeetingDate] ON [dbo].[Attend] ([AttendanceFlag], [MeetingDate]) INCLUDE ([MeetingId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Attend_3] on [dbo].[Attend]'
GO
CREATE NONCLUSTERED INDEX [IX_Attend_3] ON [dbo].[Attend] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Attend_4] on [dbo].[Attend]'
GO
CREATE NONCLUSTERED INDEX [IX_Attend_4] ON [dbo].[Attend] ([MeetingId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Attend] on [dbo].[Attend]'
GO
CREATE NONCLUSTERED INDEX [IX_Attend] ON [dbo].[Attend] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Attend_1] on [dbo].[Attend]'
GO
CREATE NONCLUSTERED INDEX [IX_Attend_1] ON [dbo].[Attend] ([MeetingDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Attend] on [dbo].[Attend]'
GO
ALTER TABLE [dbo].[Attend] ADD CONSTRAINT [PK_Attend] PRIMARY KEY NONCLUSTERED  ([AttendId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAttendInDaysByCount]'
GO
CREATE FUNCTION [dbo].[RecentAttendInDaysByCount]( 
	@progid INT,
	@divid INT,
	@org INT,
	@orgtype INT,
	@days INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		p.PeopleId, 
		(SELECT COUNT(*)
			FROM dbo.Attend a
			JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE 1 = 1
			AND  AttendanceFlag = 1
			AND a.PeopleId = p.PeopleId
			AND a.MeetingDate > DATEADD(dd, -@days, GETDATE())
			AND (@orgtype = 0 OR o.OrganizationTypeId = @orgtype)
			AND (ISNULL(@org, 0) = 0 OR m.OrganizationId = @org)
			AND (ISNULL(@divid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = m.OrganizationId AND DivId = @divid))
			AND (ISNULL(@progid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg dd WHERE dd.OrgId = m.OrganizationId
						AND EXISTS(SELECT NULL FROM dbo.ProgDiv pp WHERE pp.DivId = dd.DivId AND pp.ProgId = @progid)))
		) Cnt
	FROM dbo.People p
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CoupleFlag]'
GO
-- =============================================
-- Author:		Kenny
-- Create date: 4/17/2008
-- Description:	Finds the Couple Flag given a family ID
-- This flag is used for figuring out how mailings should
-- be addressed (see codes below)
-- =============================================

CREATE FUNCTION [dbo].[CoupleFlag] 
(
	@family_id int
)

-- Returns:
--  0 - Individual
--  1 - Couple
--  2 - Couple + Family
--  3 - Single Parent + Family
--  4 - No Primary Family

RETURNS int
AS
BEGIN
	DECLARE @Result int

    SELECT top 1 @Result = 
        case (sum(case PositionInFamilyId when 10 then 1 else 0 end))
            when 2 then (case count(*) when 2 then (case min(MaritalStatusId) when 30 then (CASE MAX(MaritalStatusId) WHEN 30 THEN 1 ELSE 4 end) else 4 end) else 2 end)
            when 1 then (case count(*) when 1 then 0 else 3 end)
            else (case count(*) when 1 then 0 else 4 end)
        end
      FROM dbo.People
     WHERE FamilyId = @family_id
       AND DeceasedDate IS NULL
       AND FirstName <> 'Duplicate'

	-- Return the result of the function
	RETURN @Result

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Split]'
GO
CREATE Function [dbo].[Split](
   @InputText nvarchar(4000), -- The text to be split into rows
      @Delimiter nvarchar(10)) -- The delimiter that separates tokens   .
                           -- Can be multiple characters, or empty

RETURNS @Array TABLE (
   TokenID Int PRIMARY KEY IDENTITY(1   ,1), --Comment out this line if
                                             -- you don't want the
                                          -- identity column
   Value nvarchar(4000))

AS

-----------------------------------------------------------
-- Function Split                                        --
--    â€¢ Returns a nvarchar rowset from a delimited string --
-----------------------------------------------------------

BEGIN

   DECLARE
      @Pos Int,        -- Start of token or ch      aracter
      @End Int,        -- End of token
      @TextLength Int, -- Length of input text
      @DelimLength Int -- Length of delimiter

-- Len ignores trailing spaces, thus t   he use of DataLength.
-- Note: if you switch to NVarchar input and out   put, you'll need    to divide by 2.
   SET @TextLength = DataLength(@InputText) / 2

-- Exit function if no text is passed in   
   IF @TextLength = 0 RETURN

         SET @Pos = 1
   SET @DelimLength = DataLength(@Delimiter) / 2

            IF @DelimLength = 0          BEGIN -- Each character in its own row
      WHILE @Pos <= @TextLength BEGIN
         INSERT @Array (Value) VALUES (SubString(@InputText,@Pos,1))
               SET @Pos = @Pos + 1
      END
   END
         ELSE BEGIN
      -- Tack on delimiter to 'see' the last token
      SET @InputText = @InputText + @Delimiter
      -- Find the end character of the first token
      SET @End = CharIndex(@Delimiter, @InputText)
      WHILE @End > 0 BEGIN         
         -- End > 0, a delimiter was found: there is a(nother) token
         INSERT @Array (Value) VALUES (SubString(@InputText, @Pos, @End - @Pos))
         -- Set next search to start after the previous token
         SET @Pos = @End + @DelimLength
         -- Find the end character of the next token
         SET @End = CharIndex(@Delimiter, @InputText, @Pos)
      END
   END
   
   RETURN

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AddressMatch]'
GO
CREATE FUNCTION [dbo].[AddressMatch]
	(
	@var1 nvarchar ,@var2 nvarchar
	)
RETURNS int
AS
	BEGIN

-----------------------------------------------------------

-- Function Address --

-- â€¢ Matches street name

-----------------------------------------------------------

BEGIN

DECLARE

@a nvarchar(100), -- street name in var1

@b nvarchar(100), -- street name in var2

@c nvarchar(100), -- street name in var1

@d nvarchar(100), -- street name in var2

@e nvarchar(100), -- street name in var1

@f nvarchar(100), -- street name in var2

@i char(1),

@j char(1),

@k char(1),

@var1Tokens int,

@var2Tokens int,

@var1Plus int,

@var2Plus int

set @var1Plus = 0

set @var2Plus = 0

select @var1tokens = TokenID from dbo.Split(@var1, ' ')

select @var2tokens = TokenID from dbo.Split(@var2, ' ')

set @k = '0'

select @a = Value from dbo.Split(@var1, ' ') where TokenID = 1

select @b = Value from dbo.Split(@var2, ' ') where TokenID = 1

if @a = @b set @k = '1'

select @c = value from dbo.Split(@var1, ' ') where TokenID = 2

select @d = Value from dbo.Split(@var2, ' ') where TokenID = 2

set @i = Convert(nvarchar, difference(@c, @d))

if Convert(int, @i) < 3 begin

if @var1tokens > 3 begin

-- select @c = @c + ' ' + value from dbo.Split(@var1, ' ') where TokenID = 3

select @c = value from dbo.Split(@var1, ' ') where TokenID = 3

set @var1Plus = 1

end

if @var2tokens > 3 begin

-- select @d = @d + ' ' + Value from dbo.Split(@var2, ' ') where TokenID = 3

select @d = value from dbo.Split(@var1, ' ') where TokenID = 3

set @var2Plus = 1

end

set @i = Convert(nvarchar, difference(@c, @d))

end

select @e = Value from dbo.Split(@var1, ' ') where TokenID = 3 + @var1Plus

select @f = Value from dbo.Split(@var2, ' ') where TokenID = 3 + @var2Plus

if @e is null or @f is null or @e = '' or @f = ''

set @j = '4'

else

set @j = Convert(nvarchar, difference(@e, @f))

RETURN Convert(int, (@k + @i + @j))

END
	END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Birthday]'
GO
CREATE FUNCTION [dbo].[Birthday](@pid int)
RETURNS DATETIME
AS
BEGIN
	
	DECLARE
		@dt DATETIME, 
		@m int,
		@d int,
		@y int
    SET @dt = NULL
		
	select @m = BirthMonth, @d = BirthDay, @y = BirthYear from dbo.People where @pid = PeopleId
	IF NOT (@m IS NULL OR @y IS NULL OR @d IS NULL)
	    SET @dt = dateadd(month,((@y-1900)*12)+@m-1,@d-1)
	RETURN @dt
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetEldestFamilyMember]'
GO
CREATE FUNCTION [dbo].[GetEldestFamilyMember]( @fid int )
RETURNS int
AS
BEGIN
    DECLARE @Result int

    select @Result = PeopleId
      from dbo.People
     where FamilyId = @fid
       and dbo.Birthday(PeopleId) = (select min(dbo.Birthday(PeopleId))
                    from dbo.People
                   where FamilyId = @fid)
                   
    IF @Result IS NULL
		SELECT TOP 1 @Result = PeopleId FROM dbo.People WHERE FamilyId = @fid
     
	RETURN @Result
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[HeadOfHouseholdId]'
GO

CREATE FUNCTION [dbo].[HeadOfHouseholdId] ( @family_id INT )
RETURNS INT
AS 
    BEGIN
        DECLARE @Result INT

        SELECT TOP 1 @Result = PeopleId FROM dbo.People
		WHERE FamilyId = @family_id
		ORDER BY 
			DeceasedDate,
			PositionInFamilyId, 
			CASE PositionInFamilyId WHEN 10 THEN GenderId ELSE 0 END, 
			Age DESC
		
        RETURN @Result

    END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SpouseIdJoint]'
GO
CREATE FUNCTION [dbo].[SpouseIdJoint] 
(
	@peopleid int
)
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT TOP 1 @Result = s.PeopleId FROM dbo.People p
	JOIN dbo.People s ON s.FamilyId = p.FamilyId
	WHERE s.PeopleId <> @peopleid AND p.PeopleId = @peopleid
	AND p.MaritalStatusId = 20
	AND s.MaritalStatusId = 20
	AND s.DeceasedDate IS NULL
	AND p.DeceasedDate IS NULL
	AND p.PositionInFamilyId = s.PositionInFamilyId
	AND s.ContributionOptionsId = 2
	AND p.ContributionOptionsId = 2
	
	RETURN @Result

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UEmail]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UEmail] (@pid int)
RETURNS nvarchar(100)
AS
BEGIN
	-- Declare the return variable here
	declare @email nvarchar(100)
	
	SELECT  @email = EmailAddress
	FROM         dbo.People
	WHERE     PeopleId = @pid

	return @email

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Users]'
GO
CREATE TABLE [dbo].[Users]
(
[UserId] [int] NOT NULL IDENTITY(1, 1),
[PeopleId] [int] NULL,
[Username] [nvarchar] (50) NOT NULL,
[Comment] [nvarchar] (255) NULL,
[Password] [nvarchar] (128) NOT NULL,
[PasswordQuestion] [nvarchar] (255) NULL,
[PasswordAnswer] [nvarchar] (255) NULL,
[IsApproved] [bit] NOT NULL CONSTRAINT [DF_Users_IsApproved] DEFAULT ((0)),
[LastActivityDate] [datetime] NULL,
[LastLoginDate] [datetime] NULL,
[LastPasswordChangedDate] [datetime] NULL,
[CreationDate] [datetime] NULL,
[IsLockedOut] [bit] NOT NULL CONSTRAINT [DF_Users_IsLockedOut] DEFAULT ((0)),
[LastLockedOutDate] [datetime] NULL,
[FailedPasswordAttemptCount] [int] NOT NULL CONSTRAINT [DF_Users_FailedPasswordAttemptCount] DEFAULT ((0)),
[FailedPasswordAttemptWindowStart] [datetime] NULL,
[FailedPasswordAnswerAttemptCount] [int] NOT NULL CONSTRAINT [DF_Users_FailedPasswordAnswerAttemptCount] DEFAULT ((0)),
[FailedPasswordAnswerAttemptWindowStart] [datetime] NULL,
[EmailAddress] AS ([dbo].[UEmail]([PeopleId])),
[ItemsInGrid] [int] NULL,
[CurrentCart] [nvarchar] (100) NULL,
[MustChangePassword] [bit] NOT NULL CONSTRAINT [DF_Users_MustChangePassword] DEFAULT ((0)),
[Host] [nvarchar] (100) NULL,
[TempPassword] [nvarchar] (128) NULL,
[Name] [nvarchar] (50) NULL,
[Name2] [nvarchar] (50) NULL,
[ResetPasswordCode] [uniqueidentifier] NULL,
[DefaultGroup] [nvarchar] (50) NULL,
[ResetPasswordExpires] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Users_1] on [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [PK_Users_1] PRIMARY KEY CLUSTERED  ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SpouseId]'
GO
CREATE FUNCTION [dbo].[SpouseId] 
(
	@peopleid int
)
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT TOP 1 @Result = s.PeopleId FROM dbo.People p
	JOIN dbo.People s ON s.FamilyId = p.FamilyId
	WHERE s.PeopleId <> @peopleid AND p.PeopleId = @peopleid
	AND p.MaritalStatusId = 20
	AND s.MaritalStatusId = 20
	AND s.DeceasedDate IS NULL
	AND p.DeceasedDate IS NULL
	AND p.PositionInFamilyId = s.PositionInFamilyId
	AND s.FirstName <> 'Duplicate'	-- Return the result of the function
	
	RETURN @Result

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[HeadOfHouseHoldSpouseId]'
GO

CREATE FUNCTION [dbo].[HeadOfHouseHoldSpouseId] 
(
	@family_id int
)

RETURNS int
AS
BEGIN
	DECLARE @Result int

    SELECT @Result = 
           dbo.SpouseId(dbo.HeadOfHouseholdId(@family_id))

	-- Return the result of the function
	RETURN @Result

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetDigits]'
GO
CREATE Function [dbo].[GetDigits](@Str nvarchar(500))
Returns nvarchar(500)
AS
Begin
	While PatIndex('%[^0-9]%', @Str) > 0
	     Set @Str = Stuff(@Str, PatIndex('%[^0-9]%', @Str), 1, '')
	RETURN @Str 
End
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Families]'
GO
CREATE TABLE [dbo].[Families]
(
[FamilyId] [int] NOT NULL IDENTITY(1, 1),
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NULL,
[RecordStatus] [bit] NOT NULL CONSTRAINT [DF_FAMILIES_TBL_RECORD_STATUS] DEFAULT ((0)),
[BadAddressFlag] [bit] NULL,
[AltBadAddressFlag] [bit] NULL,
[ResCodeId] [int] NULL,
[AltResCodeId] [int] NULL,
[AddressFromDate] [datetime] NULL,
[AddressToDate] [datetime] NULL,
[AddressLineOne] [nvarchar] (100) NULL,
[AddressLineTwo] [nvarchar] (100) NULL,
[CityName] [nvarchar] (30) NULL,
[StateCode] [nvarchar] (30) NULL,
[ZipCode] [nvarchar] (15) NULL CONSTRAINT [DF_Families_ZipCode] DEFAULT (''),
[CountryName] [nvarchar] (30) NULL,
[StreetName] [nvarchar] (40) NULL,
[HomePhone] [nvarchar] (20) NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[HeadOfHouseholdId] [int] NULL,
[HeadOfHouseholdSpouseId] [int] NULL,
[CoupleFlag] [int] NULL,
[HomePhoneLU] [char] (7) NULL,
[HomePhoneAC] [char] (3) NULL,
[Comments] [nvarchar] (3000) NULL,
[PictureId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [FAMILIES_PK] on [dbo].[Families]'
GO
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FAMILIES_PK] PRIMARY KEY NONCLUSTERED  ([FamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Families] on [dbo].[Families]'
GO
CREATE NONCLUSTERED INDEX [IX_Families] ON [dbo].[Families] ([HomePhoneLU])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FindPerson]'
GO
CREATE FUNCTION [dbo].[FindPerson](@first nvarchar(25), @last nvarchar(50), @dob DATETIME, @email nvarchar(60), @phone nvarchar(15))
RETURNS @t TABLE ( PeopleId INT)
AS
BEGIN
--DECLARE @t TABLE ( PeopleId INT)
--DECLARE @first nvarchar(25) = 'Beth', 
--		@last nvarchar(50) = 'Marcus', 
--		@dob DATETIME = '1/29/2013', 
--		@email nvarchar(60) = 'b@b.com', 
--		@phone nvarchar(15) = '9017581862'
		
	DECLARE @fname nvarchar(50) = REPLACE(@first,' ', '')
	SET @dob = CASE WHEN @dob = '' THEN NULL ELSE @dob END
	
	DECLARE @m INT = DATEPART(m, @dob)
	DECLARE @d INT = DATEPART(d, @dob)
	DECLARE @y INT = DATEPART(yy, @dob)
	
	DECLARE @mm TABLE ( PeopleId INT, Matches INT )
	SET @phone = dbo.GetDigits(@phone)
	
	INSERT INTO @mm
	SELECT PeopleId, -- col 1
	(
		CASE WHEN (ISNULL(@email, '') = '' AND ISNULL(@phone, '') = '' AND @dob IS NULL)
		OR (p.EmailAddress = @email AND LEN(@email) > 0)
		OR (p.EmailAddress2 = @email AND LEN(@email) > 0) 
		THEN 1 ELSE 0 END 
		+
		CASE WHEN (f.HomePhone = @phone AND LEN(@phone) > 0)
		OR (CellPhone = @phone AND LEN(@phone) > 0)
		THEN 1 ELSE 0 END 
		+
		CASE WHEN (BirthDay = @d AND BirthMonth = @m AND ABS(BirthYear - @y) <= 1)
		OR (BirthDay = @d AND BirthMonth = @m AND BirthYear IS NULL)
		THEN 1 ELSE 0 END
	) matches -- col 2
	FROM dbo.People p
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	WHERE
	(
		   @fname = FirstName
		OR @fname = NickName
		OR FirstName2 LIKE (@fname + '%')
		OR @fname LIKE (FirstName + '%')
	)
	AND (@last = LastName OR @last = MaidenName OR @last = MiddleName)
	
	
	--SELECT p.PeopleId, Matches, Name, BirthMonth, BirthDay, BirthYear, EmailAddress, CellPhone FROM @mm
	--JOIN dbo.People p ON [@mm].PeopleId = p.PeopleId
	
	INSERT INTO @t
	SELECT PeopleId FROM @mm m1
	WHERE m1.Matches = (SELECT MAX(Matches) FROM @mm) AND m1.Matches > 0
	ORDER BY Matches DESC
	
	--SELECT * FROM @t
	
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[VolunteerForm]'
GO
CREATE TABLE [dbo].[VolunteerForm]
(
[PeopleId] [int] NOT NULL,
[AppDate] [datetime] NULL,
[LargeId] [int] NULL,
[MediumId] [int] NULL,
[SmallId] [int] NULL,
[Id] [int] NOT NULL IDENTITY(1, 1),
[UploaderId] [int] NULL,
[IsDocument] [bit] NULL,
[Name] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolunteerForm] on [dbo].[VolunteerForm]'
GO
ALTER TABLE [dbo].[VolunteerForm] ADD CONSTRAINT [PK_VolunteerForm] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_VolunteerForm] on [dbo].[VolunteerForm]'
GO
CREATE NONCLUSTERED INDEX [IX_VolunteerForm] ON [dbo].[VolunteerForm] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserRole]'
GO
CREATE TABLE [dbo].[UserRole]
(
[UserId] [int] NOT NULL,
[RoleId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UserRole] on [dbo].[UserRole]'
GO
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED  ([UserId], [RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Preferences]'
GO
CREATE TABLE [dbo].[Preferences]
(
[UserId] [int] NOT NULL,
[Preference] [nvarchar] (30) NOT NULL,
[Value] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UserPreferences] on [dbo].[Preferences]'
GO
ALTER TABLE [dbo].[Preferences] ADD CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED  ([UserId], [Preference])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Coupons]'
GO
CREATE TABLE [dbo].[Coupons]
(
[Id] [nvarchar] (50) NOT NULL,
[Created] [datetime] NOT NULL CONSTRAINT [DF_Coupons_Created] DEFAULT (getdate()),
[Used] [datetime] NULL,
[Canceled] [datetime] NULL,
[Amount] [money] NULL,
[DivId] [int] NULL,
[OrgId] [int] NULL,
[PeopleId] [int] NULL,
[Name] [nvarchar] (80) NULL,
[UserId] [int] NULL,
[RegAmount] [money] NULL,
[DivOrg] AS (case when [divid] IS NOT NULL then 'div.'+CONVERT([nvarchar],[divid],(0)) else 'org.'+CONVERT([nvarchar],[orgid],(0)) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Coupons] on [dbo].[Coupons]'
GO
ALTER TABLE [dbo].[Coupons] ADD CONSTRAINT [PK_Coupons] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Coupons] on [dbo].[Coupons]'
GO
CREATE NONCLUSTERED INDEX [IX_Coupons] ON [dbo].[Coupons] ([Created] DESC)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Coupons_1] on [dbo].[Coupons]'
GO
CREATE NONCLUSTERED INDEX [IX_Coupons_1] ON [dbo].[Coupons] ([DivId], [OrgId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ActivityLog]'
GO
CREATE TABLE [dbo].[ActivityLog]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[ActivityDate] [datetime] NULL,
[UserId] [int] NULL,
[Activity] [nvarchar] (200) NULL,
[PageUrl] [nvarchar] (410) NULL,
[Machine] [nvarchar] (50) NULL,
[OrgId] [int] NULL,
[PeopleId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_alog] on [dbo].[ActivityLog]'
GO
ALTER TABLE [dbo].[ActivityLog] ADD CONSTRAINT [PK_alog] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ActivityLog] on [dbo].[ActivityLog]'
GO
CREATE NONCLUSTERED INDEX [IX_ActivityLog] ON [dbo].[ActivityLog] ([UserId], [ActivityDate] DESC)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PurgeUser]'
GO
CREATE PROCEDURE [dbo].[PurgeUser](@uid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE dbo.UserRole
	FROM dbo.UserRole ur
	JOIN dbo.Users u ON u.UserId = ur.UserId
	WHERE u.UserId = @uid
	
	DELETE dbo.ActivityLog
	FROM dbo.ActivityLog a
	JOIN dbo.Users u ON a.UserId = u.UserId
	WHERE u.UserId = @uid
	
	delete dbo.Preferences
	from dbo.Preferences p
	join dbo.Users u on u.UserId = p.UserId
	where u.UserId = @uid
	
	DELETE dbo.VolunteerForm
	FROM dbo.VolunteerForm vf
	JOIN dbo.Users u ON vf.UploaderId = u.UserId
	WHERE u.UserId = @uid
	
	DELETE dbo.Coupons
	FROM dbo.Coupons c
	JOIN dbo.Users u ON c.UserId = u.UserId
	WHERE u.UserId = @uid
	
	DELETE dbo.Users
	WHERE UserId = @uid
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[AttendType]'
GO
CREATE TABLE [lookup].[AttendType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_AttendType] on [lookup].[AttendType]'
GO
ALTER TABLE [lookup].[AttendType] ADD CONSTRAINT [PK_AttendType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendDesc]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[AttendDesc](@id int) 
RETURNS nvarchar(100)
AS
BEGIN
	DECLARE @ret nvarchar(100)
	SELECT @ret =  Description FROM lookup.AttendType WHERE id = @id
	RETURN @ret
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SpaceToNull]'
GO
CREATE FUNCTION [dbo].[SpaceToNull](@s nvarchar(MAX))
RETURNS nvarchar(MAX)
AS
BEGIN
	
	IF @s IS NULL
		RETURN NULL
	IF LEN(@s) = 0
		RETURN NULL
	RETURN @s;
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FindPerson2]'
GO
CREATE FUNCTION [dbo].[FindPerson2](@first nvarchar(25), @goesby nvarchar(50), @last nvarchar(50), @m INT, @d INT, @y INT, @email nvarchar(60), @email2 nvarchar(60), @phone1 nvarchar(15), @phone2 nvarchar(15), @phone3 nvarchar(15))
RETURNS @t TABLE ( PeopleId INT)
AS
BEGIN
	DECLARE @fname nvarchar(50) = REPLACE(@first,' ', '')
	
	SET @phone1 = dbo.SpaceToNull(@phone1)
	SET @phone2 = dbo.SpaceToNull(@phone2)
	SET @phone3 = dbo.SpaceToNull(@phone3)
	SET @email = dbo.SpaceToNull(@email)
	SET @email2 = dbo.SpaceToNull(@email2)
	SET @goesby = dbo.SpaceToNull(@goesby)
	
	INSERT INTO @t SELECT PeopleId FROM dbo.People p
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	WHERE
	(
		FirstName2 LIKE (@fname + '%')
		OR @fname LIKE (FirstName + '%')
		OR @fname = NickName
		OR @fname IS NULL
		OR FirstName2 LIKE (@goesby + '%')		
		OR @goesby LIKE (FirstName + '%		')
		OR @goesby = NickName
	)
	AND (@last = LastName OR @last = MaidenName OR @last = MiddleName OR @last IS NULL)
	AND
	(
		p.EmailAddress = @email
		OR p.EmailAddress2 = @email
		OR p.EmailAddress = @email2
		OR p.EmailAddress2 = @email2
		OR f.HomePhone = @phone1
		OR CellPhone = @phone1
		OR WorkPhone = @phone1
		OR f.HomePhone = @phone2		
		OR CellPhone = @phone2
		OR WorkPhone = @phone2
		OR f.HomePhone = @phone3				
		OR CellPhone = @phone3
		OR WorkPhone = @phone3
		OR (BirthDay = @d AND BirthMonth = @m AND BirthYear = @y)
	)
	AND
	(
		BirthDay IS NULL
		OR (BirthDay = @d AND BirthMonth = @m AND (ABS(BirthYear - @y) <= 1 OR @y IS NULL OR BirthYear IS NULL))
	)
		
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryCountry]'
GO
CREATE FUNCTION [dbo].[PrimaryCountry] ( @pid int )
RETURNS nvarchar(30)
AS
	BEGIN
declare @n nvarchar(30)
select @n =
	case AddressTypeId
			when 10 then f.CountryName
			when 30 then p.CountryName
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @n
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TagPerson]'
GO
CREATE TABLE [dbo].[TagPerson]
(
[Id] [int] NOT NULL,
[PeopleId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TagPeople] on [dbo].[TagPerson]'
GO
ALTER TABLE [dbo].[TagPerson] ADD CONSTRAINT [PK_TagPeople] PRIMARY KEY CLUSTERED  ([Id], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_TagPerson] on [dbo].[TagPerson]'
GO
CREATE NONCLUSTERED INDEX [IX_TagPerson] ON [dbo].[TagPerson] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UName]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UName] (@pid int)
RETURNS nvarchar(100)
AS
BEGIN
	-- Declare the return variable here
	declare @name nvarchar(100)
	
	SELECT  @name = (case when [Nickname]<>'' then [nickname] else [FirstName] end) + ' ' + [LastName]
	FROM         dbo.People
	WHERE     PeopleId = @pid

	return @name

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Tag]'
GO
CREATE TABLE [dbo].[Tag]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (200) NOT NULL,
[TypeId] [int] NOT NULL CONSTRAINT [DF_Tag_TypeId] DEFAULT ((1)),
[Owner] [nvarchar] (50) NULL,
[Active] [bit] NULL,
[PeopleId] [int] NULL,
[OwnerName] AS ([dbo].[UName]([PeopleId]))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Tag] on [dbo].[Tag]'
GO
ALTER TABLE [dbo].[Tag] ADD CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Tag] on [dbo].[Tag]'
GO
CREATE NONCLUSTERED INDEX [IX_Tag] ON [dbo].[Tag] ([TypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Roles]'
GO
CREATE TABLE [dbo].[Roles]
(
[RoleName] [nvarchar] (50) NULL,
[RoleId] [int] NOT NULL IDENTITY(1, 1),
[hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Roles] on [dbo].[Roles]'
GO
ALTER TABLE [dbo].[Roles] ADD CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED  ([RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Roles] on [dbo].[Roles]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Roles] ON [dbo].[Roles] ([RoleName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationMembers]'
GO
CREATE TABLE [dbo].[OrganizationMembers]
(
[OrganizationId] [int] NOT NULL,
[PeopleId] [int] NOT NULL,
[CreatedBy] [int] NULL,
[CreatedDate] [datetime] NULL,
[MemberTypeId] [int] NOT NULL,
[EnrollmentDate] [datetime] NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[InactiveDate] [datetime] NULL,
[AttendStr] [nvarchar] (200) NULL,
[AttendPct] [real] NULL,
[LastAttended] [datetime] NULL,
[Pending] [bit] NULL,
[UserData] [nvarchar] (max) NULL,
[Amount] [money] NULL,
[Request] [nvarchar] (140) NULL,
[ShirtSize] [nvarchar] (20) NULL,
[Grade] [int] NULL,
[Tickets] [int] NULL,
[Moved] [bit] NULL,
[RegisterEmail] [nvarchar] (80) NULL,
[AmountPaid] [money] NULL,
[PayLink] [nvarchar] (100) NULL,
[TranId] [int] NULL,
[Score] [int] NOT NULL CONSTRAINT [DF_OrganizationMembers_Score] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [ORGANIZATION_MEMBERS_PK] on [dbo].[OrganizationMembers]'
GO
ALTER TABLE [dbo].[OrganizationMembers] ADD CONSTRAINT [ORGANIZATION_MEMBERS_PK] PRIMARY KEY NONCLUSTERED  ([OrganizationId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [ORGANIZATION_MEMBERS_PPL_FK_IX] on [dbo].[OrganizationMembers]'
GO
CREATE NONCLUSTERED INDEX [ORGANIZATION_MEMBERS_PPL_FK_IX] ON [dbo].[OrganizationMembers] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[NextBirthday]'
GO
CREATE FUNCTION [dbo].[NextBirthday](@pid int)
RETURNS datetime
AS
	BEGIN
	
	
	  DECLARE
		@today DATETIME,
		@date datetime, 
		@m int,
		@d int,
		@y int
		
SELECT @today = CONVERT(datetime, CONVERT(nvarchar, GETDATE(), 112))
select @date = null
select @m = BirthMonth, @d = BirthDay from dbo.People where @pid = PeopleId
if @m is null or @d is null
	return @date
select @y = DATEPART(year, @today) 
select @date = dateadd(mm,(@y-1900)* 12 + @m - 1,0) + (@d-1) 
if @date < @today
	select @date = dateadd(yy, 1, @date)
RETURN @date
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[MemberType]'
GO
CREATE TABLE [lookup].[MemberType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[AttendanceTypeId] [int] NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MemberType] on [lookup].[MemberType]'
GO
ALTER TABLE [lookup].[MemberType] ADD CONSTRAINT [PK_MemberType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[HomePage]'
GO
CREATE PROCEDURE [dbo].[HomePage] ( @PeopleId INT)
AS
BEGIN

	IF EXISTS(SELECT NULL FROM Tag WHERE PeopleId = @PeopleId)
		SELECT dbo.NextBirthday(p.PeopleId) Birthday, p.Name, p.PeopleId  
		FROM dbo.Tag t
		JOIN dbo.People op ON t.PeopleId = op.PeopleId
		JOIN dbo.TagPerson tp ON t.Id = tp.Id
		JOIN dbo.People p ON tp.PeopleId = p.PeopleId
		WHERE t.Name = 'TrackBirthdays'
		AND t.PeopleId = @PeopleId
		AND DATEDIFF(d, GETDATE(), dbo.NextBirthday(p.PeopleId)) <= 15
		AND op.DeceasedDate IS NULL
		ORDER BY dbo.NextBirthday(p.PeopleId)
	ELSE
		SELECT dbo.NextBirthday(p.PeopleId) Birthday, p.Name, p.PeopleId
		FROM dbo.OrganizationMembers om 
		JOIN dbo.People p ON om.PeopleId = p.PeopleId
		WHERE om.OrganizationId = p.BibleFellowshipClassId
		
	DECLARE @limitvisibility BIT = 0
	IF EXISTS(
		SELECT NULL 
		FROM dbo.UserRole ur 
		JOIN dbo.Roles r ON ur.RoleId = r.RoleId 
		JOIN dbo.Users u ON ur.UserId = u.UserId
		WHERE r.RoleName = 'OrgLeadersOnly' 
		AND u.PeopleId = @PeopleId)
		SET @limitvisibility = 1
	
	DECLARE @oids TABLE ( OrganizationId int )

	IF @limitvisibility = 1
	BEGIN
		INSERT INTO @oids (OrganizationId)
			SELECT o.OrganizationId
			FROM dbo.Organizations o
			WHERE EXISTS(
				SELECT NULL 
				FROM dbo.OrganizationMembers om
				JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
				WHERE om.OrganizationId = o.OrganizationId
				AND om.PeopleId = @PeopleId
				AND mt.AttendanceTypeId =  10)
		INSERT INTO @oids ( OrganizationId )
			SELECT o.OrganizationId
			FROM dbo.Organizations o
			JOIN dbo.Organizations co ON o.OrganizationId = co.ParentOrgId
			WHERE o.OrganizationId IN (SELECT OrganizationId FROM @oids)
		INSERT INTO @oids ( OrganizationId )
			SELECT o.OrganizationId
			FROM dbo.Organizations o
			JOIN dbo.Organizations co ON o.OrganizationId = co.ParentOrgId
			JOIN dbo.Organizations cco ON co.OrganizationId = cco.ParentOrgId
			WHERE o.OrganizationId IN (SELECT OrganizationId FROM @oids)
	END
	
	SELECT o.OrganizationName AS Name, mt.Description MemberType, o.OrganizationId OrgId
	FROM dbo.OrganizationMembers om
	JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
	JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	JOIN dbo.People p ON om.PeopleId = p.PeopleId
	WHERE om.PeopleId = @PeopleId
	AND ISNULL(om.Pending, 0) = 0
	AND (om.OrganizationId IN (
			SELECT OrganizationId FROM @oids) 
			OR NOT(@limitvisibility = 1 AND o.SecurityTypeId = 3))
	ORDER BY o.OrganizationName
	

	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SchoolGrade]'
GO
CREATE FUNCTION [dbo].[SchoolGrade] (@pid INT)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @g INT

	SELECT TOP 1 @g = o.GradeAgeStart 
	FROM dbo.OrganizationMembers AS om 
		JOIN dbo.Organizations AS o ON om.OrganizationId = o.OrganizationId 
	WHERE o.IsBibleFellowshipOrg = 1
		AND om.PeopleId = @pid 
		AND om.MemberTypeId = 220 

	-- Return the result of the function
	RETURN @g

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationMemberCount]'
GO
CREATE FUNCTION [dbo].[OrganizationMemberCount](@oid int) 
RETURNS int
AS
BEGIN
	DECLARE @c int
	SELECT @c = count(*) from dbo.OrganizationMembers 
	where OrganizationId = @oid
	AND (Pending = 0 OR Pending IS NULL)
	AND MemberTypeId <> 230
	RETURN @c
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationLeaderName]'
GO
CREATE FUNCTION [dbo].[OrganizationLeaderName](@orgid int)
RETURNS nvarchar(100)
AS
BEGIN
	DECLARE @id int, @orgstatus int, @name nvarchar(100)
	select @orgstatus = OrganizationStatusId 
	from dbo.Organizations
	where OrganizationId = @orgid
	--if (@orgstatus = 40)
	--SELECT top 1 @id = PeopleId from
 --                     dbo.EnrollmentTransaction et INNER JOIN
 --                     dbo.Organizations o ON 
 --                     et.OrganizationId = o.OrganizationId AND 
 --                     et.MemberTypeId = o.LeaderMemberTypeId
	--		where et.OrganizationId = @orgid
 --                     order by et.TransactionDate desc
	--else
	SELECT top 1 @id = PeopleId from
                      dbo.OrganizationMembers om INNER JOIN
                      dbo.Organizations o ON 
                      om.OrganizationId = o.OrganizationId AND 
                      om.MemberTypeId = o.LeaderMemberTypeId
	where om.OrganizationId = @orgid
	ORDER BY om.EnrollmentDate

	SELECT @name = (case when [Nickname]<>'' then [nickname] else [FirstName] end+' ')+[LastName] from dbo.People where PeopleId = @id
	RETURN @name
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationLeaderId]'
GO
CREATE FUNCTION [dbo].[OrganizationLeaderId](@orgid int)
RETURNS int
AS
BEGIN
	DECLARE @id int, @orgstatus int
	select @orgstatus = OrganizationStatusId 
	from dbo.Organizations
	where OrganizationId = @orgid
	--if (@orgstatus = 40)
	--SELECT top 1 @id = PeopleId from
 --                     dbo.EnrollmentTransaction et INNER JOIN
 --                     dbo.Organizations o ON 
 --                     et.OrganizationId = o.OrganizationId AND 
 --                     et.MemberTypeId = o.LeaderMemberTypeId
	--		where et.OrganizationId = @orgid
 --                     order by et.TransactionDate desc
	--else
	SELECT top 1 @id = PeopleId from
                      dbo.OrganizationMembers om INNER JOIN
                      dbo.Organizations o ON 
                      om.OrganizationId = o.OrganizationId AND 
                      om.MemberTypeId = o.LeaderMemberTypeId AND
                      (om.Pending IS NULL OR om.Pending = 0)
	where om.OrganizationId = @orgid
	ORDER BY om.EnrollmentDate
	RETURN @id

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EnrollmentTransaction]'
GO
CREATE TABLE [dbo].[EnrollmentTransaction]
(
[TransactionId] [int] NOT NULL IDENTITY(1, 1),
[TransactionStatus] [bit] NOT NULL CONSTRAINT [DF_ENROLLMENT_TRANSACTION_TBL_TRANSACTION_STATUS] DEFAULT ((0)),
[CreatedBy] [int] NULL,
[CreatedDate] [datetime] NULL,
[TransactionDate] [datetime] NOT NULL,
[TransactionTypeId] [int] NOT NULL,
[OrganizationId] [int] NOT NULL,
[OrganizationName] [nvarchar] (100) NOT NULL,
[PeopleId] [int] NOT NULL,
[MemberTypeId] [int] NOT NULL,
[EnrollmentDate] [datetime] NULL,
[AttendancePercentage] [real] NULL,
[NextTranChangeDate] [datetime] NULL,
[EnrollmentTransactionId] [int] NULL,
[Pending] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [ENROLLMENT_TRANSACTION_PK] on [dbo].[EnrollmentTransaction]'
GO
ALTER TABLE [dbo].[EnrollmentTransaction] ADD CONSTRAINT [ENROLLMENT_TRANSACTION_PK] PRIMARY KEY NONCLUSTERED  ([TransactionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Date_Type] on [dbo].[EnrollmentTransaction]'
GO
CREATE NONCLUSTERED INDEX [IX_Date_Type] ON [dbo].[EnrollmentTransaction] ([TransactionDate], [TransactionTypeId]) INCLUDE ([OrganizationId], [PeopleId], [TransactionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [ENROLLMENT_TRANS_ORG_TC_TS_IX] on [dbo].[EnrollmentTransaction]'
GO
CREATE NONCLUSTERED INDEX [ENROLLMENT_TRANS_ORG_TC_TS_IX] ON [dbo].[EnrollmentTransaction] ([OrganizationId], [TransactionTypeId], [TransactionStatus])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ET_STATUS_Type_Date] on [dbo].[EnrollmentTransaction]'
GO
CREATE NONCLUSTERED INDEX [IX_ET_STATUS_Type_Date] ON [dbo].[EnrollmentTransaction] ([TransactionStatus], [TransactionTypeId]) INCLUDE ([OrganizationId], [PeopleId], [TransactionDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ENROLLMENT_TRANSACTION_TBL] on [dbo].[EnrollmentTransaction]'
GO
CREATE NONCLUSTERED INDEX [IX_ENROLLMENT_TRANSACTION_TBL] ON [dbo].[EnrollmentTransaction] ([TransactionDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [ENROLLMENT_TRANSACTION_ORG_IX] on [dbo].[EnrollmentTransaction]'
GO
CREATE NONCLUSTERED INDEX [ENROLLMENT_TRANSACTION_ORG_IX] ON [dbo].[EnrollmentTransaction] ([OrganizationId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [ENROLLMENT_TRANSACTION_PPL_IX] on [dbo].[EnrollmentTransaction]'
GO
CREATE NONCLUSTERED INDEX [ENROLLMENT_TRANSACTION_PPL_IX] ON [dbo].[EnrollmentTransaction] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BibleFellowshipClassId]'
GO

CREATE FUNCTION [dbo].[BibleFellowshipClassId]
	(
	@pid int
	)
RETURNS int
AS
	BEGIN
	declare @oid INT

	select top 1 @oid = om.OrganizationId from dbo.OrganizationMembers AS om 
	JOIN dbo.Organizations AS o ON om.OrganizationId = o.OrganizationId
	WHERE o.IsBibleFellowshipOrg = 1 
	AND om.PeopleId = @pid
	AND ISNULL(om.Pending, 0) = 0

	return @oid
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updOrganizationMember] on [dbo].[OrganizationMembers]'
GO
CREATE TRIGGER [dbo].[updOrganizationMember] 
   ON  [dbo].[OrganizationMembers]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF UPDATE(Pending)
	BEGIN
		UPDATE dbo.People
		SET Grade = ISNULL(dbo.SchoolGrade(PeopleId), Grade)
		WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)

		UPDATE dbo.Organizations
		SET MemberCount = dbo.OrganizationMemberCount(OrganizationId)
		WHERE OrganizationId IN 
		(SELECT OrganizationId FROM INSERTED GROUP BY OrganizationId)
	END

	DECLARE c CURSOR FOR
	SELECT d.OrganizationId, d.MemberTypeId, i.MemberTypeId, o.LeaderMemberTypeId, d.PeopleId, i.Pending, d.Pending, d.EnrollmentDate, i.EnrollmentDate
	FROM DELETED d
	JOIN INSERTED i ON i.OrganizationId = d.OrganizationId AND i.PeopleId = d.PeopleId
	JOIN dbo.Organizations o ON o.OrganizationId = d.OrganizationId
	
    IF UPDATE(MemberTypeId) OR UPDATE(Pending) OR UPDATE(EnrollmentDate)
    BEGIN
		OPEN c;
		DECLARE @oid INT, @dmt INT, @imt INT, @lmt INT, @pid INT, @ipending BIT, @dpending BIT, @denrolldt DATETIME, @ienrolldt DATETIME
		FETCH NEXT FROM c INTO @oid, @dmt, @imt, @lmt, @pid, @ipending, @dpending, @denrolldt, @ienrolldt;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@imt <> @dmt OR  @ipending <> @dpending OR @ienrolldt <> @denrolldt)
			BEGIN
				DECLARE @oname nvarchar(100), @att REAL
				SELECT @oname = o.OrganizationName, @att = om.AttendPct
				FROM dbo.OrganizationMembers om
				JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
				WHERE om.OrganizationId = @oid AND om.PeopleId = @pid
				
				INSERT dbo.EnrollmentTransaction
				        ( CreatedDate ,
				          TransactionDate ,
				          TransactionTypeId ,
				          OrganizationId ,
				          OrganizationName ,
				          PeopleId ,
				          MemberTypeId ,
				          AttendancePercentage ,
				          Pending,
				          EnrollmentDate
				        )
				VALUES  ( GETDATE() , -- CreatedDate - datetime
				          GETDATE() , -- TransactionDate - datetime
				          3 , -- TransactionTypeId - int
				          @oid , -- OrganizationId - int
				          @oname , -- OrganizationName - nvarchar(100)
				          @pid , -- PeopleId - int
				          @imt , -- MemberTypeId - int
				          @att , -- AttendancePercentage - real
				          @ipending,  -- Pending - bit
				          @ienrolldt -- EnrollmentDate
				        )
			END
			IF (@ienrolldt <> @denrolldt) -- need to update the most recent enrollment transactino
			BEGIN
				UPDATE dbo.EnrollmentTransaction
				SET EnrollmentDate = @ienrolldt, TransactionDate = @ienrolldt
				WHERE TransactionId = (SELECT MAX(TransactionId) FROM dbo.EnrollmentTransaction WHERE PeopleId = @pid AND OrganizationId = @oid AND TransactionTypeId = 1)
			END
			IF (@dmt = @lmt OR @imt = @lmt OR @ipending <> @dpending)
			BEGIN
				UPDATE dbo.Organizations
				SET LeaderId = dbo.OrganizationLeaderId(OrganizationId),
				LeaderName = dbo.OrganizationLeaderName(OrganizationId)
				WHERE OrganizationId = @oid
				
				UPDATE dbo.People
				SET BibleFellowshipClassId = dbo.BibleFellowshipClassId(p.PeopleId)
				FROM dbo.People p
				JOIN dbo.OrganizationMembers om ON p.PeopleId = om.PeopleId
				WHERE om.OrganizationId = @oid
			END
			FETCH NEXT FROM c INTO @oid, @dmt, @imt, @lmt, @pid, @ipending, @dpending, @denrolldt, @ienrolldt;
		END;
		CLOSE c;
		DEALLOCATE c;
	END

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastDrop]'
GO
CREATE FUNCTION [dbo].[LastDrop] (@orgid INT, @pid INT)
RETURNS DATETIME
AS
	BEGIN
	DECLARE @dt DATETIME
	
	SELECT @dt = TransactionDate FROM dbo.EnrollmentTransaction
	WHERE TransactionTypeId > 3
	AND PeopleId = @pid
	AND OrganizationId = @orgid
	AND MemberTypeId <> 311
	IF @dt IS NULL
		SET @dt = '1/1/1900'
	
	RETURN @dt
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateMainFellowship]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateMainFellowship] (@orgid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE dbo.People
	SET BibleFellowshipClassId = dbo.BibleFellowshipClassId(p.PeopleId)
	FROM dbo.People p
	JOIN dbo.OrganizationMembers om ON p.PeopleId = om.PeopleId
	WHERE om.OrganizationId = @orgid
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateLastActivity]'
GO
CREATE PROCEDURE [dbo].[UpdateLastActivity] ( @userid INT )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
    UPDATE dbo.Users
    SET LastActivityDate = GETDATE() WHERE UserId = @userid
    -- changed
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FindPerson3]'
GO
CREATE FUNCTION [dbo].[FindPerson3](@first nvarchar(25), @last nvarchar(50), @dob DATETIME, @email nvarchar(60), 
			@phone1 nvarchar(15),
			@phone2 nvarchar(15),
			@phone3 nvarchar(15))
RETURNS @t TABLE ( PeopleId INT)
AS
BEGIN
	DECLARE @mm TABLE ( PeopleId INT, Matches INT )
	
	DECLARE @fname nvarchar(50) = REPLACE(@first,' ', '')
	SET @dob = CASE WHEN @dob = '' THEN NULL ELSE @dob END
	
	DECLARE @m INT = DATEPART(m, @dob)
	DECLARE @d INT = DATEPART(d, @dob)
	DECLARE @y INT = DATEPART(yy, @dob)
	
	SET @phone1 = dbo.SpaceToNull(dbo.GetDigits(@phone1))
	SET @phone2 = dbo.SpaceToNull(dbo.GetDigits(@phone2))
	SET @phone3 = dbo.SpaceToNull(dbo.GetDigits(@phone3))
	SET @email = dbo.SpaceToNull(@email)
	
	INSERT INTO @mm
	SELECT PeopleId, -- col 1
	(
		CASE WHEN (ISNULL(@email, '') = '' 
					AND ISNULL(@phone1, '') = '' 
					AND ISNULL(@phone2, '') = '' 
					AND ISNULL(@phone3, '') = '' 
					AND @dob IS NULL)
		OR (p.EmailAddress = @email AND LEN(@email) > 0)
		OR (p.EmailAddress2 = @email AND LEN(@email) > 0) 
		THEN 1 ELSE 0 END 
		+
		CASE WHEN (
					f.HomePhone = @phone1 AND LEN(@phone1) > 0)
				OR (CellPhone = @phone1 AND LEN(@phone1) > 0)
				OR (WorkPhone = @phone1 AND LEN(@phone1) > 0)
				OR (f.HomePhone = @phone2 AND LEN(@phone2) > 0)
				OR (CellPhone = @phone2 AND LEN(@phone2) > 0)
				OR (WorkPhone = @phone2 AND LEN(@phone2) > 0)
				OR (f.HomePhone = @phone3 AND LEN(@phone3) > 0)
				OR (CellPhone = @phone3 AND LEN(@phone3) > 0)
				OR (WorkPhone = @phone3 AND LEN(@phone3) > 0)
		THEN 1 ELSE 0 END 
		+
		CASE WHEN (BirthDay = @d AND BirthMonth = @m AND ABS(BirthYear - @y) <= 1)
		OR (BirthDay = @d AND BirthMonth = @m AND BirthYear IS NULL)
		THEN 1 ELSE 0 END
	) matches -- col 2
	FROM dbo.People p
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	WHERE
	(
		   @fname = FirstName
		OR @fname = NickName
		OR FirstName2 LIKE (@fname + '%')
		OR @fname LIKE (FirstName + '%')
	)
	AND (@last = LastName OR @last = MaidenName OR @last = MiddleName)
	
	
	INSERT INTO @t
	SELECT PeopleId FROM @mm m1
	WHERE m1.Matches = (SELECT MAX(Matches) FROM @mm) AND m1.Matches > 0
	ORDER BY Matches DESC
		
    RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateMeetingCounters]'
GO

CREATE PROCEDURE [dbo].[UpdateMeetingCounters](@mid INT)
AS
BEGIN
	DECLARE @numPresent INT, 
			@numNewVisit INT, 
			@numMembers INT, 
			@numVstMembers INT, 
			@numRepeatVst INT, 
			@numOutTowners INT, 
			@numOtherAttends INT,
			@numElse INT
	SELECT @numNewVisit = COUNT(*) FROM dbo.Attend WHERE MeetingId = @mid AND AttendanceFlag = 1 AND AttendanceTypeId = 60
	SELECT @numRepeatVst = COUNT(*) FROM dbo.Attend WHERE MeetingId = @mid AND AttendanceFlag = 1 AND AttendanceTypeId = 50
	SELECT @numVstMembers = COUNT(*) FROM dbo.Attend WHERE MeetingId = @mid AND AttendanceFlag = 1 AND AttendanceTypeId = 40
	SELECT @numOutTowners = COUNT(*) FROM dbo.Attend a WHERE MeetingId = @mid AND AttendanceFlag = 1 AND AttendanceTypeId IN (50,60) 
		AND EXISTS(SELECT NULL FROM dbo.People WHERE a.PeopleId = PeopleId AND PrimaryResCode NOT IN (10, 20))
	SELECT @numOtherAttends = COUNT(*) FROM dbo.Attend WHERE MeetingId = @mid AND (AttendanceTypeId = 80 OR OtherAttends > 0)
	SELECT @numPresent = COUNT(*) FROM dbo.Attend WHERE MeetingId = @mid AND AttendanceFlag = 1
	SELECT @numMembers = COUNT(*) FROM dbo.Attend WHERE MeetingId = @mid AND AttendanceFlag = 1 AND AttendanceTypeId IN (10,20,30,70)
	
	UPDATE dbo.Meetings SET
		NumMembers = @numMembers,
		NumPresent = @numPresent,
		NumNewVisit = @numNewVisit,
		NumVstMembers = @numVstMembers,
		NumRepeatVst = @numRepeatVst,
		NumOutTown = @numOutTowners,
		NumOtherAttends = @numOtherAttends
		WHERE MeetingId = @mid
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Numbers]'
GO
CREATE TABLE [dbo].[Numbers]
(
[Number] [bigint] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [n] on [dbo].[Numbers]'
GO
CREATE UNIQUE CLUSTERED INDEX [n] ON [dbo].[Numbers] ([Number])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SplitInts]'
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================



CREATE FUNCTION dbo.SplitInts ( @List VARCHAR(MAX) )
RETURNS TABLE
AS
    RETURN
    (
        SELECT DISTINCT
            [Value] = CONVERT(INT, LTRIM(RTRIM(CONVERT(
                VARCHAR(12),
                SUBSTRING(@List, Number,
                CHARINDEX(',', @List + ',', Number) - Number)))))
        FROM
            dbo.Numbers
        WHERE
            Number <= CONVERT(INT, LEN(@List))
            AND SUBSTRING(',' + @List, Number, 1) = ','
    );
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAttendMemberType]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].RecentAttendMemberType( 
	@progid INT,
	@divid INT,
	@org INT,
	@days INT,
	@idstring VARCHAR(500))
RETURNS 
@t TABLE 
(
	PeopleId INT
)
AS
BEGIN
	DECLARE @ids TABLE(id INT)
	INSERT @ids SELECT Value FROM dbo.SplitInts(@idstring)

	INSERT @t
	SELECT 
		p.PeopleId 
		FROM dbo.People p
		WHERE EXISTS(
			SELECT NULL
			FROM dbo.Attend a
			JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE 1 = 1
			AND a.MemberTypeId IN (SELECT id FROM @ids)
			AND  AttendanceFlag = 1
			AND a.PeopleId = p.PeopleId
			AND a.MeetingDate > DATEADD(dd, -@days, GETDATE())
			AND (ISNULL(@org, 0) = 0 OR m.OrganizationId = @org)
			AND (ISNULL(@divid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = m.OrganizationId AND DivId = @divid))
			AND (ISNULL(@progid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg dd WHERE dd.OrgId = m.OrganizationId
						AND EXISTS(SELECT NULL FROM dbo.ProgDiv pp WHERE pp.DivId = dd.DivId AND pp.ProgId = @progid)))
		)
	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[VoluteerApprovalIds]'
GO
CREATE TABLE [dbo].[VoluteerApprovalIds]
(
[PeopleId] [int] NOT NULL,
[ApprovalId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VoluteerAppoval] on [dbo].[VoluteerApprovalIds]'
GO
ALTER TABLE [dbo].[VoluteerApprovalIds] ADD CONSTRAINT [PK_VoluteerAppoval] PRIMARY KEY CLUSTERED  ([PeopleId], [ApprovalId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Volunteer]'
GO
CREATE TABLE [dbo].[Volunteer]
(
[PeopleId] [int] NOT NULL,
[StatusId] [int] NULL,
[ProcessedDate] [datetime] NULL,
[Standard] [bit] NOT NULL CONSTRAINT [DF_Volunteer_Standard] DEFAULT ((0)),
[Children] [bit] NOT NULL CONSTRAINT [DF_Volunteer_Children] DEFAULT ((0)),
[Leader] [bit] NOT NULL CONSTRAINT [DF_Volunteer_Leader] DEFAULT ((0)),
[Comments] [nvarchar] (max) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolunteerApproval] on [dbo].[Volunteer]'
GO
ALTER TABLE [dbo].[Volunteer] ADD CONSTRAINT [PK_VolunteerApproval] PRIMARY KEY CLUSTERED  ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[VolRequest]'
GO
CREATE TABLE [dbo].[VolRequest]
(
[MeetingId] [int] NOT NULL,
[RequestorId] [int] NOT NULL,
[Requested] [datetime] NOT NULL,
[VolunteerId] [int] NOT NULL,
[Responded] [datetime] NULL,
[CanVol] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolRequest] on [dbo].[VolRequest]'
GO
ALTER TABLE [dbo].[VolRequest] ADD CONSTRAINT [PK_VolRequest] PRIMARY KEY CLUSTERED  ([MeetingId], [RequestorId], [Requested], [VolunteerId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[VolInterestInterestCodes]'
GO
CREATE TABLE [dbo].[VolInterestInterestCodes]
(
[PeopleId] [int] NOT NULL,
[InterestCodeId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolInterestInterestCodes] on [dbo].[VolInterestInterestCodes]'
GO
ALTER TABLE [dbo].[VolInterestInterestCodes] ADD CONSTRAINT [PK_VolInterestInterestCodes] PRIMARY KEY CLUSTERED  ([PeopleId], [InterestCodeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TransactionPeople]'
GO
CREATE TABLE [dbo].[TransactionPeople]
(
[Id] [int] NOT NULL,
[PeopleId] [int] NOT NULL,
[Amt] [money] NULL,
[OrgId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TransactionPeople] on [dbo].[TransactionPeople]'
GO
ALTER TABLE [dbo].[TransactionPeople] ADD CONSTRAINT [PK_TransactionPeople] PRIMARY KEY CLUSTERED  ([Id], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TaskListOwners]'
GO
CREATE TABLE [dbo].[TaskListOwners]
(
[TaskListId] [int] NOT NULL,
[PeopleId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TaskListOwners] on [dbo].[TaskListOwners]'
GO
ALTER TABLE [dbo].[TaskListOwners] ADD CONSTRAINT [PK_TaskListOwners] PRIMARY KEY CLUSTERED  ([TaskListId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Task]'
GO
CREATE TABLE [dbo].[Task]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[OwnerId] [int] NOT NULL,
[ListId] [int] NOT NULL,
[CoOwnerId] [int] NULL,
[CoListId] [int] NULL,
[StatusId] [int] NULL,
[CreatedOn] [datetime] NOT NULL,
[SourceContactId] [int] NULL,
[CompletedContactId] [int] NULL,
[Notes] [nvarchar] (max) NULL,
[ModifiedBy] [int] NULL,
[ModifiedOn] [datetime] NULL,
[Project] [nvarchar] (50) NULL,
[Archive] [bit] NOT NULL CONSTRAINT [DF_Task_Archive] DEFAULT ((0)),
[Priority] [int] NULL,
[WhoId] [int] NULL,
[Due] [datetime] NULL,
[Location] [nvarchar] (50) NULL,
[Description] [nvarchar] (100) NULL,
[CompletedOn] [datetime] NULL,
[ForceCompleteWContact] [bit] NULL,
[OrginatorId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Task] on [dbo].[Task]'
GO
ALTER TABLE [dbo].[Task] ADD CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Task] on [dbo].[Task]'
GO
CREATE NONCLUSTERED INDEX [IX_Task] ON [dbo].[Task] ([OwnerId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TagShare]'
GO
CREATE TABLE [dbo].[TagShare]
(
[TagId] [int] NOT NULL,
[PeopleId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TagShare] on [dbo].[TagShare]'
GO
ALTER TABLE [dbo].[TagShare] ADD CONSTRAINT [PK_TagShare] PRIMARY KEY CLUSTERED  ([TagId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SMSItems]'
GO
CREATE TABLE [dbo].[SMSItems]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[ListID] [int] NOT NULL CONSTRAINT [DF_SMSItems_siListID] DEFAULT ((0)),
[PeopleID] [int] NOT NULL CONSTRAINT [DF_SMSItems_siSentToID] DEFAULT ((0)),
[Sent] [bit] NOT NULL CONSTRAINT [DF_SMSItems_Sent] DEFAULT ((0)),
[Number] [nvarchar] (25) NOT NULL CONSTRAINT [DF_SMSItems_SendAddress] DEFAULT (''),
[NoNumber] [bit] NOT NULL CONSTRAINT [DF_SMSItems_NoNumber] DEFAULT ((0)),
[NoOptIn] [bit] NOT NULL CONSTRAINT [DF_SMSItems_NoOptIn] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SMSItems] on [dbo].[SMSItems]'
GO
ALTER TABLE [dbo].[SMSItems] ADD CONSTRAINT [PK_SMSItems] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RelatedFamilies]'
GO
CREATE TABLE [dbo].[RelatedFamilies]
(
[FamilyId] [int] NOT NULL,
[RelatedFamilyId] [int] NOT NULL,
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[FamilyRelationshipDesc] [nvarchar] (256) NOT NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [RELATED_FAMILIES_PK] on [dbo].[RelatedFamilies]'
GO
ALTER TABLE [dbo].[RelatedFamilies] ADD CONSTRAINT [RELATED_FAMILIES_PK] PRIMARY KEY NONCLUSTERED  ([FamilyId], [RelatedFamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [RELATED_FAMILIES_RELATED_FK_IX] on [dbo].[RelatedFamilies]'
GO
CREATE NONCLUSTERED INDEX [RELATED_FAMILIES_RELATED_FK_IX] ON [dbo].[RelatedFamilies] ([RelatedFamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecurringAmounts]'
GO
CREATE TABLE [dbo].[RecurringAmounts]
(
[PeopleId] [int] NOT NULL,
[FundId] [int] NOT NULL,
[Amt] [money] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_RecurringAmounts] on [dbo].[RecurringAmounts]'
GO
ALTER TABLE [dbo].[RecurringAmounts] ADD CONSTRAINT [PK_RecurringAmounts] PRIMARY KEY CLUSTERED  ([PeopleId], [FundId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecReg]'
GO
CREATE TABLE [dbo].[RecReg]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PeopleId] [int] NULL,
[ImgId] [int] NULL,
[IsDocument] [bit] NULL,
[ActiveInAnotherChurch] [bit] NULL,
[ShirtSize] [nvarchar] (20) NULL,
[MedAllergy] [bit] NULL,
[email] [nvarchar] (80) NULL,
[MedicalDescription] [nvarchar] (1000) NULL,
[fname] [nvarchar] (80) NULL,
[mname] [nvarchar] (80) NULL,
[coaching] [bit] NULL,
[member] [bit] NULL,
[emcontact] [nvarchar] (100) NULL,
[emphone] [nvarchar] (15) NULL,
[doctor] [nvarchar] (100) NULL,
[docphone] [nvarchar] (15) NULL,
[insurance] [nvarchar] (100) NULL,
[policy] [nvarchar] (100) NULL,
[Comments] [nvarchar] (max) NULL,
[Tylenol] [bit] NULL,
[Advil] [bit] NULL,
[Maalox] [bit] NULL,
[Robitussin] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Participant] on [dbo].[RecReg]'
GO
ALTER TABLE [dbo].[RecReg] ADD CONSTRAINT [PK_Participant] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [RecRegPeopleId] on [dbo].[RecReg]'
GO
CREATE NONCLUSTERED INDEX [RecRegPeopleId] ON [dbo].[RecReg] ([PeopleId]) INCLUDE ([ActiveInAnotherChurch], [emcontact], [emphone], [fname], [MedicalDescription], [mname])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Picture]'
GO
CREATE TABLE [dbo].[Picture]
(
[PictureId] [int] NOT NULL IDENTITY(1, 1),
[CreatedDate] [datetime] NULL,
[CreatedBy] [nvarchar] (50) NULL,
[LargeId] [int] NULL,
[MediumId] [int] NULL,
[SmallId] [int] NULL,
[ThumbId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Picture] on [dbo].[Picture]'
GO
ALTER TABLE [dbo].[Picture] ADD CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED  ([PictureId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PeopleExtra]'
GO
CREATE TABLE [dbo].[PeopleExtra]
(
[PeopleId] [int] NOT NULL,
[TransactionTime] [datetime] NOT NULL CONSTRAINT [DF_PeopleExtra_TransactionTime] DEFAULT (((1)/(1))/(1900)),
[Field] [nvarchar] (150) NOT NULL,
[StrValue] [nvarchar] (200) NULL,
[DateValue] [datetime] NULL,
[Data] [nvarchar] (max) NULL,
[IntValue] [int] NULL,
[IntValue2] [int] NULL,
[BitValue] [bit] NULL,
[FieldValue] AS (([Field]+':')+isnull([StrValue],[BitValue])),
[Type] AS ((((case when [StrValue] IS NOT NULL then 'Code' else '' end+case when [Data] IS NOT NULL then 'Text' else '' end)+case when [DateValue] IS NOT NULL then 'Date' else '' end)+case when [IntValue] IS NOT NULL then 'Int' else '' end)+case when [BitValue] IS NOT NULL then 'Bit' else '' end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PeopleExtra] on [dbo].[PeopleExtra]'
GO
ALTER TABLE [dbo].[PeopleExtra] ADD CONSTRAINT [PK_PeopleExtra] PRIMARY KEY CLUSTERED  ([PeopleId], [TransactionTime], [Field])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_PeopleExtra_2] on [dbo].[PeopleExtra]'
GO
CREATE NONCLUSTERED INDEX [IX_PeopleExtra_2] ON [dbo].[PeopleExtra] ([Field], [DateValue])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_PeopleExtra] on [dbo].[PeopleExtra]'
GO
CREATE NONCLUSTERED INDEX [IX_PeopleExtra] ON [dbo].[PeopleExtra] ([Field], [StrValue])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PeopleCanEmailFor]'
GO
CREATE TABLE [dbo].[PeopleCanEmailFor]
(
[CanEmail] [int] NOT NULL,
[OnBehalfOf] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PeopleCanEmailFor] on [dbo].[PeopleCanEmailFor]'
GO
ALTER TABLE [dbo].[PeopleCanEmailFor] ADD CONSTRAINT [PK_PeopleCanEmailFor] PRIMARY KEY CLUSTERED  ([CanEmail], [OnBehalfOf])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PaymentInfo]'
GO
CREATE TABLE [dbo].[PaymentInfo]
(
[PeopleId] [int] NOT NULL,
[AuNetCustId] [int] NULL,
[AuNetCustPayId] [int] NULL,
[SageBankGuid] [uniqueidentifier] NULL,
[ccv] [nvarchar] (5) NULL,
[SageCardGuid] [uniqueidentifier] NULL,
[MaskedAccount] [nvarchar] (30) NULL,
[MaskedCard] [nvarchar] (30) NULL,
[Expires] [nvarchar] (10) NULL,
[testing] [bit] NULL,
[PreferredGivingType] [nvarchar] (2) NULL,
[PreferredPaymentType] [nvarchar] (2) NULL,
[Routing] [nvarchar] (10) NULL,
[FirstName] [nvarchar] (50) NULL,
[MiddleInitial] [nvarchar] (10) NULL,
[LastName] [nvarchar] (50) NULL,
[Suffix] [nvarchar] (10) NULL,
[Address] [nvarchar] (50) NULL,
[City] [nvarchar] (50) NULL,
[State] [nvarchar] (10) NULL,
[Zip] [nvarchar] (15) NULL,
[Phone] [nvarchar] (25) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_PaymentInfo_1] on [dbo].[PaymentInfo]'
GO
ALTER TABLE [dbo].[PaymentInfo] ADD CONSTRAINT [PK_PaymentInfo_1] PRIMARY KEY CLUSTERED  ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrgMemMemTags]'
GO
CREATE TABLE [dbo].[OrgMemMemTags]
(
[OrgId] [int] NOT NULL,
[PeopleId] [int] NOT NULL,
[MemberTagId] [int] NOT NULL,
[Number] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrgMemMemTags] on [dbo].[OrgMemMemTags]'
GO
ALTER TABLE [dbo].[OrgMemMemTags] ADD CONSTRAINT [PK_OrgMemMemTags] PRIMARY KEY CLUSTERED  ([OrgId], [PeopleId], [MemberTagId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MemberDocForm]'
GO
CREATE TABLE [dbo].[MemberDocForm]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PeopleId] [int] NOT NULL,
[DocDate] [datetime] NULL,
[UploaderId] [int] NULL,
[IsDocument] [bit] NULL,
[Purpose] [nvarchar] (30) NULL,
[LargeId] [int] NULL,
[MediumId] [int] NULL,
[SmallId] [int] NULL,
[Name] [nvarchar] (100) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MemberDocForm] on [dbo].[MemberDocForm]'
GO
ALTER TABLE [dbo].[MemberDocForm] ADD CONSTRAINT [PK_MemberDocForm] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ManagedGiving]'
GO
CREATE TABLE [dbo].[ManagedGiving]
(
[PeopleId] [int] NOT NULL,
[StartWhen] [datetime] NULL,
[NextDate] [datetime] NULL,
[SemiEvery] [nvarchar] (2) NULL,
[Day1] [int] NULL,
[Day2] [int] NULL,
[EveryN] [int] NULL,
[Period] [nvarchar] (2) NULL,
[StopWhen] [datetime] NULL,
[StopAfter] [int] NULL,
[type] [nvarchar] (2) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ManagedGiving] on [dbo].[ManagedGiving]'
GO
ALTER TABLE [dbo].[ManagedGiving] ADD CONSTRAINT [PK_ManagedGiving] PRIMARY KEY CLUSTERED  ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FamilyExtra]'
GO
CREATE TABLE [dbo].[FamilyExtra]
(
[FamilyId] [int] NOT NULL,
[Field] [nvarchar] (50) NOT NULL,
[StrValue] [nvarchar] (200) NULL,
[DateValue] [datetime] NULL,
[TransactionTime] [datetime] NOT NULL CONSTRAINT [DF_FamilyExtra_TransactionTime] DEFAULT (((1)/(1))/(1900)),
[Data] [nvarchar] (max) NULL,
[IntValue] [int] NULL,
[BitValue] [bit] NULL,
[FieldValue] AS (([Field]+':')+isnull([StrValue],[BitValue])),
[Type] AS ((((case when [StrValue] IS NOT NULL then 'Code' else '' end+case when [Data] IS NOT NULL then 'Text' else '' end)+case when [DateValue] IS NOT NULL then 'Date' else '' end)+case when [IntValue] IS NOT NULL then 'Int' else '' end)+case when [BitValue] IS NOT NULL then 'Bit' else '' end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FamilyExtra] on [dbo].[FamilyExtra]'
GO
ALTER TABLE [dbo].[FamilyExtra] ADD CONSTRAINT [PK_FamilyExtra] PRIMARY KEY CLUSTERED  ([FamilyId], [TransactionTime], [Field])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FamilyCheckinLock]'
GO
CREATE TABLE [dbo].[FamilyCheckinLock]
(
[FamilyId] [int] NOT NULL,
[Locked] [bit] NOT NULL,
[Created] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FamilyCheckinLock] on [dbo].[FamilyCheckinLock]'
GO
ALTER TABLE [dbo].[FamilyCheckinLock] ADD CONSTRAINT [PK_FamilyCheckinLock] PRIMARY KEY CLUSTERED  ([FamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailResponses]'
GO
CREATE TABLE [dbo].[EmailResponses]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[EmailQueueId] [int] NOT NULL,
[PeopleId] [int] NOT NULL,
[Type] [char] (1) NOT NULL,
[Dt] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailResponses] on [dbo].[EmailResponses]'
GO
ALTER TABLE [dbo].[EmailResponses] ADD CONSTRAINT [PK_EmailResponses] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_EmailResponses] on [dbo].[EmailResponses]'
GO
CREATE NONCLUSTERED INDEX [IX_EmailResponses] ON [dbo].[EmailResponses] ([EmailQueueId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailQueueTo]'
GO
CREATE TABLE [dbo].[EmailQueueTo]
(
[Id] [int] NOT NULL,
[PeopleId] [int] NOT NULL,
[OrgId] [int] NULL,
[Sent] [datetime] NULL,
[AddEmail] [nvarchar] (max) NULL,
[guid] [uniqueidentifier] NULL,
[messageid] [nvarchar] (100) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailQueueTo_1] on [dbo].[EmailQueueTo]'
GO
ALTER TABLE [dbo].[EmailQueueTo] ADD CONSTRAINT [PK_EmailQueueTo_1] PRIMARY KEY CLUSTERED  ([Id], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_EmailQueueTo] on [dbo].[EmailQueueTo]'
GO
CREATE NONCLUSTERED INDEX [IX_EmailQueueTo] ON [dbo].[EmailQueueTo] ([guid])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailQueue]'
GO
CREATE TABLE [dbo].[EmailQueue]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[SendWhen] [datetime] NULL,
[Subject] [nvarchar] (200) NULL,
[Body] [nvarchar] (max) NULL,
[FromAddr] [nvarchar] (100) NULL,
[Sent] [datetime] NULL,
[Started] [datetime] NULL,
[Queued] [datetime] NOT NULL,
[FromName] [nvarchar] (60) NULL,
[QueuedBy] [int] NULL,
[Redacted] [bit] NULL,
[Transactional] [bit] NULL,
[Public] [bit] NULL,
[Error] [nvarchar] (200) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailQueue] on [dbo].[EmailQueue]'
GO
ALTER TABLE [dbo].[EmailQueue] ADD CONSTRAINT [PK_EmailQueue] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailOptOut]'
GO
CREATE TABLE [dbo].[EmailOptOut]
(
[ToPeopleId] [int] NOT NULL,
[FromEmail] [nvarchar] (50) NOT NULL,
[Date] [datetime] NULL CONSTRAINT [DF_EmailOptOut_Date] DEFAULT (getdate())
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailOptOut_1] on [dbo].[EmailOptOut]'
GO
ALTER TABLE [dbo].[EmailOptOut] ADD CONSTRAINT [PK_EmailOptOut_1] PRIMARY KEY CLUSTERED  ([ToPeopleId], [FromEmail])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contribution]'
GO
CREATE TABLE [dbo].[Contribution]
(
[ContributionId] [int] NOT NULL IDENTITY(1, 1),
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[FundId] [int] NOT NULL,
[ContributionTypeId] [int] NOT NULL,
[PeopleId] [int] NULL,
[ContributionDate] [datetime] NULL,
[ContributionAmount] [numeric] (11, 2) NULL,
[ContributionDesc] [nvarchar] (256) NULL,
[ContributionStatusId] [int] NULL,
[PledgeFlag] [bit] NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[PostingDate] [datetime] NULL,
[BankAccount] [nvarchar] (250) NULL,
[ExtraDataId] [int] NULL,
[CheckNo] [nvarchar] (20) NULL,
[QBSyncID] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [CONTRIBUTION_PK] on [dbo].[Contribution]'
GO
ALTER TABLE [dbo].[Contribution] ADD CONSTRAINT [CONTRIBUTION_PK] PRIMARY KEY NONCLUSTERED  ([ContributionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [_dta_index_Contribution_6_1827394175__K10_K7_K11_K8_K5_K6_4] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [_dta_index_Contribution_6_1827394175__K10_K7_K11_K8_K5_K6_4] ON [dbo].[Contribution] ([ContributionStatusId], [ContributionDate], [PledgeFlag], [ContributionAmount], [ContributionTypeId], [PeopleId]) INCLUDE ([FundId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [CONTRIBUTION_FUND_FK_IX] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [CONTRIBUTION_FUND_FK_IX] ON [dbo].[Contribution] ([FundId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ContributionTypeId] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [IX_ContributionTypeId] ON [dbo].[Contribution] ([ContributionTypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [CONTRIBUTION_PEOPLE_FK_IX] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [CONTRIBUTION_PEOPLE_FK_IX] ON [dbo].[Contribution] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [CONTRIBUTION_DATE_IX] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [CONTRIBUTION_DATE_IX] ON [dbo].[Contribution] ([ContributionDate])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_INDIVIDUAL_CONTRIBUTION_TBL_1] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [IX_INDIVIDUAL_CONTRIBUTION_TBL_1] ON [dbo].[Contribution] ([ContributionStatusId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_INDIVIDUAL_CONTRIBUTION_TBL_2] on [dbo].[Contribution]'
GO
CREATE NONCLUSTERED INDEX [IX_INDIVIDUAL_CONTRIBUTION_TBL_2] ON [dbo].[Contribution] ([PledgeFlag])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contactors]'
GO
CREATE TABLE [dbo].[Contactors]
(
[ContactId] [int] NOT NULL,
[PeopleId] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Contactors] on [dbo].[Contactors]'
GO
ALTER TABLE [dbo].[Contactors] ADD CONSTRAINT [PK_Contactors] PRIMARY KEY CLUSTERED  ([ContactId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contactees]'
GO
CREATE TABLE [dbo].[Contactees]
(
[ContactId] [int] NOT NULL,
[PeopleId] [int] NOT NULL,
[ProfessionOfFaith] [bit] NULL,
[PrayedForPerson] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Contactees] on [dbo].[Contactees]'
GO
ALTER TABLE [dbo].[Contactees] ADD CONSTRAINT [PK_Contactees] PRIMARY KEY CLUSTERED  ([ContactId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CheckInTimes]'
GO
CREATE TABLE [dbo].[CheckInTimes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[PeopleId] [int] NULL,
[CheckInTime] [datetime] NULL,
[GuestOfId] [int] NULL,
[location] [nvarchar] (50) NULL,
[GuestOfPersonID] [int] NOT NULL CONSTRAINT [DF_CheckInTimes_GuestOfPersonID] DEFAULT ((0)),
[AccessTypeID] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_CheckInTimes] on [dbo].[CheckInTimes]'
GO
ALTER TABLE [dbo].[CheckInTimes] ADD CONSTRAINT [PK_CheckInTimes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_CheckInTimes_1] on [dbo].[CheckInTimes]'
GO
CREATE NONCLUSTERED INDEX [IX_CheckInTimes_1] ON [dbo].[CheckInTimes] ([CheckInTime])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CheckInActivity]'
GO
CREATE TABLE [dbo].[CheckInActivity]
(
[Id] [int] NOT NULL,
[Activity] [nvarchar] (50) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_CheckInActivity] on [dbo].[CheckInActivity]'
GO
ALTER TABLE [dbo].[CheckInActivity] ADD CONSTRAINT [PK_CheckInActivity] PRIMARY KEY CLUSTERED  ([Id], [Activity])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CardIdentifiers]'
GO
CREATE TABLE [dbo].[CardIdentifiers]
(
[Id] [nvarchar] (80) NOT NULL,
[PeopleId] [int] NULL,
[CreatedOn] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_CardIdentifiers] on [dbo].[CardIdentifiers]'
GO
ALTER TABLE [dbo].[CardIdentifiers] ADD CONSTRAINT [PK_CardIdentifiers] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PurgePerson]'
GO
CREATE PROCEDURE [dbo].[PurgePerson](@pid INT)
AS
BEGIN
	BEGIN TRY 
	  IF(@pid > 1)
	  BEGIN
		BEGIN TRANSACTION 
		DECLARE @fid INT, @pic INT
		DELETE dbo.OrgMemMemTags WHERE PeopleId = @pid
		DELETE dbo.OrganizationMembers WHERE PeopleId = @pid
		DELETE dbo.EnrollmentTransaction WHERE PeopleId = @pid
		DELETE dbo.CardIdentifiers WHERE PeopleId = @pid
		
		DELETE dbo.CheckInActivity
		FROM dbo.CheckInActivity a
		JOIN dbo.CheckInTimes t ON a.Id = t.Id
		WHERE t.PeopleId = @pid
		DELETE FROM dbo.CheckInTimes WHERE PeopleId = @pid
		
		DELETE dbo.PeopleExtra WHERE PeopleId = @pid
		DELETE dbo.TransactionPeople WHERE PeopleId = @pid
		DELETE dbo.EmailOptOut WHERE ToPeopleId = @pid

		DELETE dbo.EmailResponses 
		FROM dbo.EmailResponses r
		JOIN dbo.EmailQueue e ON e.Id = r.EmailQueueId
		WHERE QueuedBy = @pid

		DELETE dbo.EmailResponses WHERE PeopleId = @pid
		DELETE dbo.EmailQueueTo WHERE PeopleId = @pid;
		
		DELETE dbo.EmailQueueTo FROM dbo.EmailQueueTo et 
		JOIN EmailQueue e ON e.Id = et.Id
		WHERE QueuedBy = @pid

		DELETE dbo.EmailQueue WHERE QueuedBy = @pid;
		
		UPDATE dbo.ActivityLog
		SET PeopleId = NULL
		WHERE PeopleId = @pid
		
		DELETE dbo.FamilyCheckinLock
		FROM dbo.Families f
		JOIN dbo.People p ON f.FamilyId = p.FamilyId
		WHERE p.PeopleId = @pid

		DECLARE @t TABLE(id int)
		INSERT INTO @t(id) SELECT MeetingId FROM dbo.Attend a WHERE a.PeopleId = @pid
		
		DELETE dbo.Attend WHERE PeopleId = @pid
		
		DECLARE cur CURSOR FOR SELECT id FROM @t
		OPEN cur
		DECLARE @mid int
		FETCH NEXT FROM cur INTO @mid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.UpdateMeetingCounters @mid
			FETCH NEXT FROM cur INTO @mid
		END
		CLOSE cur
		DEALLOCATE cur
		
		UPDATE dbo.Contribution SET PeopleId = NULL WHERE PeopleId = @pid
		UPDATE dbo.Families SET HeadOfHouseholdId = NULL WHERE HeadOfHouseholdId = @pid
		UPDATE dbo.Families SET HeadOfHouseholdSpouseId = NULL WHERE HeadOfHouseholdSpouseId = @pid
		
		DELETE dbo.VolunteerForm WHERE PeopleId = @pid
		DELETE dbo.VoluteerApprovalIds WHERE PeopleId = @pid
		DELETE dbo.Volunteer WHERE PeopleId = @pid
		DELETE dbo.VolRequest WHERE RequestorId = @pid
		DELETE dbo.VolRequest WHERE VolunteerId = @pid
		DELETE dbo.Contactees WHERE PeopleId = @pid
		DELETE dbo.Contactors WHERE PeopleId = @pid
		DELETE dbo.TagPerson WHERE PeopleId = @pid
		DELETE dbo.Task WHERE WhoId = @pid
		DELETE dbo.Task WHERE OwnerId = @pid
		DELETE dbo.Task WHERE CoOwnerId = @pid
		DELETE dbo.TaskListOwners WHERE PeopleId = @pid
		DELETE dbo.RecurringAmounts WHERE PeopleId = @pid
		DELETE dbo.ManagedGiving WHERE PeopleId = @pid
		DELETE dbo.PaymentInfo WHERE PeopleId = @pid
		DELETE dbo.MemberDocForm WHERE PeopleId = @pid
		
		DELETE dbo.Preferences WHERE UserId IN (SELECT UserId FROM dbo.Users WHERE PeopleId = @pid)
		DELETE dbo.ActivityLog WHERE UserId IN (SELECT UserId FROM dbo.Users WHERE PeopleId = @pid)
		DELETE dbo.UserRole WHERE UserId IN (SELECT UserId FROM dbo.Users WHERE PeopleId = @pid)
		DELETE dbo.PeopleCanEmailFor WHERE OnBehalfOf = @pid
		DELETE dbo.PeopleCanEmailFor WHERE CanEmail = @pid
		
		UPDATE dbo.VolunteerForm 
		SET UploaderId = NULL 
		WHERE UploaderId IN (SELECT UserId FROM dbo.Users WHERE PeopleId = @pid)
		
		DELETE dbo.Coupons
		FROM Coupons c
		JOIN users u ON c.UserId = u.UserId
		WHERE u.PeopleId = @pid
		
		DELETE dbo.Coupons WHERE PeopleId = @pid
		
		DELETE dbo.Users WHERE UserId IN (SELECT UserId FROM dbo.Users WHERE PeopleId = @pid)
		
		DELETE dbo.TagPerson WHERE id IN (SELECT Id FROM dbo.Tag WHERE PeopleId = @pid)
		DELETE dbo.TagShare WHERE TagId IN (SELECT Id FROM dbo.Tag WHERE PeopleId = @pid)
		DELETE dbo.TagShare WHERE PeopleId = @pid
		DELETE dbo.Tag WHERE PeopleId = @pid
		
		DELETE dbo.RecReg WHERE PeopleId = @pid
		DELETE dbo.EmailQueueTo WHERE PeopleId = @pid
		DELETE dbo.SMSItems WHERE PeopleID = @pid
		
		DELETE dbo.VolInterestInterestCodes
		FROM dbo.VolInterestInterestCodes vc
		WHERE vc.PeopleId = @pid
		
		SELECT @fid = FamilyId, @pic = PictureId FROM dbo.People WHERE PeopleId = @pid
		DELETE dbo.FamilyExtra WHERE FamilyId = @fid
		
		UPDATE dbo.Families
		SET HeadOfHouseholdId = NULL, HeadOfHouseholdSpouseId = NULL
		WHERE FamilyId = @fid AND HeadOfHouseholdId = @pid
		OR FamilyId = @fid AND HeadOfHouseholdSpouseId = @pid
		
		DELETE dbo.People WHERE PeopleId = @pid
		
		IF (SELECT COUNT(*) FROM dbo.People WHERE FamilyId = @fid) = 0
		BEGIN
			DELETE dbo.RelatedFamilies WHERE FamilyId = @fid OR RelatedFamilyId = @fid
			DELETE dbo.Families WHERE FamilyId = @fid			
		END
		DELETE dbo.Picture WHERE PictureId = @pic
		
		COMMIT
	  END
	END TRY 
	BEGIN CATCH 
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentNewVisitCount]'
GO
CREATE FUNCTION [dbo].[RecentNewVisitCount]( 
	@progid INT,
	@divid INT,
	@org INT,
	@orgtype INT,
	@days0 INT,
	@days INT)
RETURNS 
@t TABLE (PeopleId INT, Cnt INT)
AS
BEGIN
	DECLARE @orgs TABLE (OrgId INT)
	INSERT @orgs
	SELECT OrganizationId 
	FROM dbo.Organizations
	WHERE (ISNULL(@orgtype, 0) = 0 OR OrganizationTypeId = @orgtype)
	AND (ISNULL(@org, 0) = 0 OR OrganizationId = @org)
	AND (ISNULL(@divid, 0) = 0 
			OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = OrganizationId AND DivId = @divid))
	AND (ISNULL(@progid, 0) = 0 
			OR EXISTS(SELECT NULL FROM dbo.DivOrg dd WHERE dd.OrgId = OrganizationId
				AND EXISTS(SELECT NULL FROM dbo.ProgDiv pp WHERE pp.DivId = dd.DivId AND pp.ProgId = @progid)))

	INSERT @t
	SELECT 
		p.PeopleId, 
		(SELECT COUNT(*)
			FROM dbo.Attend a
			JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			WHERE AttendanceFlag = 1
			AND a.PeopleId = p.PeopleId
			AND a.MeetingDate >= DATEADD(dd, -@days, GETDATE())
			AND m.OrganizationId IN (SELECT OrgId FROM @orgs)
		) Cnt
	FROM dbo.People p
	WHERE NOT EXISTS
	(
		SELECT NULL FROM dbo.Attend aa
		JOIN dbo.Meetings m ON aa.MeetingId = m.MeetingId
		WHERE AttendanceFlag = 1
		AND aa.PeopleId = p.PeopleId
		AND aa.MeetingDate > DATEADD(dd, -ISNULL(@days0, 365), GETDATE())
		AND aa.MeetingDate < DATEADD(dd, -@days, GETDATE())
		AND m.OrganizationId IN (SELECT OrgId FROM @orgs)
	)
	
	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[QueryBuilderClauses]'
GO
CREATE TABLE [dbo].[QueryBuilderClauses]
(
[QueryId] [int] NOT NULL IDENTITY(1, 1),
[ClauseOrder] [int] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_ClauseOrder] DEFAULT ((0)),
[GroupId] [int] NULL,
[Field] [nvarchar] (32) NULL,
[Comparison] [nvarchar] (20) NULL,
[TextValue] [nvarchar] (100) NULL,
[DateValue] [datetime] NULL,
[CodeIdValue] [nvarchar] (3000) NULL,
[StartDate] [datetime] NULL,
[EndDate] [datetime] NULL,
[Organization] [int] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_Organization] DEFAULT ((0)),
[Days] [int] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_Days] DEFAULT ((0)),
[SavedBy] [nvarchar] (50) NULL,
[Description] [nvarchar] (150) NULL,
[IsPublic] [bit] NOT NULL CONSTRAINT [QueryBuilderIsPublic] DEFAULT ((0)),
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_ModifiedOn] DEFAULT (getdate()),
[Quarters] [nvarchar] (50) NULL,
[SavedQueryIdDesc] [nvarchar] (100) NULL CONSTRAINT [DF_QueryBuilderClauses_SavedQueryId] DEFAULT ((0)),
[Tags] [nvarchar] (500) NULL,
[Schedule] [int] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_Schedule] DEFAULT ((0)),
[Program] [int] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_DivOrgs] DEFAULT ((0)),
[Division] [int] NOT NULL CONSTRAINT [DF_QueryBuilderClauses_SubDivOrgs] DEFAULT ((0)),
[Age] [int] NULL,
[Campus] [int] NULL,
[OrgType] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_QueryBuilderClauses] on [dbo].[QueryBuilderClauses]'
GO
ALTER TABLE [dbo].[QueryBuilderClauses] ADD CONSTRAINT [PK_QueryBuilderClauses] PRIMARY KEY CLUSTERED  ([QueryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_GroupId] on [dbo].[QueryBuilderClauses]'
GO
CREATE NONCLUSTERED INDEX [IX_GroupId] ON [dbo].[QueryBuilderClauses] ([GroupId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_QueryBuilderClauses] on [dbo].[QueryBuilderClauses]'
GO
CREATE NONCLUSTERED INDEX [IX_QueryBuilderClauses] ON [dbo].[QueryBuilderClauses] ([SavedBy])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[QBClauses]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[QBClauses](@qid INT)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	WITH QB (QueryId, TopId, GroupId, SavedBy, Description, Field, Comparison, Level)
	AS
	(
	-- Anchor member definition
		SELECT c.QueryId, @qid TopId, c.GroupId, c.SavedBy, c.Description, c.Field, c.Comparison, 0 AS Level
		FROM dbo.QueryBuilderClauses c
		WHERE c.QueryId = @qid AND c.GroupId IS NULL
		UNION ALL
	-- Recursive member definition
		SELECT c.QueryId, @qid TopId, c.GroupId, c.SavedBy, c.Description, c.Field, c.Comparison, cc.Level + 1
		FROM dbo.QueryBuilderClauses c
		INNER JOIN QB AS cc
			ON c.GroupId = cc.QueryId
	)
	SELECT QueryId, TopId, GroupId, SavedBy, DESCRIPTION, Field, Comparison, [Level] FROM QB
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PurgeAllPeople]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PurgeAllPeople]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		DECLARE pcur CURSOR FOR SELECT PeopleId FROM dbo.People
		OPEN pcur
		DECLARE @pid INT, @n INT
		SET @n = 0
		FETCH NEXT FROM pcur INTO @pid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.PurgePerson	@pid
			SET @n = @n + 1
			IF (@n % 50) = 0
				RAISERROR ('%d', 0, 1, @n) WITH NOWAIT
			IF (@n % 3) = 0
			BEGIN
				FETCH NEXT FROM pcur INTO @pid
				SET @n = @n + 1
				IF (@n % 50) = 0
					RAISERROR ('%d', 0, 1, @n) WITH NOWAIT
			END
			FETCH NEXT FROM pcur INTO @pid
		END
		CLOSE pcur
		DEALLOCATE pcur
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAttendType]'
GO
CREATE FUNCTION [dbo].[RecentAttendType]( 
	@progid INT,
	@divid INT,
	@org INT,
	@days INT,
	@idstring VARCHAR(500))
RETURNS 
@t TABLE ( PeopleId INT )
AS
BEGIN
	DECLARE @ids TABLE(id INT)
	INSERT @ids SELECT Value FROM dbo.SplitInts(@idstring)
	DECLARE @cnt INT, @firstid INT
	SELECT @cnt = COUNT(*) FROM @ids  
	SELECT TOP 1 @firstid = id FROM @ids;  

	INSERT @t
	SELECT 
		p.PeopleId 
		FROM dbo.People p
		WHERE EXISTS(
			SELECT NULL
			FROM dbo.Attend a
			JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE (AttendanceFlag = 1 
				OR (@cnt = 1 AND @firstid = 80)) -- offsite
			AND ISNULL(a.AttendanceTypeId, 0) IN (SELECT id FROM @ids)
			AND a.PeopleId = p.PeopleId
			AND a.MeetingDate > DATEADD(dd, -@days, GETDATE())
			AND (ISNULL(@org, 0) = 0 OR m.OrganizationId = @org)
			AND (ISNULL(@divid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = m.OrganizationId AND DivId = @divid))
			AND (ISNULL(@progid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg dd WHERE dd.OrgId = m.OrganizationId
						AND EXISTS(SELECT NULL FROM dbo.ProgDiv pp WHERE pp.DivId = dd.DivId AND pp.ProgId = @progid)))
		)
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteQBTree]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteQBTree](@qid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		DECLARE cur CURSOR FOR SELECT QueryId FROM dbo.QBClauses(@qid) ORDER BY LEVEL DESC
		OPEN cur
		DECLARE @id int
		FETCH NEXT FROM cur INTO @id
		WHILE @@FETCH_STATUS = 0
		BEGIN
			DELETE dbo.QueryBuilderClauses
			WHERE QueryId = @id
			FETCH NEXT FROM cur INTO @id
		END
		CLOSE cur
		DEALLOCATE cur

		
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryAdult3]'
GO
CREATE PROCEDURE [dbo].[PrimaryAdult3]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PeopleId, v.cnt, v.FamilyId FROM dbo.People p
	JOIN (SELECT COUNT(*) cnt, FamilyId
	FROM dbo.People
	WHERE PositionInFamilyId = 10
	GROUP BY FamilyId
	HAVING COUNT(*) > 2) v
	ON p.FamilyId = v.FamilyId
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ContactReason]'
GO
CREATE TABLE [lookup].[ContactReason]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NOT NULL,
[Description] [nvarchar] (100) NOT NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContactReasons] on [lookup].[ContactReason]'
GO
ALTER TABLE [lookup].[ContactReason] ADD CONSTRAINT [PK_ContactReasons] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FetchOrCreateContactReasonId]'
GO
CREATE PROC [dbo].FetchOrCreateContactReasonId(@reason VARCHAR(100), @rid INT OUTPUT)
AS
BEGIN
	SELECT @rid = Id FROM lookup.ContactReason WHERE [Description] = @reason
	IF @rid IS NULL
	BEGIN
		SELECT @rid = MAX(id) + 10 FROM lookup.ContactReason
		INSERT lookup.ContactReason (Id, Code, [Description]) VALUES (@rid,LEFT(@reason,20),@reason)
	END  
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastName]'
GO
CREATE VIEW [dbo].[LastName]
AS
SELECT LastName, COUNT(*) AS [count] FROM dbo.People GROUP BY LastName
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendedAsOf]'
GO
CREATE FUNCTION [dbo].[AttendedAsOf]( 
	@progid INT,
	@divid INT,
	@org INT,
	@dt1 DATETIME, 
	@dt2 DATETIME,
	@guestonly BIT
	)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		a.PeopleId
		FROM dbo.Attend a
			JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE AttendanceFlag = 1
			AND (ISNULL(@guestonly, 0) = 0 OR AttendanceTypeId IN (50, 60))
			AND a.MeetingDate >= @dt1
			AND a.MeetingDate <= @dt2
			AND (ISNULL(@org, 0) = 0 OR m.OrganizationId = @org)
			AND (ISNULL(@divid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = m.OrganizationId AND DivId = @divid))
			AND (ISNULL(@progid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg dd WHERE dd.OrgId = m.OrganizationId
						AND EXISTS(SELECT NULL FROM dbo.ProgDiv pp WHERE pp.DivId = dd.DivId AND pp.ProgId = @progid)))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[words]'
GO
CREATE TABLE [dbo].[words]
(
[word] [nvarchar] (20) NOT NULL,
[n] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_words_1] on [dbo].[words]'
GO
ALTER TABLE [dbo].[words] ADD CONSTRAINT [PK_words_1] PRIMARY KEY CLUSTERED  ([word])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_words] on [dbo].[words]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_words] ON [dbo].[words] ([n])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RenumberWords]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.RenumberWords
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE dbo.words
	SET n = nn
	FROM words w JOIN 
	(SELECT word, ROW_NUMBER() OVER (ORDER BY word) AS nn FROM dbo.words) AS tt
	ON w.word = tt.word
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[WidowedDate]'
GO
CREATE FUNCTION [dbo].[WidowedDate] 
(
	@peopleid int
)
RETURNS DATETIME
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result DATETIME

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP 1 @Result = s.DeceasedDate 
      FROM ( SELECT p1.FamilyId,
                    p1.MaritalStatusId,
                    p1.PositionInFamilyId
               FROM dbo.People p1
              WHERE p1.PeopleId =  @peopleid
                AND p1.MaritalStatusId = 50
                AND p1.DeceasedDate IS NULL
           ) p
     INNER JOIN dbo.Families f
             ON f.FamilyId = p.FamilyId
     INNER JOIN dbo.People s
             ON s.FamilyId = f.FamilyId
     WHERE s.PeopleId <> @peopleid 
       AND p.PositionInFamilyId = s.PositionInFamilyId
       AND s.DeceasedDate IS NOT NULL

	-- Return the result of the function
	RETURN @Result

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[WasDeaconActive2008]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[WasDeaconActive2008](@pid INT, @dt DATETIME)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r BIT 

	IF EXISTS(SELECT NULL FROM dbo.OrganizationMembers o WHERE o.OrganizationId = 80063 AND @pid = o.PeopleId) AND @dt > '1/1/2008' AND @dt < '11/1/2008'
		SELECT @r = 0
	ELSE IF EXISTS(SELECT NULL FROM dbo.OrganizationMembers o2 WHERE o2.OrganizationId = 80092 AND o2.PeopleId = @pid)
		SELECT @r = 1
	ELSE
		SELECT @r = 0

	-- Return the result of the function
	RETURN @r

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PickListOrgs]'
GO



CREATE VIEW [dbo].[PickListOrgs]
AS

SELECT OrgId FROM Organizations o 
CROSS APPLY ( SELECT CAST(value AS INT) OrgId 
	FROM dbo.Split(o.OrgPickList, ',') ) T 
WHERE o.OrgPickList IS NOT NULL


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrgSchedule]'
GO
CREATE TABLE [dbo].[OrgSchedule]
(
[OrganizationId] [int] NOT NULL,
[Id] [int] NOT NULL,
[ScheduleId] [int] NULL,
[SchedTime] [datetime] NULL,
[SchedDay] [int] NULL,
[MeetingTime] [datetime] NULL,
[AttendCreditId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrgSchedule] on [dbo].[OrgSchedule]'
GO
ALTER TABLE [dbo].[OrgSchedule] ADD CONSTRAINT [PK_OrgSchedule] PRIMARY KEY CLUSTERED  ([OrganizationId], [Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendCntHistory]'
GO
CREATE FUNCTION [dbo].AttendCntHistory( 
	@progid INT,
	@divid INT,
	@org INT,
	@sched INT,
	@start DATETIME,
	@end DATETIME
	)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		p.PeopleId, 
		(SELECT COUNT(*)
			FROM dbo.Attend a
			JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE 1 = 1
			AND  AttendanceFlag = 1
			AND a.PeopleId = p.PeopleId
			AND a.MeetingDate > @start
			AND (@sched = 0 OR CAST(a.MeetingDate AS TIME) = (SELECT CAST(SchedTime AS TIME) FROM dbo.OrgSchedule WHERE ScheduleId = @sched))
			AND (ISNULL(@org, 0) = 0 OR m.OrganizationId = @org)
			AND (ISNULL(@divid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = m.OrganizationId AND DivId = @divid))
			AND (ISNULL(@progid, 0) = 0 
					OR EXISTS(SELECT NULL FROM dbo.DivOrg dd WHERE dd.OrgId = m.OrganizationId
						AND EXISTS(SELECT NULL FROM dbo.ProgDiv pp WHERE pp.DivId = dd.DivId AND pp.ProgId = @progid)))
		) Cnt
	FROM dbo.People p
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Setting]'
GO
CREATE TABLE [dbo].[Setting]
(
[Id] [nvarchar] (50) NOT NULL,
[Setting] [nvarchar] (max) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Setting] on [dbo].[Setting]'
GO
ALTER TABLE [dbo].[Setting] ADD CONSTRAINT [PK_Setting] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ScheduleId]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ScheduleId](@day INT, @time datetime)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @id INT
	
	-- Add the T-SQL statements to compute the return value here
	SELECT @id = (ISNULL(@day, DATEPART(dw, @time)-1) + 1) * 10000 + DATEPART(hour, @time) * 100 + DATEPART(mi, @time)

	-- Return the result of the function
	RETURN @id

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendanceCredits]'
GO
CREATE FUNCTION [dbo].[AttendanceCredits](@orgid INT, @pid INT)
RETURNS @t TABLE (
	Attended BIT,
	[Year] INT,
	[Week] INT,
	AttendCreditCode INT,
	AttendanceTypeId INT
)
AS
BEGIN
    DECLARE @yearago DATETIME,
			@lastmeet DATETIME,
			@maxfuturemeeting DATETIME,
			@tzoffset INT,
			@earlycheckinhours INT = 10 -- to include future meetings
			
	SELECT @tzoffset = CONVERT(INT, Setting) FROM dbo.Setting WHERE Id = 'TZOffset'
	SELECT @maxfuturemeeting = DATEADD(hh ,ISNULL(@tzoffset,0) + @earlycheckinhours, GETDATE())
		
    SELECT @lastmeet = MAX(MeetingDate) 
    FROM dbo.Meetings
    WHERE OrganizationId = @orgid
    AND MeetingDate <= @maxfuturemeeting
    
    SELECT @yearago = DATEADD(year, -1, @lastmeet)
			
	INSERT INTO @t
	SELECT
		CONVERT(BIT, MAX(Attended)) AS Attended,
		[Year],
		[Week],
		AttendCredit,
		MAX(AttendanceTypeId) AS AttendanceTypeId
	FROM (
		SELECT	CONVERT(INT, EffAttendFlag) AS Attended, 
				DATEPART(yy, m.MeetingDate) AS [Year], 
				DATEPART(ww, m.MeetingDate) AS [Week], 
				s.ScheduleId,
				AttendanceTypeId,
				CASE WHEN ISNULL(m.AttendCreditId, 1) = 1 
					THEN AttendId + 20 -- make every meeting count, 20 gets it out of the way of AttendCredit codes
					ELSE m.AttendCreditId
				END AS AttendCredit
		FROM dbo.Attend AS a
		JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
		LEFT JOIN dbo.OrgSchedule s 
			ON m.OrganizationId = s.OrganizationId 
			AND s.ScheduleId = dbo.ScheduleId(NULL, a.MeetingDate)
		WHERE m.OrganizationId = @orgid
			AND PeopleId = @pid
			AND m.MeetingDate >= @yearago
			AND m.MeetingDate <= @maxfuturemeeting
	) AS InlineView
	GROUP BY [Year], [Week], AttendCredit
	ORDER BY [Year] DESC, [Week] DESC
	
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAttendStr]'
GO
CREATE PROCEDURE [dbo].[UpdateAttendStr] @orgid INT, @pid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @a nvarchar(200) = '', -- attendance string
			@mindt DATETIME, 
			@dt DATETIME,
			@tct INT, -- total count
			@act INT, -- attended count
			@pct REAL,
			@lastattend DATETIME
			
	DECLARE @t TABLE (
		Attended BIT,
		[Year] INT,
		[Week] INT,
		AttendCreditCode INT,
		AttendanceTypeId INT
	)
	INSERT INTO @t SELECT TOP 52 * FROM dbo.AttendanceCredits(@orgid, @pid)
	
	SELECT @tct = COUNT(*) FROM @t WHERE Attended IS NOT NULL
    SELECT @act = COUNT(*) FROM @t WHERE Attended = 1
       
	if @tct = 0
		SELECT @pct = 0
	else
		SELECT @pct = @act * 100.0 / @tct
			
	SELECT TOP 52 @a = 
		CASE 
		WHEN Attended IS NULL THEN
			CASE AttendanceTypeId
			WHEN 20 THEN 'V'
			WHEN 70 THEN 'I'
			WHEN 90 THEN 'G'
			WHEN 80 THEN 'O'
			WHEN 110 THEN '*'
			ELSE '*'
			END
		WHEN Attended = 1 THEN 'P'
		ELSE '.'
		END + @a
	FROM @t
	
	SELECT @lastattend = MAX(a.MeetingDate) FROM dbo.Attend a
	WHERE a.AttendanceFlag = 1 
	AND a.OrganizationId = @orgid 
	AND a.PeopleId = @pid

	UPDATE dbo.OrganizationMembers SET
		AttendPct = @pct,
		AttendStr = @a,
		LastAttended = @lastattend
	WHERE OrganizationId = @orgid AND PeopleId = @pid

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Division]'
GO
CREATE TABLE [dbo].[Division]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) NULL,
[ProgId] [int] NULL,
[SortOrder] [int] NULL,
[EmailMessage] [nvarchar] (max) NULL,
[EmailSubject] [nvarchar] (100) NULL,
[Instructions] [nvarchar] (max) NULL,
[Terms] [nvarchar] (max) NULL,
[ReportLine] [int] NULL,
[NoDisplayZero] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Division] on [dbo].[Division]'
GO
ALTER TABLE [dbo].[Division] ADD CONSTRAINT [PK_Division] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CsvTable]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[CsvTable](@csv nvarchar(4000))
RETURNS 
@tbl TABLE (id int NOT NULL)
AS
BEGIN
	declare @pos int
	declare @val nvarchar(1000)

	set @csv = @csv + ','

WHILE PATINDEX('%,%',@csv) > 0
BEGIN

	SELECT @pos = PATINDEX('%,%', @csv)
	SELECT @val = left(@csv, @pos - 1)

	INSERT INTO @tbl SELECT @val
	SELECT @csv = STUFF(@csv, 1, @pos, '')
END

	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendanceTypeAsOf]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[AttendanceTypeAsOf]
(	
	@from DATETIME,
	@to DATETIME,
	@progid INT,
	@divid INT,
	@orgid INT,
	@orgtype INT,
	@ids nvarchar(4000)
)
RETURNS @t TABLE ( PeopleId INT )
AS
BEGIN
	INSERT INTO @t (PeopleId) SELECT p.PeopleId FROM dbo.People p
	WHERE EXISTS (
		SELECT NULL FROM dbo.Attend a
		JOIN dbo.Meetings m ON m.MeetingId = a.MeetingId
		JOIN dbo.Organizations o ON o.OrganizationId = m.OrganizationId
		WHERE a.PeopleId = p.PeopleId
		AND a.AttendanceTypeId IN (SELECT id FROM CsvTable(@ids))
		AND a.AttendanceFlag = 1
		AND a.MeetingDate >= @from
		AND a.MeetingDate < @to
        AND (o.OrganizationTypeId = @orgtype OR @orgtype = 0)
		AND (a.OrganizationId = @orgid OR @orgid = 0)
		AND (EXISTS(SELECT NULL FROM DivOrg d1
				WHERE d1.OrgId = a.OrganizationId
				AND d1.DivId = @divid) OR @divid = 0)
		AND (EXISTS(SELECT NULL FROM DivOrg d2
				WHERE d2.OrgId = a.OrganizationId
				AND EXISTS(SELECT NULL FROM Division d
						WHERE d2.DivId = d.Id
						AND d.ProgId = @progid)) OR @progid = 0)
		)
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllAttendStr]'
GO
CREATE PROCEDURE [dbo].[UpdateAllAttendStr] (@orgid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @start DATETIME = CURRENT_TIMESTAMP;
	
    -- Insert statements for procedure here
		DECLARE cur CURSOR FOR 
		SELECT PeopleId 
		FROM dbo.OrganizationMembers
		WHERE OrganizationId = @orgid
		OPEN cur
		DECLARE @pid INT, @n INT
		FETCH NEXT FROM cur INTO @pid
		WHILE @@FETCH_STATUS = 0
		BEGIN	
			raiserror ('%d %d', 10,1, @orgid, @pid) with nowait
			EXECUTE dbo.UpdateAttendStr @orgid, @pid
			FETCH NEXT FROM cur INTO @pid
		END
		CLOSE cur
		DEALLOCATE cur
		
	INSERT INTO dbo.ActivityLog
	        ( ActivityDate , UserId , Activity , Machine )
	VALUES  ( GETDATE(), NULL , 'UpdateAllAttendStr (' + CONVERT(nvarchar, @orgid) + ',' + CONVERT(nvarchar, DATEDIFF(ms, @start, CURRENT_TIMESTAMP) / 1000) + ')', 'DB' )
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[VolInterestCodes]'
GO
CREATE TABLE [dbo].[VolInterestCodes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Description] [nvarchar] (180) NULL,
[Code] [nvarchar] (100) NULL,
[Org] [nvarchar] (150) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolInterestCodes] on [dbo].[VolInterestCodes]'
GO
ALTER TABLE [dbo].[VolInterestCodes] ADD CONSTRAINT [PK_VolInterestCodes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Transaction]'
GO
CREATE TABLE [dbo].[Transaction]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[TransactionDate] [datetime] NULL,
[TransactionGateway] [nvarchar] (50) NULL,
[DatumId] [int] NULL,
[testing] [bit] NULL,
[amt] [money] NULL,
[ApprovalCode] [nvarchar] (150) NULL,
[Approved] [bit] NULL,
[TransactionId] [nvarchar] (50) NULL,
[Message] [nvarchar] (150) NULL,
[AuthCode] [nvarchar] (150) NULL,
[amtdue] [money] NULL,
[URL] [nvarchar] (300) NULL,
[Description] [nvarchar] (180) NULL,
[Name] [nvarchar] (100) NULL,
[Address] [nvarchar] (50) NULL,
[City] [nvarchar] (50) NULL,
[State] [nvarchar] (20) NULL,
[Zip] [nvarchar] (15) NULL,
[Phone] [nvarchar] (20) NULL,
[Emails] [nvarchar] (max) NULL,
[Participants] [nvarchar] (max) NULL,
[OrgId] [int] NULL,
[OriginalId] [int] NULL,
[regfees] [money] NULL,
[donate] [money] NULL,
[fund] [nvarchar] (50) NULL,
[financeonly] [bit] NULL,
[voided] [bit] NULL,
[credited] [bit] NULL,
[coupon] [bit] NULL,
[moneytran] AS (CONVERT([bit],case when [amt]<>(0) AND [approved]=(1) then (1) else (0) end,(0))),
[settled] [datetime] NULL,
[batch] [datetime] NULL,
[batchref] [nvarchar] (50) NULL,
[batchtyp] [nvarchar] (50) NULL,
[fromsage] [bit] NULL,
[LoginPeopleId] [int] NULL,
[First] [nvarchar] (50) NULL,
[MiddleInitial] [nvarchar] (1) NULL,
[Last] [nvarchar] (50) NULL,
[Suffix] [nvarchar] (10) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Transaction] on [dbo].[Transaction]'
GO
ALTER TABLE [dbo].[Transaction] ADD CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TaskList]'
GO
CREATE TABLE [dbo].[TaskList]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[CreatedBy] [int] NULL,
[Name] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TaskList] on [dbo].[TaskList]'
GO
ALTER TABLE [dbo].[TaskList] ADD CONSTRAINT [PK_TaskList] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SecurityCodes]'
GO
CREATE TABLE [dbo].[SecurityCodes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Code] [char] (4) NOT NULL,
[DateUsed] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SecurityCodes] on [dbo].[SecurityCodes]'
GO
ALTER TABLE [dbo].[SecurityCodes] ADD CONSTRAINT [PK_SecurityCodes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_SecurityCodes] on [dbo].[SecurityCodes]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SecurityCodes] ON [dbo].[SecurityCodes] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RssFeed]'
GO
CREATE TABLE [dbo].[RssFeed]
(
[Url] [nvarchar] (150) NOT NULL,
[Data] [nvarchar] (max) NULL,
[ETag] [nvarchar] (150) NULL,
[LastModified] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_RssFeed] on [dbo].[RssFeed]'
GO
ALTER TABLE [dbo].[RssFeed] ADD CONSTRAINT [PK_RssFeed] PRIMARY KEY CLUSTERED  ([Url])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Query]'
GO
CREATE TABLE [dbo].[Query]
(
[QueryId] [uniqueidentifier] NOT NULL,
[text] [varchar] (max) NULL,
[owner] [varchar] (50) NULL,
[created] [datetime] NULL,
[lastRun] [datetime] NULL,
[name] [varchar] (100) NULL,
[ispublic] [bit] NOT NULL CONSTRAINT [DF_Query_ispublic] DEFAULT ((0)),
[runCount] [int] NOT NULL CONSTRAINT [DF_Query_runCount] DEFAULT ((0)),
[CopiedFrom] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Query_1] on [dbo].[Query]'
GO
ALTER TABLE [dbo].[Query] ADD CONSTRAINT [PK_Query_1] PRIMARY KEY CLUSTERED  ([QueryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailToText]'
GO
CREATE TABLE [dbo].[EmailToText]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Carrier] [nvarchar] (50) NULL,
[domain] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailToText] on [dbo].[EmailToText]'
GO
ALTER TABLE [dbo].[EmailToText] ADD CONSTRAINT [PK_EmailToText] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteMeetingRun]'
GO
CREATE TABLE [dbo].[DeleteMeetingRun]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[meetingid] [int] NULL,
[started] [datetime] NULL,
[count] [int] NULL,
[processed] [int] NULL,
[completed] [datetime] NULL,
[error] [nvarchar] (200) NULL,
[running] AS (case when [completed] IS NULL AND [error] IS NULL AND datediff(minute,[started],getdate())<(120) then (1) else (0) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DeleteMeetingRun] on [dbo].[DeleteMeetingRun]'
GO
ALTER TABLE [dbo].[DeleteMeetingRun] ADD CONSTRAINT [PK_DeleteMeetingRun] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ChangeLog]'
GO
CREATE TABLE [dbo].[ChangeLog]
(
[PeopleId] [int] NOT NULL,
[FamilyId] [int] NULL,
[UserPeopleId] [int] NOT NULL,
[Created] [datetime] NOT NULL,
[Field] [nvarchar] (50) NULL,
[Data] [nvarchar] (max) NULL,
[Id] [int] NOT NULL IDENTITY(1, 1),
[Before] [nvarchar] (max) NULL,
[After] [nvarchar] (max) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ChangeLog_1] on [dbo].[ChangeLog]'
GO
ALTER TABLE [dbo].[ChangeLog] ADD CONSTRAINT [PK_ChangeLog_1] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CleanStart]'
GO
CREATE PROCEDURE [dbo].[CleanStart]
AS

delete dbo.ActivityLog
delete RssFeed
delete ChangeLog
delete DeleteMeetingRun
delete EmailToText
delete Numbers
delete SecurityCodes
delete Query
delete QueryBuilderClauses
delete TaskList
delete TransactionPeople
delete [Transaction]
delete Tag
delete Preferences
delete FamilyCheckinLock
delete EmailQueueTo
delete EmailQueue
delete VolInterestInterestCodes
delete VolInterestCodes



DELETE TagPerson 
FROM dbo.TagPerson tp 
JOIN tag t ON tp.Id = t.Id 
WHERE t.TypeId = 1

UPDATE Users 
SET Password = '2352354235', 
	TempPassword = 'bvcms', 
	LastLoginDate = NULL 
where username = 'admin'

delete dbo.Setting 
where id = 'LastBatchRun'

RETURN 0
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Nick]'
GO
CREATE VIEW [dbo].[Nick]
AS
SELECT NickName, COUNT(*) AS [count] FROM dbo.People GROUP BY NickName
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ExtraData]'
GO
CREATE TABLE [dbo].[ExtraData]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Data] [nvarchar] (max) NULL,
[Stamp] [datetime] NULL,
[completed] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ExtraData] on [dbo].[ExtraData]'
GO
ALTER TABLE [dbo].[ExtraData] ADD CONSTRAINT [PK_ExtraData] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentRegistrations]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[RecentRegistrations] ( @days INT )
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
SELECT MIN(stamp) dt1, MAX(stamp) dt2, COUNT(*) cnt, o.OrganizationId, o.OrganizationName, completed FROM 
(
	SELECT 
		CONVERT(XML, Data) xdata
		, d.Stamp
		, d.completed
	FROM dbo.ExtraData d
	WHERE Stamp > DATEADD(dd, -@days, GETDATE())
	AND Data LIKE '%<item>CompleteRegistration<%'
) tt
JOIN dbo.Organizations o ON  xdata.value('(/OnlineRegModel/orgid)[1]', 'int') = o.OrganizationId
WHERE o.OrganizationId IS NOT NULL
GROUP BY o.OrganizationId, o.OrganizationName, tt.completed
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionCountTable]'
GO
CREATE FUNCTION [dbo].[ContributionCountTable](@days INT, @cnt INT, @fundid INT, @op nvarchar(2))
RETURNS @t TABLE ( PeopleId INT)
AS
BEGIN
IF @op = '>'
	INSERT INTO @t SELECT p.PeopleId FROM dbo.People p
	WHERE ( SELECT COUNT(*) FROM dbo.Contribution c
		WHERE ContributionDate >= DATEADD(D, -@days, GETDATE())
			AND (c.FundId = @fundid OR @fundid IS NULL)
			AND ContributionStatusId = 0 --Recorded
			AND ContributionTypeId NOT IN (6,7,8) --Reversed or returned
			AND c.PeopleId IN (p.PeopleId, p.SpouseId)
			AND ((ISNULL(ContributionOptionsId,1) <>  2 AND c.PeopleId = p.PeopleId)
				 OR (ISNULL(ContributionOptionsId,1) = 2 AND c.PeopleId IN (p.PeopleId, p.SpouseId)))
			) > @cnt	
ELSE IF @op = '>='
	INSERT INTO @t SELECT p.PeopleId FROM dbo.People p
	WHERE ( SELECT COUNT(*) FROM dbo.Contribution c
		WHERE ContributionDate >= DATEADD(D, -@days, GETDATE())
			AND (c.FundId = @fundid OR @fundid IS NULL)
			AND ContributionStatusId = 0 --Recorded
			AND ContributionTypeId NOT IN (6,7,8) --Reversed or returned
			AND c.PeopleId IN (p.PeopleId, p.SpouseId)
			AND ((ISNULL(ContributionOptionsId,1) <>  2 AND c.PeopleId = p.PeopleId)
				 OR (ISNULL(ContributionOptionsId,1) = 2 AND c.PeopleId IN (p.PeopleId, p.SpouseId)))
			) >= @cnt	
ELSE IF @op = '<'
	INSERT INTO @t SELECT p.PeopleId FROM dbo.People p
	WHERE ( SELECT COUNT(*) FROM dbo.Contribution c
		WHERE ContributionDate >= DATEADD(D, -@days, GETDATE())
			AND (c.FundId = @fundid OR @fundid IS NULL)
			AND ContributionStatusId = 0 --Recorded
			AND ContributionTypeId NOT IN (6,7,8) --Reversed or returned
			AND c.PeopleId IN (p.PeopleId, p.SpouseId)
			AND ((ISNULL(ContributionOptionsId,1) <>  2 AND c.PeopleId = p.PeopleId)
				 OR (ISNULL(ContributionOptionsId,1) = 2 AND c.PeopleId IN (p.PeopleId, p.SpouseId)))
			) < @cnt	
ELSE IF @op = '<='
	INSERT INTO @t SELECT p.PeopleId FROM dbo.People p
	WHERE ( SELECT COUNT(*) FROM dbo.Contribution c
		WHERE ContributionDate >= DATEADD(D, -@days, GETDATE())
			AND (c.FundId = @fundid OR @fundid IS NULL)
			AND ContributionStatusId = 0 --Recorded
			AND ContributionTypeId NOT IN (6,7,8) --Reversed or returned
			AND c.PeopleId IN (p.PeopleId, p.SpouseId)
			AND ((ISNULL(ContributionOptionsId,1) <>  2 AND c.PeopleId = p.PeopleId)
				 OR (ISNULL(ContributionOptionsId,1) = 2 AND c.PeopleId IN (p.PeopleId, p.SpouseId)))
			) <= @cnt	
ELSE IF @op = '='
	INSERT INTO @t SELECT p.PeopleId FROM dbo.People p
	WHERE ( SELECT COUNT(*) FROM dbo.Contribution c
		WHERE ContributionDate >= DATEADD(D, -@days, GETDATE())
			AND (c.FundId = @fundid OR @fundid IS NULL)
			AND ContributionStatusId = 0 --Recorded
			AND ContributionTypeId NOT IN (6,7,8) --Reversed or returned
			AND c.PeopleId IN (p.PeopleId, p.SpouseId)
			AND ((ISNULL(ContributionOptionsId,1) <>  2 AND c.PeopleId = p.PeopleId)
				 OR (ISNULL(ContributionOptionsId,1) = 2 AND c.PeopleId IN (p.PeopleId, p.SpouseId)))
			) = @cnt	
ELSE IF @op = '<>'
	INSERT INTO @t SELECT p.PeopleId FROM dbo.People p
	WHERE ( SELECT COUNT(*) FROM dbo.Contribution c
		WHERE ContributionDate >= DATEADD(D, -@days, GETDATE())
			AND (c.FundId = @fundid OR @fundid IS NULL)
			AND ContributionStatusId = 0 --Recorded
			AND ContributionTypeId NOT IN (6,7,8) --Reversed or returned
			AND c.PeopleId IN (p.PeopleId, p.SpouseId)
			AND ((ISNULL(ContributionOptionsId,1) <>  2 AND c.PeopleId = p.PeopleId)
				 OR (ISNULL(ContributionOptionsId,1) = 2 AND c.PeopleId IN (p.PeopleId, p.SpouseId)))
			) <> @cnt	

    RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Registrations]'
GO
--SELECT d.xmldata.query('/root/product[@id="304"]/name') FROM dbo.ExtraData d


--UPDATE 
--dbo.ExtraData SET xmldata = Data
--WHERE Data LIKE '<%'
--AND Stamp > '1/1/13'

CREATE FUNCTION [dbo].[Registrations] ( @days INT )
RETURNS TABLE 
AS
RETURN 
(
SELECT 
	 tt.Id
	,tt.Stamp
	,o.OrganizationId 
	,o.OrganizationName 
	,pu.PeopleId
	,pu.Name
	,xdata.value('(/OnlineRegModel/List/OnlineRegPersonModel)[1]/dob[1]', 'varchar(50)') dob
	,xdata.value('(/OnlineRegModel/List/OnlineRegPersonModel)[1]/first[1]', 'varchar(50)') [first]
	,xdata.value('(/OnlineRegModel/List/OnlineRegPersonModel)[1]/last[1]', 'varchar(50)') [last]
	,xdata.value('count(/OnlineRegModel/List/OnlineRegPersonModel)', 'int') cnt
	,tt.completed
FROM 
(
	SELECT 
		Id
		, Data
		, CONVERT(XML, Data) xdata
		, d.Stamp
		, d.completed
	FROM dbo.ExtraData d
	WHERE Stamp > DATEADD(dd, -@days, GETDATE())
	AND Data LIKE '%<OnlineRegModel>%'
) tt
LEFT JOIN dbo.Organizations o ON  xdata.value('(/OnlineRegModel/List/OnlineRegPersonModel)[1]/orgid[1]', 'int') = o.OrganizationId
LEFT JOIN dbo.People pu ON xdata.value('(/OnlineRegModel/UserPeopleId)[1]', 'int') = pu.PeopleId
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FirstNick]'
GO
CREATE VIEW [dbo].[FirstNick]
AS
SELECT FirstName, NickName, COUNT(*) AS [count] FROM dbo.People GROUP BY FirstName, NickName
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FirstName2]'
GO
CREATE VIEW [dbo].[FirstName2]
AS
SELECT     FirstName, GenderId, CA, COUNT(*) AS Expr1
FROM         (SELECT     FirstName, GenderId, CASE WHEN Age <= 18 THEN 'C' ELSE 'A' END AS CA
                       FROM          dbo.People) AS ttt
GROUP BY FirstName, GenderId, CA
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Age]'
GO
CREATE FUNCTION [dbo].[Age](@pid int)
RETURNS int
AS
	BEGIN
	
	  DECLARE
		@v_return int, 
		@v_end_date datetime,
		@m int,
		@d int,
		@y int,
		@p_deceased_date datetime,
		@p_drop_code_id int
		
select @m = BirthMonth, @d = BirthDay, @y = BirthYear, @p_deceased_date = DeceasedDate, @p_drop_code_id = DropCodeId from dbo.People where @pid = PeopleId


         SET @v_return = NULL

         IF @y IS NOT NULL AND NOT (@p_deceased_date IS NULL AND isnull(@p_drop_code_id, 0) = 30)
            /* 30=Deceased*/
            BEGIN

               SET @v_end_date = isnull(@p_deceased_date, getdate())

               SET @v_return = datepart(YEAR, @v_end_date) - @y

               IF isnull(@m, 1) > datepart(MONTH, @v_end_date)
                  SET @v_return = @v_return - 1
               ELSE 
                  IF isnull(@m, 1) = datepart(MONTH, @v_end_date) AND isnull(@d, 1) > datepart(DAY, @v_end_date)
                     SET @v_return = @v_return - 1

            END

	RETURN @v_return
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FirstName]'
GO
CREATE VIEW [dbo].[FirstName]
AS
SELECT     FirstName, COUNT(*) AS count
FROM         dbo.People
GROUP BY FirstName
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionFund]'
GO
CREATE TABLE [dbo].[ContributionFund]
(
[FundId] [int] NOT NULL,
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[FundName] [nvarchar] (256) NOT NULL,
[FundDescription] [nvarchar] (256) NULL,
[FundStatusId] [int] NOT NULL,
[FundTypeId] [int] NOT NULL,
[FundPledgeFlag] [bit] NOT NULL,
[FundAccountCode] [int] NULL,
[FundIncomeDept] [nvarchar] (25) NULL,
[FundIncomeAccount] [nvarchar] (25) NULL,
[FundIncomeFund] [nvarchar] (25) NULL,
[FundCashDept] [nvarchar] (25) NULL,
[FundCashAccount] [nvarchar] (25) NULL,
[FundCashFund] [nvarchar] (25) NULL,
[OnlineSort] [int] NULL,
[NonTaxDeductible] [bit] NULL,
[QBIncomeAccount] [int] NOT NULL CONSTRAINT [DF_ContributionFund_QBIncomeAccount] DEFAULT ((0)),
[QBAssetAccount] [int] NOT NULL CONSTRAINT [DF_ContributionFund_QBAssetAccount] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [FUND_PK] on [dbo].[ContributionFund]'
GO
ALTER TABLE [dbo].[ContributionFund] ADD CONSTRAINT [FUND_PK] PRIMARY KEY NONCLUSTERED  ([FundId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [FUND_NAME_IX] on [dbo].[ContributionFund]'
GO
CREATE NONCLUSTERED INDEX [FUND_NAME_IX] ON [dbo].[ContributionFund] ([FundName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetContributions]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GetContributions](@fid INT, @pledge bit)
RETURNS TABLE 
AS
RETURN 
(
SELECT p.PeopleId, p.PreferredName First, sp.PreferredName Spouse, p.LastName LAST, p.PrimaryAddress Addr, p.PrimaryCity City, p.PrimaryState ST, p.PrimaryZip Zip, MAX(ContributionDate) ContributionDate, SUM(ContributionAmount) Amt
FROM dbo.Contribution c
JOIN dbo.ContributionFund f ON c.FundId = f.FundId
JOIN dbo.People p ON c.PeopleId = p.PeopleId
LEFT JOIN dbo.People sp ON p.SpouseId = sp.PeopleId
WHERE (CASE WHEN c.ContributionTypeId = 8 THEN 1 ELSE 0 END) = @pledge AND c.ContributionAmount > 0 AND f.fundid = @fid
GROUP BY P.PeopleId, p.LastName, p.PreferredName, sp.PreferredName, p.PrimaryAddress, p.PrimaryCity, p.PrimaryState, p.PrimaryZip
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StatusFlagsPerson]'
GO
CREATE FUNCTION [dbo].[StatusFlagsPerson]
(
	@pid int
)
RETURNS TABLE AS RETURN
(
	SELECT t.Name Flag, SUBSTRING(c.Name, 5, 100) Name, r.RoleName
	FROM dbo.People p1
	JOIN dbo.TagPerson tp ON p1.PeopleId = tp.PeopleId
	JOIN dbo.Tag t ON tp.Id = t.Id
	JOIN dbo.Query c ON c.Name LIKE (t.Name + ':%')
	JOIN dbo.Split((SELECT Setting FROM Setting WHERE Id = 'StatusFlags'), ',') ff ON t.Name = ff.Value
	LEFT JOIN dbo.Roles r ON r.RoleName = 'StatusFlag:' + t.Name
	WHERE p1.PeopleId = @pid
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateLargeMeetingCounters]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateLargeMeetingCounters]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		DECLARE cur CURSOR FOR SELECT MeetingId FROM dbo.Meetings WHERE NumPresent > 4000
		OPEN cur
		DECLARE @mid int
		FETCH NEXT FROM cur INTO @mid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.UpdateMeetingCounters @mid
			FETCH NEXT FROM cur INTO @mid
		END
		CLOSE cur
		DEALLOCATE cur
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StatusFlagList]'
GO
CREATE VIEW [dbo].[StatusFlagList]
	AS 
		SELECT sf.Flag, sf.Name, r.RoleName, 
		CAST (CASE WHEN ff.Value IS NOT NULL THEN 1 ELSE 0 END AS BIT) Visible
	FROM
	(
		SELECT SUBSTRING(c.Name, 1,3) Flag, SUBSTRING(c.Name, 5, 100) Name
		FROM dbo.Query c 
		WHERE c.Name LIKE 'F[0-9][0-9]:%'
	) sf
	LEFT JOIN dbo.Split((SELECT Setting FROM Setting WHERE Id = 'StatusFlags'), ',') ff ON sf.Flag = ff.Value
	LEFT JOIN dbo.Roles r ON r.RoleName = 'StatusFlag:' + Flag
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteTagForUser]'
GO
CREATE PROCEDURE [dbo].[DeleteTagForUser](@tag nvarchar, @user nvarchar)
AS
	/* SET NOCOUNT ON */
	declare @id int
	select @id = id from tag where name = @tag and @user = owner
	
	delete from tagperson where id = @id
	delete from tagshare where tagid = @id
	delete from tag where id = @id
	
	RETURN
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SetupNumbers]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetupNumbers]
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UpperLimit INT = 10000;
	IF(SELECT COUNT(*) FROM dbo.Numbers) = 0
	BEGIN
		WITH n AS
		(
		    SELECT
		        rn = ROW_NUMBER() OVER
		        (ORDER BY s1.[object_id])
		    FROM sys.objects AS s1
		    CROSS JOIN sys.objects AS s2
		    CROSS JOIN sys.objects AS s3
		)
		INSERT dbo.Numbers ( Number )
		(SELECT rn - 1
		 FROM n
		 WHERE rn <= @UpperLimit + 1)
	END
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteSpecialTags]'
GO
CREATE PROCEDURE [dbo].[DeleteSpecialTags](@pid INT = null)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	EXEC SetupNumbers

DELETE dbo.TagPerson
FROM dbo.TagPerson tp
JOIN dbo.Tag t ON tp.Id = t.Id
WHERE t.TypeId >= 3 AND t.TypeId < 100 
AND (t.PeopleId = @pid OR @pid IS NULL)

DELETE FROM dbo.Tag
WHERE TypeId >= 3 AND TypeId < 100 
AND (PeopleId = @pid OR @pid IS NULL)

DELETE dbo.TagPerson
FROM dbo.TagPerson tp
JOIN dbo.Tag t ON tp.Id = t.Id
WHERE t.TypeId = 1 AND t.PeopleId IS NULL

DELETE dbo.TagShare
FROM dbo.TagShare s
JOIN dbo.Tag t ON s.TagId = t.Id
WHERE TypeId = 1 AND t.PeopleId IS NULL

DELETE FROM dbo.Tag
WHERE TypeId = 1 AND PeopleId IS NULL

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EnrollmentTransactionId]'
GO

CREATE FUNCTION [dbo].[EnrollmentTransactionId]
(
  @pid int
 ,@oid int
 ,@tdt datetime
 ,@ttid int
)
RETURNS int
AS
	BEGIN
	  DECLARE @TransactionId int
	  SELECT @TransactionId = NULL
	  if @ttid >= 3
		  select top 1 @TransactionId = et.TransactionId
			from  dbo.EnrollmentTransaction et
		   where et.TransactionTypeId <= 2
			 and et.PeopleId = @pid
			 and et.OrganizationId = @oid
			 and et.TransactionDate < @tdt
	   order by et.TransactionDate desc
	RETURN @TransactionId
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[NextTranChangeDate]'
GO
CREATE FUNCTION [dbo].[NextTranChangeDate]
(
  @pid int
 ,@oid int
 ,@tdt datetime
 ,@typeid int
)
RETURNS datetime
AS
	BEGIN
	  DECLARE @dt datetime 
		  select top 1 @dt = TransactionDate
			from dbo.EnrollmentTransaction
		   where TransactionTypeId >= 3
		     and @typeid <= 3
			 and PeopleId = @pid
			 and OrganizationId = @oid
			 and TransactionDate > @tdt
	   order by TransactionDate
	RETURN @dt
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OneHeadOfHouseholdIsMember]'
GO
CREATE FUNCTION dbo.OneHeadOfHouseholdIsMember(@fid INT)
RETURNS BIT
AS
	BEGIN
	IF EXISTS(SELECT NULL FROM dbo.People WHERE FamilyId = @fid AND PeopleId IN (dbo.HeadOfHouseholdId(@fid), dbo.HeadOfHouseHoldSpouseId(@fid)) AND MemberStatusId = 10)
		RETURN 1
	RETURN 0
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ShowTransactions]'
GO
CREATE PROCEDURE [dbo].[ShowTransactions](@pid INT, @orgid INT)
AS
BEGIN
	SELECT
		TransactionId, 
		TransactionDate, 
		TransactionTypeId, 
		OrganizationId, 
		PeopleId, 
		NextTranChangeDate,
		dbo.NextTranChangeDate(PeopleId, OrganizationId, TransactionDate, TransactionTypeId) NextTranChangeDate0,
		EnrollmentTransactionId,
		dbo.EnrollmentTransactionId(PeopleId, OrganizationId, TransactionDate, TransactionTypeId) EnrollmentTransactionId0,
		CreatedDate
	FROM dbo.EnrollmentTransaction
	WHERE PeopleId = @pid AND (OrganizationId = @orgid OR @orgid = 0)
	ORDER BY TransactionDate

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Promotion]'
GO
CREATE TABLE [dbo].[Promotion]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FromDivId] [int] NULL,
[ToDivId] [int] NULL,
[Description] [nvarchar] (200) NULL,
[Sort] [nvarchar] (10) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Promotion] on [dbo].[Promotion]'
GO
ALTER TABLE [dbo].[Promotion] ADD CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Program]'
GO
CREATE TABLE [dbo].[Program]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) NULL,
[RptGroup] [nvarchar] (200) NULL,
[StartHoursOffset] [real] NULL,
[EndHoursOffset] [real] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Program] on [dbo].[Program]'
GO
ALTER TABLE [dbo].[Program] ADD CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MemberTags]'
GO
CREATE TABLE [dbo].[MemberTags]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (200) NULL,
[OrgId] [int] NULL,
[VolFrequency] [nvarchar] (2) NULL,
[VolStartDate] [datetime] NULL,
[VolEndDate] [datetime] NULL,
[NoCancelWeeks] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MemberTags] on [dbo].[MemberTags]'
GO
ALTER TABLE [dbo].[MemberTags] ADD CONSTRAINT [PK_MemberTags] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteAllQueriesWithNoChildren]'
GO
CREATE PROCEDURE [dbo].[DeleteAllQueriesWithNoChildren]
AS
BEGIN
	SET NOCOUNT ON;

delete from QueryBuilderClauses where queryid in (select q.queryid
FROM       QueryBuilderClauses q
where not exists (select null from QueryBuilderClauses where groupid = q.queryid))

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contact]'
GO
CREATE TABLE [dbo].[Contact]
(
[ContactId] [int] NOT NULL IDENTITY(200000, 1),
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[ContactTypeId] [int] NULL,
[ContactDate] [datetime] NOT NULL,
[ContactReasonId] [int] NULL,
[MinistryId] [int] NULL,
[NotAtHome] [bit] NULL,
[LeftDoorHanger] [bit] NULL,
[LeftMessage] [bit] NULL,
[GospelShared] [bit] NULL,
[PrayerRequest] [bit] NULL,
[ContactMade] [bit] NULL,
[GiftBagGiven] [bit] NULL,
[Comments] [nvarchar] (max) NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[LimitToRole] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Contacts] on [dbo].[Contact]'
GO
ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED  ([ContactId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Contact] on [dbo].[Contact]'
GO
CREATE NONCLUSTERED INDEX [IX_Contact] ON [dbo].[Contact] ([LimitToRole])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BundleHeader]'
GO
CREATE TABLE [dbo].[BundleHeader]
(
[BundleHeaderId] [int] NOT NULL IDENTITY(1, 1),
[ChurchId] [int] NOT NULL,
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[RecordStatus] [bit] NOT NULL,
[BundleStatusId] [int] NOT NULL,
[ContributionDate] [datetime] NOT NULL,
[BundleHeaderTypeId] [int] NOT NULL,
[DepositDate] [datetime] NULL,
[BundleTotal] [numeric] (10, 2) NULL,
[TotalCash] [numeric] (10, 2) NULL,
[TotalChecks] [numeric] (10, 2) NULL,
[TotalEnvelopes] [numeric] (10, 2) NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[FundId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [BUNDLE_HEADER_PK] on [dbo].[BundleHeader]'
GO
ALTER TABLE [dbo].[BundleHeader] ADD CONSTRAINT [BUNDLE_HEADER_PK] PRIMARY KEY NONCLUSTERED  ([BundleHeaderId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [BUNDLE_HEADER_CHURCH_FK_IX] on [dbo].[BundleHeader]'
GO
CREATE NONCLUSTERED INDEX [BUNDLE_HEADER_CHURCH_FK_IX] ON [dbo].[BundleHeader] ([ChurchId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BundleDetail]'
GO
CREATE TABLE [dbo].[BundleDetail]
(
[BundleDetailId] [int] NOT NULL IDENTITY(1, 1),
[BundleHeaderId] [int] NOT NULL,
[ContributionId] [int] NOT NULL,
[CreatedBy] [int] NOT NULL,
[CreatedDate] [datetime] NOT NULL,
[BundleSort1] [int] NULL,
[RefOrgId] [int] NULL,
[RefPeopleId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [BUNDLE_DETAIL_PK] on [dbo].[BundleDetail]'
GO
ALTER TABLE [dbo].[BundleDetail] ADD CONSTRAINT [BUNDLE_DETAIL_PK] PRIMARY KEY NONCLUSTERED  ([BundleDetailId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [BUNDLE_DETAIL_BUNDLE_FK_IX] on [dbo].[BundleDetail]'
GO
CREATE NONCLUSTERED INDEX [BUNDLE_DETAIL_BUNDLE_FK_IX] ON [dbo].[BundleDetail] ([BundleHeaderId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [BUNDLE_DETAIL_CONTR_FK_IX] on [dbo].[BundleDetail]'
GO
CREATE NONCLUSTERED INDEX [BUNDLE_DETAIL_CONTR_FK_IX] ON [dbo].[BundleDetail] ([ContributionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AuditValues]'
GO
CREATE TABLE [dbo].[AuditValues]
(
[AuditId] [int] NOT NULL,
[MemberName] [nvarchar] (50) NOT NULL,
[OldValue] [nvarchar] (max) NULL,
[NewValue] [nvarchar] (max) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_AuditValues] on [dbo].[AuditValues]'
GO
ALTER TABLE [dbo].[AuditValues] ADD CONSTRAINT [PK_AuditValues] PRIMARY KEY CLUSTERED  ([AuditId], [MemberName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Audits]'
GO
CREATE TABLE [dbo].[Audits]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Action] [nvarchar] (20) NOT NULL,
[TableName] [nvarchar] (100) NOT NULL,
[TableKey] [int] NULL,
[UserName] [nvarchar] (50) NOT NULL,
[AuditDate] [smalldatetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Audits] on [dbo].[Audits]'
GO
ALTER TABLE [dbo].[Audits] ADD CONSTRAINT [PK_Audits] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PurgeAllButOrg]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PurgeAllButOrg](@orgid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

DECLARE @people TABLE ( id INT )

INSERT INTO @people
SELECT PeopleId
FROM dbo.People p
WHERE NOT EXISTS(
	SELECT NULL FROM dbo.OrganizationMembers om
	JOIN dbo.People pp ON om.PeopleId = pp.PeopleId
	WHERE OrganizationId = @orgid AND pp.FamilyId = p.FamilyId
	)
	AND NOT EXISTS(
	SELECT NULL FROM dbo.EnrollmentTransaction et
	JOIN dbo.People pp ON et.PeopleId = pp.PeopleId
	WHERE OrganizationId = @orgid AND pp.FamilyId = p.FamilyId
	)
	
DELETE dbo.SoulMate
	
DELETE dbo.LoveRespect

DELETE dbo.OrgMemMemTags
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.OrganizationMembers
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.BadET
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.EnrollmentTransaction
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.MOBSReg
WHERE PeopleId IN (SELECT id FROM @people)
	
DELETE dbo.Attend
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.BundleDetail
FROM dbo.BundleDetail bd
JOIN dbo.Contribution c ON bd.ContributionId = c.ContributionId
WHERE PeopleId IN (SELECT id FROM @people)
	
DELETE dbo.Contribution
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.VolunteerForm
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.Volunteer
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.Contactees
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.Contactors
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.TagPerson
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.Task
WHERE WhoId IN (SELECT id FROM @people)

DELETE dbo.Task
WHERE OwnerId IN (SELECT id FROM @people)

DELETE dbo.Task
WHERE CoOwnerId IN (SELECT id FROM @people)

DELETE dbo.TaskListOwners
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.Preferences
WHERE UserId IN (SELECT UserId FROM Users
WHERE PeopleId IN (SELECT id FROM @people))

DELETE dbo.ActivityLog
WHERE UserId IN (SELECT UserId FROM Users
WHERE PeopleId IN (SELECT id FROM @people))

DELETE dbo.UserRole
WHERE UserId IN (SELECT UserId FROM Users
WHERE PeopleId IN (SELECT id FROM @people))

DELETE FROM dbo.PeopleCanEmailFor WHERE OnBehalfOf IN (SELECT id FROM @people)
DELETE FROM dbo.PeopleCanEmailFor WHERE CanEmail IN (SELECT id FROM @people)
		
DELETE dbo.VolunteerForm
WHERE UploaderId IN (SELECT UserId FROM Users
WHERE PeopleId IN (SELECT id FROM @people))

DELETE dbo.Users
WHERE UserId IN (SELECT UserId FROM Users
WHERE PeopleId IN (SELECT id FROM @people))
	
DELETE dbo.TagPerson
DELETE dbo.TagShare
DELETE dbo.Tag

DELETE dbo.RecReg
WHERE PeopleId IN (SELECT id FROM @people)
	
DELETE dbo.VBSApp
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.VolInterestInterestCodes

DELETE dbo.VolInterestCodes

UPDATE dbo.Families
SET HeadOfHouseholdId = NULL, HeadOfHouseholdSpouseId = NULL

UPDATE dbo.People
SET PictureId = NULL 
WHERE PeopleId IN (SELECT id FROM @people)

DELETE dbo.Picture
FROM dbo.Picture pic
WHERE NOT EXISTS(SELECT NULL FROM dbo.People WHERE PictureId = pic.PictureId)

---------------------------------------
DELETE dbo.People
WHERE PeopleId IN (SELECT id FROM @people)
---------------------------------------

DELETE dbo.RelatedFamilies
FROM dbo.RelatedFamilies r
JOIN dbo.Families f ON r.FamilyId = f.FamilyId
WHERE (SELECT COUNT(*) FROM dbo.People WHERE FamilyId = f.FamilyId) = 0

DELETE dbo.RelatedFamilies
FROM dbo.RelatedFamilies r
JOIN dbo.Families f ON r.RelatedFamilyId = f.FamilyId
WHERE (SELECT COUNT(*) FROM dbo.People WHERE FamilyId = f.FamilyId) = 0

DELETE dbo.Families 
FROM dbo.Families f
WHERE (SELECT COUNT(*) FROM dbo.People WHERE FamilyId = f.FamilyId) = 0
	
----------------------------------------------------------------------------
DELETE dbo.Contact
FROM dbo.Contact nc
WHERE NOT EXISTS(SELECT NULL FROM dbo.Contactees WHERE ContactId = nc.ContactId)
AND NOT EXISTS(SELECT NULL FROM dbo.Contactors WHERE ContactId = nc.ContactId)

DELETE dbo.Meetings
FROM dbo.Meetings m
WHERE NOT EXISTS(SELECT NULL FROM dbo.Attend WHERE MeetingId = m.MeetingId)

DELETE dbo.DivOrg
FROM dbo.DivOrg od
JOIN dbo.Organizations o ON od.OrgId = o.OrganizationId
WHERE NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers WHERE OrganizationId = o.OrganizationId)
AND NOT EXISTS(SELECT NULL FROM dbo.EnrollmentTransaction WHERE OrganizationId = o.OrganizationId)

DELETE dbo.MemberTags
FROM dbo.MemberTags mt
JOIN dbo.Organizations o ON mt.OrgId = o.OrganizationId
WHERE NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers WHERE OrganizationId = o.OrganizationId)

DELETE dbo.Organizations
FROM dbo.Organizations o
WHERE NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers WHERE OrganizationId = o.OrganizationId)
AND NOT EXISTS(SELECT NULL FROM dbo.EnrollmentTransaction WHERE OrganizationId = o.OrganizationId)
AND NOT EXISTS(SELECT NULL FROM dbo.Attend WHERE OrganizationId = o.OrganizationId)

DELETE dbo.Promotion

DELETE dbo.Division
FROM dbo.Division d
WHERE NOT EXISTS(SELECT NULL FROM dbo.DivOrg WHERE DivId = d.Id)
AND NOT EXISTS(SELECT NULL FROM dbo.Organizations WHERE DivisionId = d.Id)
AND NOT EXISTS(SELECT NULL FROM dbo.RecLeague WHERE DivId = d.Id)

DELETE dbo.Program
FROM dbo.Program p
WHERE NOT EXISTS(SELECT NULL FROM dbo.Division WHERE ProgId = p.Id)

DELETE dbo.TaskList
FROM dbo.TaskList t
WHERE NOT EXISTS(SELECT NULL FROM  dbo.Users WHERE UserId = t.CreatedBy)

DELETE Tag
FROM dbo.Tag t
WHERE PeopleId IS NULL
AND NOT EXISTS(SELECT NULL FROM dbo.TagPerson WHERE Id = t.Id)

DELETE dbo.BundleDetail
FROM dbo.BundleDetail bd
WHERE EXISTS(SELECT NULL FROM dbo.Contribution WHERE ContributionId = bd.ContributionId AND PeopleId IS NULL)

DELETE FROM dbo.Contribution WHERE PeopleId IS NULL

DELETE dbo.BundleHeader
FROM dbo.BundleHeader h
WHERE NOT EXISTS(SELECT NULL FROM dbo.BundleDetail WHERE BundleHeaderId = h.BundleHeaderId)

DELETE FROM dbo.AuditValues
DELETE FROM dbo.Audits

EXEC dbo.DeleteAllQueriesWithNoChildren
EXEC dbo.DeleteAllQueriesWithNoChildren
EXEC dbo.DeleteAllQueriesWithNoChildren
EXEC dbo.DeleteAllQueriesWithNoChildren

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ShowOddTransactions]'
GO
CREATE PROCEDURE [dbo].[ShowOddTransactions]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @t TABLE(PeopleId INT, OrgId INT)

	DECLARE @tid INT, @typeid INT, @orgid INT, @pid INT
	DECLARE @ptid INT = 0, @ptypeid INT = 0, @porgid INT = 0, @ppid INT = 0

	DECLARE c CURSOR FOR
	SELECT TransactionId, TransactionTypeId, OrganizationId, PeopleId 
	FROM dbo.EnrollmentTransaction
	ORDER BY PeopleId, OrganizationId, TransactionId

	OPEN c
	FETCH NEXT FROM c INTO @tid, @typeid, @orgid, @pid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @ppid = @pid AND @porgid = @orgid
		BEGIN
			IF (@typeid < 3 AND @ptypeid < 3) or (@typeid > 3 AND @ptypeid > 3)
				INSERT @t (PeopleId, OrgId) VALUES (@pid, @orgid)
		END
		
		SELECT @ptid = @tid, @ptypeid = @typeid, @porgid = @orgid, @ppid = @pid
		FETCH NEXT FROM c INTO @tid, @typeid, @orgid, @pid
	END
	CLOSE c
	DEALLOCATE c
	
	DECLARE cc CURSOR FOR
	SELECT DISTINCT * FROM @t
	OPEN cc
	FETCH NEXT FROM cc INTO @pid, @orgid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC dbo.ShowTransactions @pid, @orgid
		FETCH NEXT FROM cc INTO @pid, @orgid
	END
	CLOSE cc
	DEALLOCATE cc
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[HomePhone]'
GO
CREATE FUNCTION [dbo].[HomePhone](@pid int)
RETURNS nvarchar(11)
AS
	BEGIN
	declare @homephone nvarchar(11)
	select @homephone = f.HomePhone from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @homephone
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RepairTransactionsRun]'
GO
CREATE TABLE [dbo].[RepairTransactionsRun]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[started] [datetime] NULL,
[count] [int] NULL,
[processed] [int] NULL,
[completed] [datetime] NULL,
[error] [nvarchar] (200) NULL,
[orgid] [int] NULL,
[running] AS (case when [completed] IS NULL AND [error] IS NULL AND datediff(minute,[started],getdate())<(120) then (1) else (0) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_RepairTransactionsRun] on [dbo].[RepairTransactionsRun]'
GO
ALTER TABLE [dbo].[RepairTransactionsRun] ADD CONSTRAINT [PK_RepairTransactionsRun] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PopulateComputedEnrollmentTransactions]'
GO
CREATE PROCEDURE [dbo].[PopulateComputedEnrollmentTransactions] (@orgid INT)
AS
BEGIN
	INSERT INTO dbo.RepairTransactionsRun(started, processed, orgid, count)
	VALUES(GETDATE(), 0, @orgid, 
		(SELECT COUNT(*) FROM dbo.OrganizationMembers WHERE OrganizationId = @orgid))
	        
	UPDATE dbo.EnrollmentTransaction
	SET NextTranChangeDate = dbo.NextTranChangeDate(PeopleId, OrganizationId, TransactionDate, TransactionTypeId),
		EnrollmentTransactionId = dbo.EnrollmentTransactionId(PeopleId, OrganizationId, TransactionDate, TransactionTypeId)
	WHERE OrganizationId = @orgid
	        
	DECLARE @id INT 
	SELECT TOP 1 @id = id FROM dbo.RepairTransactionsRun
	WHERE orgid = @orgid
	ORDER BY id DESC
	
	DECLARE cur3 CURSOR FOR 
	SELECT PeopleId 
	FROM dbo.OrganizationMembers
	WHERE OrganizationId = @orgid
	OPEN cur3
	DECLARE @pid INT, @n INT
	FETCH NEXT FROM cur3 INTO @pid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXECUTE dbo.UpdateAttendStr @orgid, @pid
		UPDATE dbo.RepairTransactionsRun
		SET processed = processed + 1
		WHERE id = @id
		FETCH NEXT FROM cur3 INTO @pid
	END
	CLOSE cur3
	DEALLOCATE cur3
	
	UPDATE dbo.RepairTransactionsRun
	SET completed = GETDATE()
	WHERE id = @id
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SundayForDate]'
GO
create function dbo.SundayForDate(@dt DATETIME) 
returns		datetime
as
begin
	declare	 @stdt	datetime
	declare	 @fdt	datetime
	select @fdt = convert(datetime,-53690+((1+5)%7))
	select @stdt = dateadd(dd,(datediff(dd,@fdt,@dt)/7)*7,@fdt)
	return @stdt
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[WeeklyAttendsForOrgs]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[WeeklyAttendsForOrgs]
(
	@orgs VARCHAR(MAX),
	@firstdate datetime
)
RETURNS 
@tt TABLE 
(
	PeopleId INT NOT NULL,
	Attended BIT NOT NULL,
	Sunday DATETIME NOT NULL
)
AS
BEGIN

	DECLARE @t TABLE (id INT)
	INSERT INTO @t SELECT i.Value FROM dbo.SplitInts(@orgs) i

	INSERT INTO @tt
	SELECT PeopleId
		, MAX(CAST(AttendanceFlag AS INT)) Attended
		, dbo.SundayForDate(MIN(MeetingDate)) Sunday
	FROM
	(
		SELECT
			a.PeopleId,
			a.MeetingDate,
			a.AttendanceFlag,
			DATEPART(yy, a.MeetingDate) YearNum,
			DATEPART(isowk, a.MeetingDate) WeekNum
		FROM dbo.Attend a
		JOIN dbo.People p ON p.PeopleId = a.PeopleId
		WHERE a.OrganizationId IN (SELECT id FROM @t)
		AND a.MeetingDate > @firstdate
		-- exclude RecentVisitor, NewVisitor, Prospect, Group
		AND a.AttendanceTypeId NOT IN (50, 60, 190, 90)
	) t1
	GROUP BY t1.PeopleId, t1.YearNum, t1.WeekNum
	
	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryZip]'
GO
CREATE FUNCTION [dbo].[PrimaryZip] ( @pid int )
RETURNS nvarchar(11)
AS
	BEGIN
declare @zip nvarchar(11)
select @zip =
	case AddressTypeId
			when 10 then f.ZipCode
			when 30 then p.ZipCode
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @zip
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryState]'
GO
CREATE FUNCTION [dbo].[PrimaryState] ( @pid int )
RETURNS nvarchar(5)
AS
	BEGIN
declare @st nvarchar(5)
select @st =
	case AddressTypeId
			when 10 then f.StateCode
			when 30 then p.StateCode
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @st
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryResCode]'
GO
CREATE FUNCTION [dbo].[PrimaryResCode]( @pid int )
RETURNS int
AS
	BEGIN
declare @rescodeid int
select @rescodeid =
	case AddressTypeId
		when 10 then f.ResCodeId
		when 30 then p.ResCodeId
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

if @rescodeid is null
	select @rescodeid = 40

	RETURN @rescodeid
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryCity]'
GO
CREATE FUNCTION [dbo].[PrimaryCity] ( @pid int )
RETURNS nvarchar(50)
AS
	BEGIN
declare @city nvarchar(50)
select @city =
	case AddressTypeId
			when 10 then f.CityName
			when 30 then p.CityName
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @city
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryBadAddressFlag]'
GO
CREATE FUNCTION [dbo].[PrimaryBadAddressFlag]( @pid int )
RETURNS int
AS
	BEGIN
declare @flag bit
select @flag =
	case AddressTypeId
		when 10 then f.BadAddressFlag
		when 30 then p.BadAddressFlag
	end
	
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

if (@flag is null)
	select @flag = 0

	RETURN @flag
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryAddress2]'
GO
CREATE FUNCTION [dbo].[PrimaryAddress2] ( @pid int )
RETURNS nvarchar(60)
AS
	BEGIN
declare @addr nvarchar(60)
select @addr =
	case AddressTypeId
			when 10 then f.AddressLineTwo
			when 30 then p.AddressLineTwo
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @addr
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrimaryAddress]'
GO
CREATE FUNCTION [dbo].[PrimaryAddress] ( @pid int )
RETURNS nvarchar(60)
AS
	BEGIN
declare @addr nvarchar(60)
select @addr =
	case AddressTypeId
			when 10 then f.AddressLineOne
			when 30 then p.AddressLineOne
	end
from dbo.People p join dbo.Families f on f.FamilyId = p.FamilyId
where PeopleId = @pid

	RETURN @addr
	END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Zips]'
GO
CREATE TABLE [dbo].[Zips]
(
[ZipCode] [nvarchar] (10) NOT NULL,
[MetroMarginalCode] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Zips] on [dbo].[Zips]'
GO
ALTER TABLE [dbo].[Zips] ADD CONSTRAINT [PK_Zips] PRIMARY KEY CLUSTERED  ([ZipCode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FindResCode]'
GO
CREATE FUNCTION [dbo].FindResCode
(
	@zipcode nvarchar(20)
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	DECLARE @z5 nvarchar(10)

	IF (@zipcode IS NOT NULL AND LEN(@zipcode) >= 5)
	BEGIN
		SELECT @z5 = SUBSTRING(@zipcode, 1, 5)
		SELECT @Result = MetroMarginalCode FROM dbo.Zips WHERE ZipCode = @z5
		IF @Result IS NULL
			SELECT @Result = 30
	END
	-- Return the result of the function
	RETURN @Result

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updFamily] on [dbo].[Families]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[updFamily] 
   ON  [dbo].[Families] 
   FOR UPDATE, INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF UPDATE(HomePhone)
	BEGIN
		UPDATE dbo.People
		SET HomePhone = f.HomePhone
		FROM dbo.People p
		JOIN dbo.Families f ON p.FamilyId = f.FamilyId
		WHERE f.FamilyId IN (SELECT FamilyId FROM INSERTED)
		
		UPDATE dbo.Families
		SET HomePhoneLU = RIGHT(HomePhone, 7),
			HomePhoneAC = LEFT(RIGHT(REPLICATE('0',10) + HomePhone, 10), 3)
		WHERE FamilyId IN (SELECT FamilyId FROM INSERTED)
	END
	
	IF UPDATE(ResCodeId)
		UPDATE dbo.People
		SET PrimaryResCode = dbo.PrimaryResCode(PeopleId)
		WHERE FamilyId IN (SELECT FamilyId FROM inserted)
	
	IF UPDATE(CityName) 
	OR UPDATE(AddressLineOne) 
	OR UPDATE(AddressLineTwo) 
	OR UPDATE(StateCode) 
	OR UPDATE(ZipCode)
	OR UPDATE(CountryName)
	OR UPDATE(BadAddressFlag) 
	BEGIN
		UPDATE dbo.Families
		SET ResCodeId = dbo.FindResCode(ZipCode)
		WHERE FamilyId IN (SELECT FamilyId FROM INSERTED)
		
		UPDATE dbo.People
		SET PrimaryCity = dbo.PrimaryCity(PeopleId),
		PrimaryAddress = dbo.PrimaryAddress(PeopleId),
		PrimaryAddress2 = dbo.PrimaryAddress2(PeopleId),
		PrimaryState = dbo.PrimaryState(PeopleId),
		PrimaryBadAddrFlag = dbo.PrimaryBadAddressFlag(PeopleId),
		PrimaryResCode = dbo.PrimaryResCode(PeopleId),
		PrimaryZip = dbo.PrimaryZip(PeopleId),
		PrimaryCountry = dbo.PrimaryCountry(PeopleId)
		WHERE FamilyId IN (SELECT FamilyId FROM inserted)
	END

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[NextChangeTransactionId2]'
GO
CREATE FUNCTION [dbo].[NextChangeTransactionId2]
(
  @pid int
 ,@oid int
 ,@tid int
 ,@typeid int
)
RETURNS int
AS
	BEGIN
	  DECLARE @rtid int 
		  select top 1 @rtid = TransactionId
			from dbo.EnrollmentTransaction
		   where TransactionTypeId >= 3
		     and @typeid <= 3
			 and PeopleId = @pid
			 and OrganizationId = @oid
			 and TransactionId > @tid
			 AND TransactionStatus = 0
	   order by TransactionId
	RETURN @rtid
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MembersWhoAttendedOrgs]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[MembersWhoAttendedOrgs]
(
	@orgs VARCHAR(MAX),
	@firstdate datetime
)
RETURNS 
@tt TABLE 
(
	PeopleId INT NOT NULL,
	Name2 VARCHAR(90),
	Age INT,
	BibleFellowshipClassId INT,
	OrganizationName VARCHAR(100),
	LeaderName VARCHAR(90)
)
AS
BEGIN
	DECLARE @t TABLE (id INT)
	INSERT INTO @t SELECT i.Value FROM dbo.SplitInts(@orgs) i

	INSERT INTO @tt
		SELECT DISTINCT a.PeopleId
			, p.Name2
			, p.Age
			, p.BibleFellowshipClassId
			, o.OrganizationName
			, o.LeaderName
		FROM dbo.Attend a
		JOIN dbo.People p ON p.PeopleId = a.PeopleId
		LEFT JOIN dbo.Organizations o ON o.OrganizationId = p.BibleFellowshipClassId
		WHERE a.OrganizationId IN (SELECT Id FROM @t)
		AND a.MeetingDate > @firstdate
		-- exclude RecentVisitor, NewVisitor, Prospect, Group
		AND a.AttendanceTypeId NOT IN (50, 60, 190, 90)
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[NextChangeTransactionId]'
GO
CREATE FUNCTION [dbo].[NextChangeTransactionId]
(
  @pid int
 ,@oid int
 ,@tid int
 ,@typeid int
)
RETURNS int
AS
	BEGIN
	  DECLARE @rtid int 
		  select top 1 @rtid = TransactionId
			from dbo.EnrollmentTransaction
		   where TransactionTypeId >= 3
		     and @typeid <= 3
			 and PeopleId = @pid
			 and OrganizationId = @oid
			 and TransactionId > @tid
	   order by TransactionId
	RETURN @rtid
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetPeopleIdFromIndividualNumber]'
GO
CREATE FUNCTION [dbo].[GetPeopleIdFromIndividualNumber](@indnum int)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @id int

	-- Add the T-SQL statements to compute the return value here
	SELECT @id = PeopleId 
	FROM dbo.PeopleExtra
	WHERE Field = 'IndividualNumber' 
	AND IntValue = @indnum

	-- Return the result of the function
	RETURN @id

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LinkEnrollmentTransaction]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LinkEnrollmentTransaction] (@tid INT, @trandt DATETIME, @typeid INT, @orgid INT, @pid int)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @etid INT -- Find the original enrollment transaction
	SELECT TOP 1 @etid = TransactionId
	FROM dbo.EnrollmentTransaction
	WHERE TransactionTypeId <= 2
		AND PeopleId = @pid
		AND OrganizationId = @orgid
		AND TransactionId < @tid
		AND @typeid >= 3
	ORDER  BY  TransactionId DESC 

	-- point the current transction to the original enrollment
	UPDATE dbo.EnrollmentTransaction
	SET EnrollmentTransactionId = @etid
	WHERE TransactionId = @tid AND @etid IS NOT NULL

	DECLARE @previd INT -- find previous transaction
	
	SELECT TOP 1 @previd = TransactionId
	FROM dbo.EnrollmentTransaction
	WHERE TransactionTypeId <= 3
		AND @typeid >= 3
		AND PeopleId = @pid
		AND OrganizationId = @orgid
		AND TransactionId < @tid
	ORDER BY TransactionId DESC
	
	-- set the previous transaction's next tran date
	UPDATE dbo.EnrollmentTransaction
	SET NextTranChangeDate = @trandt
	WHERE TransactionId = @previd
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LinkEnrollmentTransactions]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LinkEnrollmentTransactions] (@pid INT, @orgid INT)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @tid INT, @typeid INT, @tdt DATETIME

	DECLARE c CURSOR FOR
	SELECT TransactionId, TransactionTypeId, TransactionDate
	FROM dbo.EnrollmentTransaction et
	WHERE et.TransactionStatus = 0 AND et.PeopleId = @pid AND et.OrganizationId = @orgid
	ORDER BY TransactionDate, TransactionId

	OPEN c
	FETCH NEXT FROM c INTO @tid, @typeid, @tdt
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC dbo.LinkEnrollmentTransaction @tid, @tdt, @typeid, @orgid, @pid
		FETCH NEXT FROM c INTO @tid, @typeid, @tdt
	END
	CLOSE c
	DEALLOCATE c
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[insEnrollmentTransaction] on [dbo].[EnrollmentTransaction]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[insEnrollmentTransaction] 
   ON  [dbo].[EnrollmentTransaction] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @tid INT, @trandt DATETIME, @typeid INT, @orgid INT, @pid INT

	DECLARE cet CURSOR FORWARD_ONLY FOR
	SELECT TransactionId, TransactionDate, TransactionTypeId, OrganizationId, PeopleId 
	FROM inserted 
	WHERE TransactionTypeId > 2

	OPEN cet
	FETCH NEXT FROM cet INTO @tid, @trandt, @typeid, @orgid, @pid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC dbo.LinkEnrollmentTransaction @tid, @trandt, @typeid, @orgid, @pid
		FETCH NEXT FROM cet INTO @tid, @trandt, @typeid, @orgid, @pid
	END
	CLOSE cet
	DEALLOCATE cet
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendUpdateN]'
GO
CREATE PROC [dbo].[AttendUpdateN] (@pid INT)
AS
BEGIN

	IF (SELECT COUNT(*) FROM Attend WHERE PeopleId = @pid AND AttendanceFlag = 1) >= 10
		RETURN 0;

	UPDATE dbo.Attend
	SET SeqNo = NULL
	WHERE PeopleId = @pid;
	
	WITH vv (AttendId, Rnk)
	AS
	(
	SELECT a.AttendId, yy.Rnk FROM Attend a
	JOIN
	(
		SELECT MeetingDate, ROW_NUMBER() OVER(ORDER BY MeetingDate) AS Rnk
	    FROM
	    (
			SELECT DISTINCT TOP(5) CAST(MeetingDate AS DATE) MeetingDate
			FROM Attend
	        WHERE PeopleId = @pid AND AttendanceFlag = 1
	    ) tt
	) yy ON CAST(a.MeetingDate AS DATE) = yy.MeetingDate
	WHERE a.PeopleId = @pid
	) 
	UPDATE Attend
	SET SeqNo = vv.Rnk
	FROM vv
	WHERE vv.AttendId = Attend.AttendId

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserPeopleIdFromEmail]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UserPeopleIdFromEmail]
(
@email nvarchar(50)
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @pid INT

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP(1) @pid = PeopleId FROM dbo.Users
	WHERE EmailAddress = @email
	

	-- Return the result of the function
	RETURN @pid

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllAttendN]'
GO
CREATE PROCEDURE [dbo].[UpdateAllAttendN] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE dbo.Attend SET SeqNo = NULL
	
    -- Insert statements for procedure here
		DECLARE cur CURSOR FOR 
		SELECT PeopleId 
		FROM dbo.People p WHERE (SELECT COUNT(*) FROM Attend WHERE PeopleId = p.PeopleId AND AttendanceFlag = 1) < 10
		OPEN cur
		DECLARE @pid INT
		FETCH NEXT FROM cur INTO @pid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.AttendUpdateN @pid
			FETCH NEXT FROM cur INTO @pid
		END
		CLOSE cur
		DEALLOCATE cur
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[City]'
GO
CREATE VIEW [dbo].[City]
AS
SELECT PrimaryCity AS City, PrimaryState AS State, PrimaryZip AS Zip, COUNT(*) AS [count] FROM dbo.People GROUP BY PrimaryCity, PrimaryState, PrimaryZip
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTodaysMeetingId]'
GO
CREATE FUNCTION [dbo].[GetTodaysMeetingId]
    (
      @orgid INT ,
      @thisday INT
    )
RETURNS INT 
AS 
    BEGIN
        DECLARE 
			@DefaultHour DATETIME,
            @DefaultDay INT,
            @prevMidnight DATETIME,
            @ninetyMinutesAgo DATETIME,
            @nextMidnight DATETIME
            
        DECLARE @dt DATETIME = GETDATE()
		DECLARE @d DATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @dt))
		DECLARE @t DATETIME = @dt - @d
		DECLARE @simulatedTime DATETIME

        IF @thisday IS NULL
			SELECT @thisday = DATEPART(dw, GETDATE()) - 1
			
		DECLARE @plusdays INT = @thisday - (DATEPART(dw, GETDATE())-1) + 7
		IF @plusdays > 6
			SELECT @plusdays = @plusdays - 7
		SELECT @prevMidnight = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays
        SELECT @nextMidnight = @prevMidnight + 1
		SELECT @simulatedTime = @prevMidnight + @t
        SELECT @ninetyMinutesAgo = DATEADD(mi, -90, @simulatedTime)
        
        SELECT  @DefaultHour = MeetingTime,
                @DefaultDay = ISNULL(SchedDay, 0)
        FROM    dbo.OrgSchedule
        WHERE   OrganizationId = @orgid AND Id = 1
        
        DECLARE @meetingid INT, @meetingdate DATETIME
        
        SELECT TOP 1 @meetingid = MeetingId FROM dbo.Meetings
        WHERE OrganizationId = @orgid
        AND MeetingDate >= @ninetyMinutesAgo
        AND MeetingDate < @nextMidnight
        ORDER BY MeetingDate
        
        IF @meetingid IS NULL
			SELECT TOP 1 @meetingid = MeetingId FROM dbo.Meetings
			WHERE OrganizationId = @orgid
			AND MeetingDate >= @prevMidnight
			AND MeetingDate < @nextMidnight
			ORDER BY MeetingDate
			
			RETURN @meetingid
		--RETURN ISNULL(@meetingid, 0)

    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetAttendedTodaysMeeting]'
GO
CREATE FUNCTION dbo.GetAttendedTodaysMeeting
    (
      @orgid INT ,
      @thisday INT,
      @pid INT
    )
RETURNS BIT
AS 
    BEGIN
        IF @thisday IS NULL
			SELECT @thisday = DATEPART(dw, GETDATE()) - 1

		DECLARE @attended BIT, @meetingid INT
		
		SELECT @meetingid = dbo.GetTodaysMeetingId(@orgid, @thisday)
		
		IF @meetingid IS NOT NULL
			SELECT @attended = AttendanceFlag FROM dbo.Attend 
			WHERE MeetingId = @meetingid AND PeopleId = @pid
		IF (@attended IS NULL)
			SELECT @attended = 0

        RETURN @attended
    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAttendance]'
GO
CREATE FUNCTION [dbo].[RecentAttendance] (@oid int)
RETURNS TABLE 
AS RETURN
(
SELECT a.PeopleId, 
	p.Name,
	a.MeetingDate lastattend, 
	om.AttendPct,
	om.AttendStr,
	tt.Description attendtype,
	CASE WHEN om.OrganizationId = @oid THEN 0 ELSE 1 END visitor
FROM 
(
SELECT aa.PeopleId, MAX(m.MeetingDate) dt
FROM dbo.Attend aa
JOIN dbo.Meetings m ON aa.MeetingId = m.MeetingId
JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
WHERE m.OrganizationId = @oid
AND (o.FirstMeetingDate IS NULL OR m.MeetingDate >= o.FirstMeetingDate)
AND aa.AttendanceFlag = 1
GROUP BY aa.PeopleId
) at
JOIN Attend a ON at.PeopleId = a.PeopleId AND a.OrganizationId = @oid AND a.MeetingDate = at.dt
JOIN lookup.AttendType tt ON a.AttendanceTypeId = tt.Id
JOIN dbo.People p ON p.PeopleId = a.PeopleId
LEFT JOIN dbo.OrganizationMembers om ON at.PeopleId = om.PeopleId AND @oid = om.OrganizationId
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contributors]'
GO
CREATE FUNCTION [dbo].[Contributors](@fd DATETIME, @td DATETIME, @pid INT, @spid INT, @fid INT, @noaddrok BIT)
RETURNS TABLE 
AS
RETURN 
(
	SELECT	
			p.PrimaryAddress,
			p.PrimaryAddress2,
			p.PrimaryCity,
			p.PrimaryState,
			p.PrimaryZip,
			p.FamilyId,
			
			p.PeopleId, 
			p.LastName,
			p.FirstName + ' ' + p.LastName AS Name, 
			p.TitleCode AS Title, 
			p.SuffixCode AS Suffix,
			CASE 
				WHEN 2 IN (ISNULL(p.ContributionOptionsId, 0), ISNULL(sp.ContributionOptionsId,0)) 
						AND ISNULL(p.ContributionOptionsId,0) <> 9 THEN 2 
				WHEN ISNULL(p.ContributionOptionsId,0) = 2 
						AND (sp.PeopleId IS NULL OR ISNULL(sp.ContributionOptionsId, 0) = 9) THEN 1
				WHEN p.ContributionOptionsId IS NULL THEN 0
				ELSE p.ContributionOptionsId
			END AS ContributionOptionsId,
			p.DeceasedDate,
			p.Age,
			p.PositionInFamilyId,
			CASE 
				WHEN f.HeadOfHouseholdId = p.PeopleId THEN 1 
				WHEN f.HeadOfHouseholdSpouseId = p.PeopleId THEN 2 
				ELSE 3 
			END AS hohFlag,
		    ISNULL((SELECT SUM(ContributionAmount)
				FROM Contribution c 
				JOIN dbo.ContributionFund f ON c.FundId = f.FundId
				WHERE c.PeopleId = p.PeopleId
				AND ISNULL(f.NonTaxDeductible, 0) = 0
				AND c.ContributionStatusId = 0
				AND c.ContributionTypeId NOT IN (6,7)
				AND c.ContributionDate >= @fd
				AND c.ContributionDate < DATEADD(hh, 24, @td)), 0
			) AS Amount,
			CAST( CASE WHEN EXISTS(
				SELECT NULL FROM dbo.Contribution c
				JOIN dbo.ContributionFund f ON c.FundId = f.FundId
				WHERE c.PeopleId = p.PeopleId 
					-- NonTaxDeductible Fund or Pledge OR GiftInkind
					AND (ISNULL(f.NonTaxDeductible, 0) = 0 OR c.ContributionTypeId IN (8,10)) 
					AND c.ContributionStatusId = 0
					AND c.ContributionTypeId NOT IN (6,7)
					AND c.ContributionDate >= @fd
					AND c.ContributionDate < DATEADD(hh, 24, @td)) 
				THEN 1 ELSE 0 END AS BIT
			) AS GiftInKind,
			
			sp.Name AS SpouseName,
			sp.TitleCode AS SpouseTitle,
			p.SpouseId,
			CASE 
				WHEN 2 IN (ISNULL(p.ContributionOptionsId,0), ISNULL(sp.ContributionOptionsId,0)) 
						AND p.ContributionOptionsId <> 9 THEN 2 
				WHEN ISNULL(p.ContributionOptionsId,0) = 2 
						AND (sp.PeopleId IS NULL OR ISNULL(sp.ContributionOptionsId,0) = 9) THEN 1
				WHEN sp.ContributionOptionsId IS NULL THEN 0
				ELSE sp.ContributionOptionsId
				END AS SpouseContributionOptionsId,
		    ISNULL((SELECT SUM(ISNULL(ContributionAmount,0))
				FROM Contribution c 
				WHERE c.PeopleId = p.SpouseId
				AND c.ContributionStatusId = 0
				AND c.ContributionTypeId NOT IN (6,7)
				AND c.ContributionDate >= @fd
				AND c.ContributionDate < DATEADD(hh, 24, @td)),0
			) AS SpouseAmount,
			p.CampusId,
			(SELECT LastName FROM dbo.People WHERE PeopleId = f.HeadOfHouseholdId
			) AS HouseName
			
	from People p
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	LEFT OUTER JOIN dbo.People sp ON p.SpouseId = sp.PeopleId
	
	WHERE 
	(@noaddrok = 1 OR 
		(p.PrimaryAddress <> '' 
		AND p.PrimaryBadAddrFlag = 0 
		AND p.DoNotMailFlag = 0 
		AND ISNULL(p.ContributionOptionsId, 0) <> 9))
	AND (@pid = 0 OR @pid = p.PeopleId OR @spid = p.PeopleId)
	AND (@fid = 0 OR @fid = p.FamilyId)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FlagOddTransactions]'
GO
CREATE PROCEDURE [dbo].[FlagOddTransactions]
AS
BEGIN
	SET NOCOUNT ON;

	TRUNCATE TABLE dbo.BadET

	DECLARE @tid INT, @typeid INT, @orgid INT, @pid INT, @tdt DATETIME
	DECLARE @ptid INT = 0, @ptypeid INT = 0, @porgid INT = 0, @ppid INT = 0, @ptdt DATETIME

	DECLARE c CURSOR FOR
	SELECT TransactionId, TransactionTypeId, OrganizationId, PeopleId, TransactionDate
	FROM dbo.EnrollmentTransaction et
	WHERE et.TransactionStatus = 0
	ORDER BY PeopleId, OrganizationId, TransactionDate, TransactionId

	OPEN c
	FETCH NEXT FROM c INTO @tid, @typeid, @orgid, @pid, @tdt
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @ptid > 0 AND (@ppid <> @pid OR @porgid <> @orgid)
		BEGIN
			IF (@ppid <> @pid OR @porgid <> @orgid) AND 
					@ptypeid < 3 AND NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers
							WHERE OrganizationId = @porgid AND PeopleId = @ppid)
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @ppid, @porgid, @ptid, 10)
			SELECT @ptid = 0, @ptypeid = 0, @porgid = 0, @ppid = 0
		END
		IF @ptid > 0
		BEGIN
			IF @tdt = @ptdt
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @pid, @orgid, @tid, 15)
			ELSE IF @typeid < 3 AND @ptypeid <= 3
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @pid, @orgid, @tid, 11)
				
			ELSE IF @typeid > 3 AND @ptypeid > 3
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @pid, @orgid, @tid, 55)
		END

		SELECT @ptid = @tid, @ptypeid = @typeid, @porgid = @orgid, @ppid = @pid, @ptdt = @tdt

		FETCH NEXT FROM c INTO @tid, @typeid, @orgid, @pid, @tdt
	END
	CLOSE c
	DEALLOCATE c
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastContact]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.LastContact(@pid INT)
RETURNS DATETIME
AS
BEGIN
	DECLARE @dt DATETIME

	SELECT @dt = MAX(c.ContactDate) FROM dbo.Contact c
	JOIN dbo.Contactees ce ON c.ContactId = ce.ContactId
	WHERE ce.PeopleId = @pid
	IF @dt IS NULL
		SELECT @dt = DATEADD(DAY,-5000,GETDATE())

	RETURN @dt

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ContactType]'
GO
CREATE TABLE [lookup].[ContactType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NOT NULL,
[Description] [nvarchar] (100) NOT NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContactTypes] on [lookup].[ContactType]'
GO
ALTER TABLE [lookup].[ContactType] ADD CONSTRAINT [PK_ContactTypes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContactTypeTotals]'
GO
CREATE FUNCTION [dbo].[ContactTypeTotals](@dt1 DATETIME, @dt2 DATETIME, @min INT)
RETURNS TABLE 
AS
RETURN 
(
	SELECT t2.Id, t2.Description, t2.[Count], t1.CountPeople FROM
	(
		SELECT ContactTypeId, COUNT(*) [CountPeople] FROM
		(
		SELECT DISTINCT ContactTypeId, e.PeopleId
		FROM dbo.Contactees e 
		JOIN dbo.Contact c ON c.ContactId = e.ContactId
		WHERE (c.ContactDate >= @dt1 OR @dt1 IS NULL)
		AND (c.ContactDate <= @dt2 OR @dt2 IS NULL)
		AND (c.MinistryId = @min OR @min = 0)
		) tt
		GROUP BY tt.ContactTypeId
	) t1
	JOIN
	(
		SELECT Id, Description, COUNT(*) [Count]
		FROM dbo.Contact c
		JOIN lookup.ContactType t ON c.ContactTypeId = t.Id
		WHERE (c.ContactDate >= @dt1 OR @dt1 IS NULL)
		AND (c.ContactDate <= @dt2 OR @dt2 IS NULL)
		AND (c.MinistryId = @min OR @min = 0)
		GROUP BY t.Id, t.DESCRIPTION
	) t2 ON t1.ContactTypeId = t2.Id
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FlagOddTransaction]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FlagOddTransaction] (@pid INT, @orgid INT)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM dbo.BadET WHERE PeopleId = @pid AND OrgId = @orgid

	DECLARE @tid INT, @typeid INT, @tdt DATETIME
	DECLARE @ptypeid INT = 0, @ptdt DATETIME

	DECLARE c CURSOR FOR
	SELECT TransactionId, TransactionTypeId, TransactionDate
	FROM dbo.EnrollmentTransaction et
	WHERE et.TransactionStatus = 0 AND et.PeopleId = @pid AND et.OrganizationId = @orgid
	ORDER BY TransactionDate, TransactionId

	OPEN c
	FETCH NEXT FROM c INTO @tid, @typeid, @tdt
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @ptypeid > 0
		BEGIN
			IF @tdt = @ptdt
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @pid, @orgid, @tid, 15)
			ELSE IF @typeid < 3 AND @ptypeid <= 3
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @pid, @orgid, @tid, 11)
				
			ELSE IF @typeid > 3 AND @ptypeid > 3
				INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
								VALUES ( @pid, @orgid, @tid, 55)
		END

		SELECT @ptypeid = @typeid, @ptdt = @tdt

		FETCH NEXT FROM c INTO @tid, @typeid, @tdt
	END
	CLOSE c
	DEALLOCATE c

	IF @typeid < 3 AND NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers
					WHERE OrganizationId = @orgid AND PeopleId = @pid)
		INSERT INTO dbo.BadET (PeopleId, OrgId,	TranId,	Flag) 
						VALUES ( @pid, @orgid, @tid, 10)
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DaysBetween12Attend]'
GO
CREATE FUNCTION [dbo].[DaysBetween12Attend](@pid INT, @progid INT, @divid INT, @orgid INT, @lookback int)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @days INT, @d1 DATETIME, @d2 DATETIME, @d0 DATETIME, @epoch DATETIME
	
	SELECT @d0 = DATEADD(d, -@lookback, GETDATE())
	SELECT @epoch = Setting FROM dbo.Setting WHERE Id = 'DbCreatedDate'

	SELECT TOP 1 @d1 = MeetingDate FROM Attend a
	WHERE a.PeopleId = @pid
	AND a.AttendanceFlag = 1 
	AND a.MeetingDate > @epoch
	ORDER BY a.MeetingDate
	
	IF (@d1 < @d0)
		SET @d1 = NULL -- does not match criteria
	
	SELECT TOP 1 @d2 = MeetingDate FROM Attend a
	WHERE a.PeopleId = @pid AND (@orgid = 0 OR @orgid = a.OrganizationId)
	AND (@divid = 0 OR EXISTS(SELECT NULL FROM dbo.DivOrg do WHERE do.OrgId = a.OrganizationId AND do.DivId = @divid))
	AND (@progid = 0 OR EXISTS(SELECT NULL FROM dbo.DivOrg do JOIN dbo.Division d ON do.DivId = d.Id JOIN dbo.ProgDiv pd ON d.Id = pd.DivId WHERE pd.ProgId = @progid AND do.OrgId = a.OrganizationId))
	AND a.AttendanceFlag = 1
	AND DATEDIFF(d, @d1, a.MeetingDate) >= 1
	ORDER BY a.MeetingDate
	
	SELECT @days = DATEDIFF(d, @d1, @d2)

	-- Return the result of the function
	RETURN @days

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTodaysMeetingHour]'
GO
CREATE FUNCTION [dbo].[GetTodaysMeetingHour]
    (
      @thisday INT,
      @MeetingTime DATETIME,
      @SchedDay INT
    )
RETURNS DATETIME
AS 
    BEGIN
        DECLARE 
			@DefaultHour DATETIME,
            @DefaultDay INT,
            @prevMidnight DATETIME
            
        IF @thisday IS NULL
			SELECT @thisday = DATEPART(dw, GETDATE()) - 1
			
		DECLARE @plusdays INT = @thisday - (DATEPART(dw, GETDATE())-1) + 7
		IF @plusdays > 6
			SELECT @plusdays = @plusdays - 7
		SELECT @prevMidnight = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays
        
        SELECT  @DefaultHour = @MeetingTime,
                @DefaultDay = ISNULL(@SchedDay, 0)
        
        DECLARE @meetingdate DATETIME
        
		DECLARE @DefaultTime DATETIME = DATEADD(dd, -DATEDIFF(dd, 0, @DefaultHour), @DefaultHour)
		
		IF @DefaultDay = @thisday OR @DefaultDay = 10
			SELECT @meetingdate = @prevMidnight + @DefaultTime
					
        RETURN @meetingdate
    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTodaysMeetingHours]'
GO
CREATE FUNCTION [dbo].[GetTodaysMeetingHours]
    (
      @orgid INT ,
      @thisday INT
    )
RETURNS @ta TABLE ( [hour] DateTime)
AS 
    BEGIN
        DECLARE 
			--@DefaultHour DATETIME,
            --@DefaultDay INT,
            @prevMidnight DATETIME,
            @ninetyMinutesAgo DATETIME,
            @nextMidnight DATETIME
            
        DECLARE @dt DATETIME = GETDATE()
		DECLARE @d DATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @dt))
		DECLARE @t DATETIME = @dt - @d
		DECLARE @simulatedTime DATETIME

        IF @thisday IS NULL
			SELECT @thisday = DATEPART(dw, GETDATE()) - 1
			
		DECLARE @plusdays INT = @thisday - (DATEPART(dw, GETDATE())-1) + 7
		IF @plusdays > 6
			SELECT @plusdays = @plusdays - 7
		SELECT @prevMidnight = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays
        SELECT @nextMidnight = @prevMidnight + 1
		SELECT @simulatedTime = @prevMidnight + @t
        SELECT @ninetyMinutesAgo = DATEADD(mi, -90, @simulatedTime)
        
        --SELECT  @DefaultHour = MeetingTime,
        --        @DefaultDay = ISNULL(SchedDay, 0)
        --FROM    dbo.Organizations
        --WHERE   OrganizationId = @orgid

		--SET @plusdays = @DefaultDay - (DATEPART(dw, GETDATE())-1) + 7
		--IF @plusdays > 6
		--	SELECT @plusdays = @plusdays - 7
			
        DECLARE @defaultPrevMidnight DATETIME = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays

        --DECLARE @DefaultTime DATETIME = DATEADD(dd, -DATEDIFF(dd, 0, @DefaultHour), @DefaultHour) + @defaultPrevMidnight
        --IF (@DefaultDay = @thisday)
			--INSERT INTO @ta (hour) VALUES(@DefaultTime)
			
		INSERT INTO @ta 
			SELECT dbo.GetTodaysMeetingHour(@thisday, MeetingTime, SchedDay) 
			FROM dbo.OrgSchedule
			WHERE OrganizationId = @orgid
			AND dbo.GetTodaysMeetingHour(@thisday, MeetingTime, SchedDay) IS NOT NULL
			ORDER BY Id
        
		INSERT INTO @ta 
			SELECT MeetingDate FROM dbo.Meetings
			WHERE MeetingDate NOT IN (SELECT hour FROM @ta)
			AND OrganizationId = @orgid
			AND MeetingDate >= @prevMidnight
			AND MeetingDate < @nextMidnight
			ORDER BY MeetingDate
			
		RETURN

    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationExtra]'
GO
CREATE TABLE [dbo].[OrganizationExtra]
(
[OrganizationId] [int] NOT NULL,
[Field] [nvarchar] (50) NOT NULL,
[Data] [nvarchar] (max) NULL,
[DataType] [nvarchar] (5) NULL,
[StrValue] [nvarchar] (200) NULL,
[DateValue] [datetime] NULL,
[IntValue] [int] NULL,
[BitValue] [bit] NULL,
[Type] AS ((((case when [StrValue] IS NOT NULL then 'Code' else '' end+case when [Data] IS NOT NULL then 'Text' else '' end)+case when [DateValue] IS NOT NULL then 'Date' else '' end)+case when [IntValue] IS NOT NULL then 'Int' else '' end)+case when [BitValue] IS NOT NULL then 'Bit' else '' end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrganizationExtra] on [dbo].[OrganizationExtra]'
GO
ALTER TABLE [dbo].[OrganizationExtra] ADD CONSTRAINT [PK_OrganizationExtra] PRIMARY KEY CLUSTERED  ([OrganizationId], [Field])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PurgeOrganization]'
GO
CREATE PROCEDURE [dbo].[PurgeOrganization](@oid INT)
AS
BEGIN
	BEGIN TRY 
		BEGIN TRANSACTION 
		DECLARE @fid INT, @pic INT
		DELETE FROM dbo.OrgMemMemTags WHERE OrgId = @oid
		DELETE FROM dbo.OrganizationMembers WHERE OrganizationId = @oid
		DELETE FROM dbo.EnrollmentTransaction WHERE OrganizationId = @oid
		DELETE FROM dbo.Attend WHERE OrganizationId = @oid
		DELETE FROM dbo.DivOrg WHERE OrgId = @oid
		DELETE FROM dbo.Meetings WHERE OrganizationId = @oid
		DELETE FROM dbo.MemberTags WHERE OrgId = @oid
		DELETE FROM dbo.Coupons WHERE OrgId = @oid
		DELETE FROM dbo.OrgSchedule WHERE OrganizationId = @oid
		DELETE FROM dbo.OrganizationExtra WHERE OrganizationId = @oid
		UPDATE dbo.ActivityLog
		SET OrgId = NULL
		WHERE OrgId = @oid
		DELETE FROM dbo.Organizations WHERE OrganizationId = @oid
		COMMIT
	END TRY 
	BEGIN CATCH 
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;
		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PersonAttendCountOrg]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PersonAttendCountOrg]
(@pid int, @oid int)
RETURNS int
AS
	BEGIN
	RETURN (SELECT COUNT(*)
	        FROM   dbo.Attend a INNER JOIN
	                   dbo.Meetings m ON a.MeetingId = m.MeetingId
	        WHERE (m.OrganizationId = @oid) AND (a.PeopleId = @pid)
              AND a.AttendanceFlag = 1)
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeletePeopleExtras]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeletePeopleExtras](@field nvarchar)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DELETE dbo.PeopleExtra
WHERE Field = @field

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastAttended]'
GO
CREATE FUNCTION [dbo].[LastAttended] (@orgid INT, @pid INT)
RETURNS DATETIME
AS
	BEGIN
	DECLARE @dt DATETIME
		SELECT @dt = MAX(m.MeetingDate) FROM dbo.Attend a
		JOIN dbo.Meetings m
		ON a.MeetingId = m.MeetingId
		WHERE a.AttendanceFlag = 1 AND m.OrganizationId = @orgid AND a.PeopleId = @pid
	RETURN @dt
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTodaysMeetingHours2]'
GO
CREATE FUNCTION [dbo].[GetTodaysMeetingHours2]
    (
      @orgid INT ,
      @thisday INT,
      @kioskmode BIT
    )
RETURNS @ta TABLE ( [hour] DateTime)
AS 
    BEGIN
        DECLARE 
			@DefaultHour DATETIME,
            @DefaultDay INT,
            @prevMidnight DATETIME,
            @ninetyMinutesAgo DATETIME,
            @nextMidnight DATETIME
            
        DECLARE @dt DATETIME = GETDATE()
		DECLARE @d DATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @dt))
		DECLARE @t DATETIME = @dt - @d
		DECLARE @simulatedTime DATETIME

        IF @thisday IS NULL
			SELECT @thisday = DATEPART(dw, GETDATE()) - 1
			
		DECLARE @plusdays INT = @thisday - (DATEPART(dw, GETDATE())-1) + 7
		IF @plusdays > 6
			SELECT @plusdays = @plusdays - 7
		SELECT @prevMidnight = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays
        SELECT @nextMidnight = @prevMidnight + 1
		SELECT @simulatedTime = @prevMidnight + @t
        SELECT @ninetyMinutesAgo = DATEADD(mi, -90, @simulatedTime)
        
   --     DECLARE @mt DATETIME = '1/1/11 8:00AM'
   --     IF @kioskmode = 1
	  --      SELECT  @DefaultHour = ISNULL(MeetingTime, @mt),
	  --              @DefaultDay = ISNULL(@thisday, ISNULL(SchedDay, 0))
	  --      FROM    dbo.Organizations
	  --      WHERE   OrganizationId = @orgid
	  --  ELSE
			--SELECT  @DefaultHour = MeetingTime,
	  --              @DefaultDay = ISNULL(SchedDay, 0)
	  --      FROM    dbo.Organizations
	  --      WHERE   OrganizationId = @orgid
	

		--SET @plusdays = @DefaultDay - (DATEPART(dw, GETDATE())-1) + 7
		--IF @plusdays > 6
		--	SELECT @plusdays = @plusdays - 7
			
        DECLARE @defaultPrevMidnight DATETIME = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays

   --     DECLARE @DefaultTime DATETIME = DATEADD(dd, -DATEDIFF(dd, 0, @DefaultHour), @DefaultHour) + @defaultPrevMidnight
   --     IF (@DefaultDay = @thisday)
			--INSERT INTO @ta (hour) VALUES(@DefaultTime)
        
		INSERT INTO @ta 
			SELECT dbo.GetTodaysMeetingHour(@thisday, MeetingTime, SchedDay) 
			FROM dbo.OrgSchedule
			WHERE OrganizationId = @orgid
			AND dbo.GetTodaysMeetingHour(@thisday, MeetingTime, SchedDay) IS NOT NULL
			ORDER BY Id
        
		INSERT INTO @ta 
			SELECT MeetingDate FROM dbo.Meetings
			WHERE MeetingDate NOT IN (SELECT hour FROM @ta)
			AND OrganizationId = @orgid
			AND MeetingDate >= @prevMidnight
			AND MeetingDate < @nextMidnight
			ORDER BY MeetingDate
			
		RETURN

    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastAttend]'
GO
CREATE FUNCTION [dbo].[LastAttend] (@orgid INT, @pid INT)
RETURNS DATETIME
AS
	BEGIN
	DECLARE @dt DATETIME
		SELECT @dt = MAX(m.MeetingDate) FROM dbo.Attend a
		JOIN dbo.Meetings m
		ON a.MeetingId = m.MeetingId
		WHERE a.AttendanceFlag = 1 AND m.OrganizationId = @orgid AND a.PeopleId = @pid
	RETURN @dt
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteQueryBitTags]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteQueryBitTags]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DELETE dbo.TagPerson
	FROM dbo.TagPerson tp
	JOIN dbo.Tag t ON tp.Id = t.Id
	WHERE t.TypeId = 100
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAbsents]'
GO
CREATE FUNCTION [dbo].[RecentAbsents](@orgid INT, @divid INT, @days INT)
RETURNS TABLE 
AS
RETURN 
(
WITH LastAbsents AS
(
  SELECT OrganizationId, PeopleId, MAX(MeetingDate) ld
  FROM Attend
  WHERE AttendanceFlag = 1
  GROUP BY OrganizationId, PeopleId
)
SELECT 
	tt.OrganizationId, 
	o.OrganizationName, 
	o.LeaderName, 
	consecutive,
	tt.PeopleId,
	p.Name2,
	p.HomePhone,
	p.CellPhone,
	p.EmailAddress,
		(SELECT MAX(MeetingDate) 
		 FROM dbo.Attend aa 
		 WHERE aa.PeopleId = tt.PeopleId  
		 AND aa.OrganizationId = tt.OrganizationId 
		 AND aa.AttendanceFlag = 1) 
	lastmeeting,
	m.MeetingId,
	ConsecutiveAbsentsThreshold
FROM
(
SELECT a.OrganizationId, a.PeopleId, count(*) As consecutive
FROM dbo.Attend a
JOIN LastAbsents la 
			ON la.OrganizationId = a.OrganizationId 
			AND la.PeopleId = a.PeopleId
			AND a.MeetingDate > la.ld
group by a.OrganizationId, a.PeopleId
) tt
JOIN dbo.Organizations o ON tt.OrganizationId = o.OrganizationId
JOIN dbo.Meetings m ON tt.OrganizationId = m.OrganizationId 
	AND m.MeetingDate = ( SELECT MAX(a.MeetingDate) FROM dbo.Attend a
						  JOIN dbo.Meetings mm ON mm.MeetingId = a.MeetingId
						  WHERE mm.OrganizationId = tt.OrganizationId
						  AND a.AttendanceFlag = 1 
						  AND mm.MeetingDate > DATEADD(d, -@days, GETDATE()) 
						  AND mm.MeetingDate < GETDATE()
						)
JOIN OrganizationMembers om ON om.PeopleId = tt.PeopleId AND om.OrganizationId = o.OrganizationId
JOIN dbo.People p ON tt.PeopleId = p.PeopleId
JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
JOIN lookup.AttendType at ON at.Id = mt.AttendanceTypeId
WHERE consecutive > ISNULL(ConsecutiveAbsentsThreshold, 2)
AND m.MeetingDate IS NOT NULL
AND at.Id NOT IN (70, 100) --inservice and homebound
AND om.MemberTypeId != 230 --inactive
		AND (tt.OrganizationId = @orgid OR @orgid IS NULL)
		AND (@divid IS NULL 
			OR EXISTS(SELECT NULL 
						FROM dbo.DivOrg 
						WHERE OrgId = tt.OrganizationId AND DivId = @divid))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DaysSinceAttend]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DaysSinceAttend](@pid INT, @oid INT)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @days int

	-- Add the T-SQL statements to compute the return value here
	SELECT @days = MAX(DATEDIFF(D,a.MeetingDate,GETDATE())) FROM dbo.Attend a
	JOIN dbo.Meetings m
	ON a.MeetingId = m.MeetingId
	WHERE a.PeopleId = @pid AND m.OrganizationId = @oid
	

	-- Return the result of the function
	RETURN @days

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[BundleStatusTypes]'
GO
CREATE TABLE [lookup].[BundleStatusTypes]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (5) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BundleStatusTypes] on [lookup].[BundleStatusTypes]'
GO
ALTER TABLE [lookup].[BundleStatusTypes] ADD CONSTRAINT [PK_BundleStatusTypes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[BundleHeaderTypes]'
GO
CREATE TABLE [lookup].[BundleHeaderTypes]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (10) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BundleHeaderTypes] on [lookup].[BundleHeaderTypes]'
GO
ALTER TABLE [lookup].[BundleHeaderTypes] ADD CONSTRAINT [PK_BundleHeaderTypes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contributions2]'
GO

CREATE FUNCTION [dbo].[Contributions2]
(
	@fd DATETIME, 
	@td DATETIME,
	@campusid INT,
	@pledges BIT,
	@nontaxded BIT,
	@includeUnclosed BIT
)
RETURNS TABLE 
AS
RETURN 
(
SELECT 
	p.FamilyId,
	p.PeopleId,
    c.ContributionDate AS Date,
    
    CASE WHEN fa.HeadOfHouseholdId = sp.PeopleId
			AND sp.ContributionOptionsId = 2
			AND p.ContributionOptionsId = 2
		THEN sp.PeopleId 
		ELSE c.PeopleId 
	END AS CreditGiverId,
	
    CASE WHEN fa.HeadOfHouseholdId = sp.PeopleId
		THEN p.PeopleId 
		ELSE sp.PeopleId 
	END AS SpouseId,
	
    CASE WHEN fa.HeadOfHouseholdId = sp.PeopleId
		THEN sp.Name2 
		ELSE p.Name2 
	END AS HeadName,
	
    CASE WHEN fa.HeadOfHouseholdId = sp.PeopleId
		THEN p.Name2 
		ELSE sp.Name2 
	END AS SpouseName,
	
	CASE WHEN ContributionTypeId <> 8
		THEN ContributionAmount
		ELSE 0
	END AS Amount,
	
	CASE WHEN ContributionTypeId = 8
		THEN ContributionAmount
		ELSE 0
	END AS PledgeAmount,
	
    h.BundleHeaderId,
	c.ContributionDesc,
	c.CheckNo,
    c.FundId,
    f.FundName,
    CASE WHEN f.FundPledgeFlag = 1 AND f.FundStatusId = 1
		THEN 1
		ELSE 0
	END AS OpenPledgeFund,
    bht.Description AS BundleType,
    bst.Description AS BundleStatus,
    c.QBSyncID
FROM dbo.Contribution c
	JOIN dbo.ContributionFund f ON c.FundId = f.FundId
	LEFT JOIN dbo.BundleDetail d ON c.ContributionId = d.ContributionId
	LEFT JOIN dbo.BundleHeader h ON d.BundleHeaderId = h.BundleHeaderId
	LEFT JOIN lookup.BundleHeaderTypes bht ON h.BundleHeaderTypeId = bht.Id
	LEFT JOIN lookup.BundleStatusTypes bst ON h.BundleStatusId = bst.Id
	JOIN dbo.People p ON c.PeopleId = p.PeopleId
	JOIN dbo.Families fa ON p.FamilyId = fa.FamilyId
	LEFT JOIN dbo.People sp ON sp.PeopleId = p.SpouseId
WHERE 1 = 1
	AND c.ContributionTypeId NOT IN (6,7) -- no reversed or returned
	AND ((CASE WHEN c.ContributionTypeId = 9 THEN 1 ELSE ISNULL(f.NonTaxDeductible, 0) END) = @nontaxded OR @nontaxded IS NULL)
    AND c.ContributionStatusId = 0 -- recorded
    --AND ((CASE WHEN c.ContributionTypeId = 8 THEN 1 ELSE 0 END) = @pledges OR @pledges IS NULL)
    AND c.ContributionDate >= @fd AND c.ContributionDate < DATEADD(hh, 24, @td)
	AND (h.BundleStatusId = 0 OR @includeUnclosed = 1)
    AND (@campusid = 0 OR p.CampusId = @campusid)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTotalContributionsRange]'
GO

CREATE FUNCTION [dbo].[GetTotalContributionsRange]
(
	@fd DATETIME, 
	@td DATETIME,
	@campusid INT,
	@nontaxded BIT,
	@includeUnclosed BIT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT SUM(tt.Amount) AS Total, SUM(tt.Count) AS [Count], tt.Range
	FROM ( SELECT SUM(Amount) AS Amount, 1 AS [Count],
		   CASE WHEN SUM(Amount) <= 100 THEN 100
			    WHEN SUM(Amount) <= 250 THEN 250
			    WHEN Sum(Amount) <= 500 THEN 500
			    WHEN Sum(Amount) <= 750 THEN 750
			    WHEN Sum(Amount) <= 1000 THEN 1000
			    WHEN Sum(Amount) <= 2000 THEN 2000
			    WHEN Sum(Amount) <= 3000 THEN 3000
			    WHEN Sum(Amount) <= 4000 THEN 4000
			    WHEN Sum(Amount) <= 5000 THEN 5000
			    WHEN Sum(Amount) <= 10000 THEN 10000
			    WHEN Sum(Amount) <= 20000 THEN 20000
			    WHEN Sum(Amount) <= 30000 THEN 30000
			    WHEN Sum(Amount) <= 40000 THEN 40000
			    WHEN Sum(Amount) <= 50000 THEN 50000
			    WHEN Sum(Amount) <= 100000 THEN 100000
			    ELSE 1000000
		   END AS [Range]
		   FROM dbo.Contributions2(@fd, @td, @campusid, NULL, @nontaxded, @includeUnclosed)
		   GROUP BY CreditGiverId
		  ) tt
	GROUP BY tt.Range
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllPhoneHOH]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAllPhoneHOH]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		UPDATE dbo.Families
		SET HomePhoneLU = RIGHT(HomePhone, 7),
			HomePhoneAC = LEFT(RIGHT(REPLICATE('0',10) + HomePhone, 10), 3),
			HeadOfHouseholdId = dbo.HeadOfHouseholdId(FamilyId),
			HeadOfHouseholdSpouseId = dbo.HeadOfHouseHoldSpouseId(FamilyId)
			
		UPDATE dbo.People
		SET CellPhoneLU = RIGHT(CellPhone, 7),
			CellPhoneAC = LEFT(RIGHT(REPLICATE('0',10) + CellPhone, 10), 3)
		
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastMeetings]'
GO
CREATE FUNCTION [dbo].[LastMeetings](@orgid INT, @divid INT, @days INT)
RETURNS TABLE 
AS
RETURN 
(
		SELECT o.OrganizationId, o.OrganizationName, o.LeaderName, m.MeetingDate lastmeeting, m.MeetingId, m.Location
		FROM dbo.Organizations o
		JOIN dbo.Meetings m ON o.OrganizationId = m.OrganizationId 
			AND m.MeetingDate = ( SELECT MAX(a.MeetingDate) FROM dbo.Attend a
								  WHERE a.OrganizationId = o.OrganizationId
								  AND a.EffAttendFlag = 1 
								  AND a.MeetingDate > DATEADD(d, -@days, GETDATE()) 
								  AND a.MeetingDate < GETDATE()
								)
		WHERE (o.OrganizationId = @orgid OR @orgid IS NULL)
		AND (@divid IS NULL OR EXISTS(SELECT NULL FROM dbo.DivOrg WHERE OrgId = o.OrganizationId AND DivId = @divid))
		AND m.MeetingDate IS NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AddAbsents]'
GO

CREATE PROCEDURE [dbo].[AddAbsents](@meetid INT, @userid INT)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @oid INT, @meetdate DATETIME, @attendType INT, @offsiteType INT, @groupflag BIT, @dt DATETIME
	SELECT @oid = OrganizationId, @meetdate = MeetingDate, 
		@attendType = 30, @offsiteType = 80, 
		@groupflag = GroupMeetingFlag, @dt = GETDATE()
	FROM dbo.Meetings m
	WHERE MeetingId = @meetid

	IF @groupflag <> 0
		RETURN

BEGIN TRY
	BEGIN TRANSACTION
	INSERT dbo.Attend 
	(
		MeetingId,
		OrganizationId,
		MeetingDate,
		CreatedBy,
		CreatedDate,
		OtherOrgId,
		PeopleId,
		MemberTypeId,
		AttendanceFlag,
		AttendanceTypeId
	)
	SELECT
		@meetid, 
		@oid, 
		@meetdate, 
		@userid,
		@dt, 
		NULL, 
		o.PeopleId, 
		o.MemberTypeId,
		0,
		@attendType
	FROM dbo.OrganizationMembers o
	WHERE o.OrganizationId = @oid
		AND NOT EXISTS
		(
			SELECT NULL FROM dbo.Attend a 
			WHERE a.PeopleId = o.PeopleId AND a.MeetingId = @meetid
		)

	UPDATE dbo.Attend
	SET 
		AttendanceFlag = NULL, 
		AttendanceTypeId = @offsiteType
	FROM dbo.OrganizationMembers o
	JOIN dbo.Attend a ON o.OrganizationId = a.OrganizationId
	WHERE a.MeetingId = @meetid AND a.PeopleId = o.PeopleId
	AND EXISTS
	(
		SELECT NULL FROM dbo.OrganizationMembers om2
		JOIN dbo.Organizations o2 ON om2.OrganizationId = o2.OrganizationId
		WHERE o2.Offsite = 1 AND om2.PeopleId = o.PeopleId
		AND o2.FirstMeetingDate <= @meetdate AND @meetdate <= DATEADD(dd, 1, o2.LastMeetingDate)
	) 
	COMMIT
END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK
	DECLARE @em nvarchar(4000), @es INT
	SELECT @em=ERROR_MESSAGE(), @es=ERROR_SEVERITY()
	RAISERROR(@em, @es, 1)
END CATCH


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UName2]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UName2] (@pid int)
RETURNS nvarchar(100)
AS
BEGIN
	-- Declare the return variable here
	declare @name nvarchar(100)
	
	SELECT  @name = [LastName]+', '+(case when [Nickname]<>'' then [nickname] else [FirstName] end)
	FROM         dbo.People
	WHERE     PeopleId = @pid

	return @name

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetWeekDayNameOfDate]'
GO

CREATE FUNCTION [dbo].[GetWeekDayNameOfDate]
(
  @Date datetime
)
RETURNS nvarchar(50)
BEGIN

DECLARE @DayName nvarchar(50)

SELECT 
  @DayName =  
  CASE (DATEPART(dw, @Date) + @@DATEFIRST) %   7
    WHEN 1 THEN 'Sun'
    WHEN 2 THEN 'Mon'
    WHEN 3 THEN 'Tue'
    WHEN 4 THEN 'Wed'
    WHEN 5 THEN 'Thu'
    WHEN 6 THEN 'Fri'    
    WHEN 0 THEN 'Sat'
  END

RETURN ISNULL(@DayName, 'Sun')

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetScheduleDesc]'
GO

CREATE FUNCTION [dbo].[GetScheduleDesc]
(
	@meetingtime DATETIME
)
RETURNS nvarchar(20)
AS 
BEGIN
	DECLARE @Ret nvarchar(20)
	DECLARE @MinDate11 DATETIME = CONVERT(DATETIME, 10)
	DECLARE @MinDate10 DATETIME = CONVERT(DATETIME, 9)
	DECLARE @time nvarchar(20) = REPLACE(LTRIM((SUBSTRING(CONVERT(nvarchar(20), ISNULL(@meetingtime, '8:00 AM'), 22), 10, 20))), ':00 ', ' ')
	SELECT @Ret = CASE CONVERT(DATE, ISNULL(@meetingtime, CONVERT(DATETIME, 10)))
					  WHEN @MinDate11 THEN 'None'
					  WHEN @MinDate10 THEN 'Any ' + @time
					  ELSE dbo.GetWeekDayNameOfDate(@meetingtime) + ' ' + @time
				  END
		   
    RETURN @Ret
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[NextAnniversary]'
GO
CREATE FUNCTION [dbo].[NextAnniversary](@pid int)
RETURNS datetime
AS
	BEGIN
	
	
	  DECLARE
		@today DATETIME,
		@date datetime, 
		@m int,
		@d int,
		@y int
		
SELECT @today = CONVERT(datetime, CONVERT(nvarchar, GETDATE(), 112))
select @date = null
select @m = DATEPART(month, WeddingDate), @d = DATEPART(DAY, WeddingDate) 
from dbo.People where @pid = PeopleId
if @m is null
	return @date
select @y = DATEPART(year, @today) 
select @date = dateadd(mm,(@y-1900)* 12 + @m - 1,0) + (@d-1) 
if @date < @today
	select @date = dateadd(yy, 1, @date)
RETURN @date
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[insMeeting] on [dbo].[Meetings]'
GO

CREATE TRIGGER [dbo].[insMeeting] 
   ON  [dbo].[Meetings]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @oid INT,
			@mid INT,
			@mdt DATETIME,
			@mbr INT,
			@atyp INT,
			@grp INT,
			@pid INT,
			@offsite INT,
			@acr INT,
			@NoAutoAbsents BIT,
			@firstdt DATETIME,
			@lastdt DATETIME
	
	SELECT 
		@oid = OrganizationId,
		@mid = MeetingId,
		@mdt = MeetingDate,
		@grp = GroupMeetingFlag,
		@acr = AttendCreditId,
		@NoAutoAbsents = NoAutoAbsents
	FROM INSERTED
	
	IF (@NoAutoAbsents = 1)
		RETURN
	
	SELECT @NoAutoAbsents = NoAutoAbsents, @firstdt = FirstMeetingDate, @lastdt = DATEADD(d, 1, LastMeetingDate)
	FROM dbo.Organizations WHERE OrganizationId = @oid
	IF (@NoAutoAbsents = 1)
		RETURN
		
	DECLARE c CURSOR FOR
	SELECT PeopleId, MemberTypeId, mt.AttendanceTypeId 
	FROM dbo.OrganizationMembers m
	JOIN lookup.MemberType mt ON m.MemberTypeId = mt.Id
	WHERE OrganizationId = @oid
	AND EnrollmentDate < @mdt
	AND @acr IS NOT NULL
	AND m.MemberTypeId <> 230 -- Inactive
	AND m.MemberTypeId <> 311 -- Prospect
	AND ISNULL(m.Pending, 0) = 0
	
	OPEN c;
	FETCH NEXT FROM c INTO @pid, @mbr, @atyp;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		IF (@firstdt IS NULL OR @mdt > @firstdt) AND (@lastdt IS NULL OR @mdt < @lastdt)
			SELECT @offsite = CASE WHEN exists(	
					SELECT NULL FROM dbo.OrganizationMembers om
					JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
					WHERE om.PeopleId = @pid
					AND om.OrganizationId <> @oid
					AND o.Offsite = 1
					AND o.FirstMeetingDate <= @mdt
					AND @mdt <= DATEADD(d, 1, o.LastMeetingDate))
				THEN 1 ELSE 0 END
		ELSE
			SET @offsite = 0
			
		INSERT INTO dbo.Attend
		        ( PeopleId ,
		          MeetingId ,
		          OrganizationId ,
		          MeetingDate ,
		          MemberTypeId ,
		          AttendanceTypeId ,
		          CreatedDate ,
		          AttendanceFlag ,
		          OtherAttends 
		        )
		VALUES  ( @pid , -- PeopleId - int
		          @mid , -- MeetingId - int
		          @oid , -- OrganizationId - int
		          @mdt , -- MeetingDate - datetime
		          @mbr , -- MemberTypeId - int
		          CASE WHEN @grp = 1 THEN 90 WHEN @offsite = 1 THEN 80 ELSE @atyp END , -- AttendanceTypeId - int
		          GETDATE() , -- CreatedDate - datetime
		          0 , -- AttendanceFlag - bit
		          @offsite
		        )
		FETCH NEXT FROM c INTO @pid, @mbr, @atyp;
	END;
	CLOSE c;
	DEALLOCATE c;
	IF @acr IS NOT NULL
	BEGIN
		DECLARE @usebroker bit = (SELECT is_broker_enabled FROM sys.databases WHERE name = DB_NAME())
		IF @usebroker = 1
		BEGIN
			DECLARE @dialog uniqueidentifier
			BEGIN DIALOG CONVERSATION @dialog
			  FROM SERVICE UpdateAttendStrService
			  TO SERVICE 'UpdateAttendStrService'
			  ON CONTRACT UpdateAttendStrContract
			  WITH ENCRYPTION = OFF;
			SEND ON CONVERSATION @dialog MESSAGE TYPE UpdateAttendStrMessage (@oid)
		END
		ELSE
			EXEC dbo.UpdateAllAttendStr @oid
			
		
	END
	
	
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updMeeting] on [dbo].[Meetings]'
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE TRIGGER [dbo].[updMeeting] 
   ON  [dbo].[Meetings]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @mid INT, @grp BIT, @oid INT
	
	IF UPDATE(GroupMeetingFlag)
	BEGIN
		SELECT @mid = MeetingId, @grp = GroupMeetingFlag, @oid = OrganizationId FROM INSERTED
		
		IF (@grp <> 1)
			UPDATE dbo.Attend
			SET AttendanceTypeId = mt.AttendanceTypeId
			FROM dbo.Attend a
			JOIN dbo.OrganizationMembers m ON a.PeopleId = m.PeopleId AND a.OrganizationId = m.OrganizationId
			JOIN lookup.MemberType mt ON m.MemberTypeId = mt.Id
			WHERE a.MeetingId = @mid AND a.AttendanceTypeId = 90 AND a.AttendanceFlag = 0
		ELSE
			UPDATE dbo.Attend
			SET AttendanceTypeId = 90
			WHERE MeetingId = @mid AND AttendanceFlag = 0
			
		DECLARE @dialog UNIQUEIDENTIFIER
		BEGIN DIALOG CONVERSATION @dialog
		  FROM SERVICE UpdateAttendStrService
		  TO SERVICE 'UpdateAttendStrService'
		  ON CONTRACT UpdateAttendStrContract
		  WITH ENCRYPTION = OFF;
		SEND ON CONVERSATION @dialog MESSAGE TYPE UpdateAttendStrMessage (@oid)
	END
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[MemberStatus]'
GO
CREATE TABLE [lookup].[MemberStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MemberStatus_1] on [lookup].[MemberStatus]'
GO
ALTER TABLE [lookup].[MemberStatus] ADD CONSTRAINT [PK_MemberStatus_1] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTotalContributions2]'
GO

CREATE FUNCTION [dbo].[GetTotalContributions2]
(
	@fd DATETIME, 
	@td DATETIME,
	@campusid INT,
	@nontaxded BIT,
	@includeUnclosed BIT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		CreditGiverId, 
		HeadName,
		SpouseName,
		[Count],
		Amount,
		PledgeAmount,
		FundId,
		FundName,
		[OnLine],
		QBSynced,
		o.OrganizationName MainFellowship, 
		ms.Description MemberStatus, 
		bht.Description BundleType 
	FROM
	(
	SELECT 
		CreditGiverId, 
		HeadName, 
		SpouseName, 
		COUNT(*) AS [Count], 
		SUM(Amount) AS Amount, 
		SUM(PledgeAmount) AS PledgeAmount, 
		c2.FundId, 
		FundName,
		BundleHeaderTypeId,
		CASE WHEN BundleHeaderTypeId = 4 THEN 1 ELSE 0 END AS [OnLine],
		CASE WHEN QBSyncID IS NULL THEN 0 ELSE 1 END QBSynced
	FROM dbo.Contributions2(@fd, @td, @campusid, NULL, @nontaxded, @includeUnclosed) c2
	JOIN dbo.BundleHeader h ON c2.BundleHeaderId = h.BundleHeaderId
	GROUP BY CreditGiverId, HeadName, SpouseName, c2.FundId, FundName, 
		CASE WHEN BundleHeaderTypeId = 4 THEN 1 ELSE 0 END,
		CASE WHEN QBSyncID IS NULL THEN 0 ELSE 1 END,
		BundleHeaderTypeId
	) tt 
	JOIN dbo.People p ON p.PeopleId = tt.CreditGiverId
	JOIN lookup.MemberStatus ms ON p.MemberStatusId = ms.Id
	JOIN lookup.BundleHeaderTypes bht ON tt.BundleHeaderTypeId = bht.Id
	LEFT OUTER JOIN dbo.Organizations o ON o.OrganizationId = p.BibleFellowshipClassId
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetScheduleTime]'
GO
CREATE FUNCTION [dbo].[GetScheduleTime]
(
	@day INT,
	@time DATETIME
)
RETURNS DATETIME
AS 
    BEGIN
        DECLARE @Ret DATETIME
        DECLARE @Timeonly DATETIME = DATEADD(dd, -DATEDIFF(dd, 0, @time), @time)
		 
		DECLARE @MinDate DATETIME = CONVERT(DATETIME, 0)
		DECLARE @MinDayOfWeek INT = DATEPART(dw, @MinDate) - 1
		SELECT @day = ISNULL(@day, 0)
		IF (@MinDayOfWeek > @day)
			SELECT @day = @day + 7
		SELECT @Ret = CONVERT(DATETIME, @day - @MinDayOfWeek) + @Timeonly
		
        RETURN @Ret
    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updOrgSchedule] on [dbo].[OrgSchedule]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[updOrgSchedule] 
   ON  dbo.OrgSchedule 
   AFTER UPDATE, INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	IF UPDATE(SchedDay) OR UPDATE(SchedTime)
		UPDATE dbo.OrgSchedule
		SET ScheduleId = dbo.ScheduleId(SchedDay, SchedTime),
		MeetingTime = dbo.GetScheduleTime(SchedDay, SchedTime)
		WHERE Id IN (SELECT Id FROM INSERTED)
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PledgeReport]'
GO
CREATE FUNCTION [dbo].[PledgeReport]
(
	@fd DATETIME, 
	@td DATETIME,
	@campusid INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT tt.FundId, tt.FundName, SUM(Plg) AS Plg, 
		SUM(CASE WHEN tt.Plg > 0 THEN tt.Amt END) AS ToPledge,
		SUM(CASE WHEN tt.Plg = 0 THEN tt.Amt END) AS NotToPledge,
		SUM(tt.Amt) AS ToFund
	FROM
	(
	SELECT SUM(ISNULL(Amount,0)) Amt, SUM(ISNULL(PledgeAmount, 0)) Plg, FundId, FundName
	FROM Contributions2(@fd, @td, @campusid, NULL, NULL, 1)
	GROUP BY CreditGiverId, SpouseId, FundId, FundName, OpenPledgeFund
	HAVING  OpenPledgeFund = 1
	) tt
	GROUP BY FundId, tt.FundName
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PurgeAllPeopleInCampus]'
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PurgeAllPeopleInCampus](@cid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		DECLARE pcur CURSOR FOR 
		SELECT PeopleId FROM dbo.People
		WHERE CampusId = @cid
		
		OPEN pcur
		DECLARE @pid INT, @n INT
		SET @n = 0
		FETCH NEXT FROM pcur INTO @pid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.PurgePerson	@pid
			FETCH NEXT FROM pcur INTO @pid
		END
		CLOSE pcur
		DEALLOCATE pcur
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[VisitNumberSinceDate]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[VisitNumberSinceDate]
(	
	@dt DATETIME,
	@n INT
)
RETURNS TABLE
AS
RETURN
	SELECT * FROM
	(
		SELECT p.PeopleId, p.Name, a.MeetingDate ,RANK() OVER 
		    (PARTITION BY a.PeopleId ORDER BY a.MeetingDate) AS Rank
		FROM dbo.Attend a 
		JOIN People p ON a.PeopleId = p.PeopleId
	) tt
	WHERE tt.Rank = @n
	AND MeetingDate >= @dt
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GivingCurrentPercentOfFormer]'
GO
CREATE FUNCTION [dbo].[GivingCurrentPercentOfFormer]
(
	@dt1 DATETIME, 
	@dt2 DATETIME,
	@comp nvarchar(2),
	@pct FLOAT
)
RETURNS TABLE 
AS
RETURN 
(
SELECT pid, c1amt, c2amt, pct
FROM (
	SELECT pid, c1amt, c2amt, NULLIF(c2amt, 0) * 100 / NULLIF(c1amt, 0) pct
	FROM (	
		SELECT pid, SUM(c1amt) c1amt, SUM(c2amt) c2amt
		FROM (	
			SELECT p1.PeopleId pid, SUM(c1.Amount) c1amt, 0 c2amt
			FROM dbo.People p1
			JOIN dbo.Contributions2(@dt1, @dt2, 0, 0, 0, 0) c1 ON p1.PeopleId = c1.CreditGiverId
			GROUP BY p1.PeopleId
			UNION
			SELECT p2.PeopleId pid, 0 c1amt, SUM(c2.Amount) c2amt
			FROM dbo.People p2
			JOIN dbo.Contributions2(@dt2, GETDATE(), 0, 0, 0, 0) c2 ON p2.PeopleId = c2.CreditGiverId
			GROUP BY p2.PeopleId
		) t1
		GROUP BY t1.pid
	) t2
) t3
WHERE (@comp <> '<=' OR t3.pct <= @pct)
AND (@comp <> '>' OR t3.pct > @pct)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updOrg] on [dbo].[Organizations]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[updOrg] 
   ON  [dbo].[Organizations] 
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

/*
	IF UPDATE(SchedDay) OR UPDATE(SchedTime)
		UPDATE dbo.Organizations
		SET ScheduleId = dbo.ScheduleId(SchedDay, SchedTime),
		MeetingTime = dbo.GetScheduleTime(SchedDay, SchedTime)
		WHERE OrganizationId IN (SELECT OrganizationId FROM INSERTED)*/
	
	IF UPDATE(IsBibleFellowshipOrg)
		OR UPDATE(LeaderMemberTypeId)
	BEGIN
		IF UPDATE(LeaderMemberTypeId)
			UPDATE dbo.Organizations
			SET LeaderId = dbo.OrganizationLeaderId(OrganizationId),
			LeaderName = dbo.OrganizationLeaderName(OrganizationId)
			WHERE OrganizationId IN (SELECT OrganizationId FROM INSERTED)
		UPDATE dbo.People
		SET BibleFellowshipClassId = dbo.BibleFellowshipClassId(p.PeopleId)
		FROM dbo.People p
		JOIN dbo.OrganizationMembers m ON p.PeopleId = m.PeopleId
		JOIN INSERTED o ON m.OrganizationId = o.OrganizationId
	END
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[delOrganizationMember] on [dbo].[OrganizationMembers]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE TRIGGER [dbo].[delOrganizationMember] 
   ON  [dbo].[OrganizationMembers]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE dbo.Organizations
	SET MemberCount = dbo.OrganizationMemberCount(OrganizationId)
	WHERE OrganizationId IN 
	(SELECT OrganizationId FROM DELETED GROUP BY OrganizationId)

	UPDATE dbo.People
	SET Grade = ISNULL(dbo.SchoolGrade(PeopleId), Grade),
	BibleFellowshipClassId = dbo.BibleFellowshipClassId(PeopleId)
	WHERE PeopleId IN (SELECT PeopleId FROM DELETED)

	DECLARE c CURSOR FOR
	SELECT d.OrganizationId, MemberTypeId, o.LeaderMemberTypeId FROM DELETED d
	JOIN dbo.Organizations o ON o.OrganizationId = d.OrganizationId
	OPEN c;
	DECLARE @oid INT, @mt INT, @lmt INT
	FETCH NEXT FROM c INTO @oid, @mt, @lmt;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@mt = @lmt)
		BEGIN
			UPDATE dbo.Organizations
			SET LeaderId = dbo.OrganizationLeaderId(OrganizationId),
			LeaderName = dbo.OrganizationLeaderName(OrganizationId)
			WHERE OrganizationId = @oid
			
			UPDATE dbo.People
			SET BibleFellowshipClassId = dbo.BibleFellowshipClassId(p.PeopleId)
			FROM dbo.People p
			JOIN dbo.OrganizationMembers om ON p.PeopleId = om.PeopleId
			WHERE om.OrganizationId = @oid
		END
		FETCH NEXT FROM c INTO @oid, @mt, @lmt;
	END;
	CLOSE c;
	DEALLOCATE c;

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[insOrganizationMember] on [dbo].[OrganizationMembers]'
GO
CREATE TRIGGER [dbo].[insOrganizationMember] 
   ON  [dbo].[OrganizationMembers]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE dbo.Organizations
	SET MemberCount = dbo.OrganizationMemberCount(OrganizationId)
	WHERE OrganizationId IN 
	(SELECT OrganizationId FROM INSERTED)

	UPDATE dbo.People
	SET Grade = ISNULL(dbo.SchoolGrade(PeopleId), Grade),
	BibleFellowshipClassId = dbo.BibleFellowshipClassId(PeopleId)
	WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)

	--DECLARE c CURSOR FOR
	--SELECT d.OrganizationId, MemberTypeId, o.LeaderMemberTypeId FROM INSERTED d
	--JOIN dbo.Organizations o ON o.OrganizationId = d.OrganizationId
	--OPEN c;
	--DECLARE @oid INT, @mt INT, @lmt INT
	--FETCH NEXT FROM c INTO @oid, @mt, @lmt;
	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	--	IF (@mt = @lmt)
	--		UPDATE dbo.Organizations
	--		SET LeaderId = dbo.OrganizationLeaderId(OrganizationId),
	--		LeaderName = dbo.OrganizationLeaderName(OrganizationId)
	--		WHERE OrganizationId = @oid

	--		UPDATE dbo.People
	--		SET BibleFellowshipClassId = dbo.BibleFellowshipClassId(p.PeopleId)
	--		FROM dbo.People p
	--		JOIN dbo.OrganizationMembers om ON p.PeopleId = om.PeopleId
	--		WHERE om.OrganizationId = @oid
	--	FETCH NEXT FROM c INTO @oid, @mt, @lmt;
	--END;
	--CLOSE c;
	--DEALLOCATE c;
	
	UPDATE dbo.Organizations
	SET LeaderId = dbo.OrganizationLeaderId(o.OrganizationId),
	LeaderName = dbo.OrganizationLeaderName(o.OrganizationId)
	FROM dbo.Organizations o
	JOIN INSERTED m ON o.OrganizationId = m.OrganizationId
	WHERE m.MemberTypeId = o.LeaderMemberTypeId
	
	--UPDATE dbo.People
	--SET BibleFellowshipClassId = dbo.BibleFellowshipClassId(p.PeopleId)
	--FROM dbo.People p
	--JOIN dbo.OrganizationMembers om ON p.PeopleId = om.PeopleId
	--WHERE om.OrganizationId IN (SELECT OrganizationId FROM INSERTED)
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[EntryPoint]'
GO
CREATE TABLE [lookup].[EntryPoint]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EntryPoint] on [lookup].[EntryPoint]'
GO
ALTER TABLE [lookup].[EntryPoint] ADD CONSTRAINT [PK_EntryPoint] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EntryPointId]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[EntryPointId] ( @pid INT )
RETURNS INT 
AS
BEGIN
	DECLARE @ret INT 

	SELECT TOP 1 @ret = e.Id FROM 
	dbo.Attend a 
	JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
	JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
	LEFT OUTER JOIN lookup.EntryPoint e ON o.EntryPointId = e.Id
	WHERE a.PeopleId = @pid
	ORDER BY a.MeetingDate
	
	RETURN @ret
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[insPeople] on [dbo].[People]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[insPeople] 
   ON  [dbo].[People]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE dbo.Families 
	SET HeadOfHouseHoldId = dbo.HeadOfHouseholdId(FamilyId),
		HeadOfHouseHoldSpouseId = dbo.HeadOfHouseHoldSpouseId(FamilyId),
		CoupleFlag = dbo.CoupleFlag(FamilyId)
	WHERE FamilyId IN (SELECT FamilyId FROM INSERTED)
	
	UPDATE dbo.People
	SET SpouseId = dbo.SpouseId(PeopleId)
	WHERE FamilyId IN (SELECT FamilyId FROM INSERTED)
	
		UPDATE dbo.People
	SET ResCodeId = dbo.FindResCode(ZipCode)
	WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)

	UPDATE dbo.People
	SET HomePhone = f.HomePhone
	FROM dbo.People p JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	WHERE p.PeopleId IN (SELECT PeopleId FROM INSERTED)

	UPDATE dbo.People
	SET CellPhoneLU = RIGHT(CellPhone, 7),
	CellPhoneAC = LEFT(RIGHT(REPLICATE('0',10) + CellPhone, 10), 3),
	PrimaryCity = dbo.PrimaryCity(PeopleId),
	PrimaryAddress = dbo.PrimaryAddress(PeopleId),
	PrimaryAddress2 = dbo.PrimaryAddress2(PeopleId),
	PrimaryState = dbo.PrimaryState(PeopleId),
	PrimaryBadAddrFlag = dbo.PrimaryBadAddressFlag(PeopleId),
	PrimaryResCode = dbo.PrimaryResCode(PeopleId),
	PrimaryZip = dbo.PrimaryZip(PeopleId),
	PrimaryCountry = dbo.PrimaryCountry(PeopleId),
	SpouseId = dbo.SpouseId(PeopleId),
	FirstName2 = REPLACE(FirstName + ISNULL(MiddleName, ''), ' ', '')
	WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)
		
	UPDATE dbo.Families
	SET CoupleFlag = dbo.CoupleFlag(FamilyId)
	WHERE FamilyId IN (SELECT FamilyId FROM INSERTED)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[delEnrollmentTransaction] on [dbo].[EnrollmentTransaction]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER dbo.delEnrollmentTransaction
   ON  dbo.EnrollmentTransaction
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @oid INT, @pid INT, @tid INT

	DECLARE det CURSOR FORWARD_ONLY FOR
	SELECT OrganizationId, PeopleId 
	FROM deleted 

	OPEN det
	FETCH NEXT FROM det INTO @oid, @pid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT TOP 1 @tid = TransactionId
		FROM dbo.EnrollmentTransaction
		WHERE OrganizationId = @oid AND PeopleId = @pid
		ORDER BY TransactionId DESC
		
		UPDATE dbo.EnrollmentTransaction
		SET NextTranChangeDate = NULL
		WHERE TransactionId = @tid
		
		FETCH NEXT FROM det INTO @oid, @pid
	END
	CLOSE det
	DEALLOCATE det

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updEnrollmentTransaction] on [dbo].[EnrollmentTransaction]'
GO
CREATE TRIGGER [dbo].[updEnrollmentTransaction]
   ON  [dbo].[EnrollmentTransaction]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Cinfo VARBINARY(128) = Context_Info()  
	IF @Cinfo = 0x55555  
		RETURN  
	
	DECLARE @oid INT, @pid INT, @tid INT, @tdt DATETIME, @thistid INT

	DECLARE @newtdt DATETIME
	
	DECLARE upd2 CURSOR FORWARD_ONLY FOR
	SELECT OrganizationId, PeopleId, TransactionDate, TransactionId
	FROM deleted 

	OPEN upd2
	FETCH NEXT FROM upd2 INTO @oid, @pid, @tdt, @thistid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @newtdt = TransactionDate FROM INSERTED WHERE TransactionId = @thistid
		
		UPDATE dbo.EnrollmentTransaction
		SET NextTranChangeDate = @newtdt
		WHERE OrganizationId = @oid AND PeopleId = @pid AND NextTranChangeDate = @tdt
		
		FETCH NEXT FROM upd2 INTO @oid, @pid, @tdt, @thistid
	END
	CLOSE upd2
	DEALLOCATE upd2

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserRoleList]'
GO
CREATE FUNCTION [dbo].[UserRoleList](@uid int)
RETURNS nvarchar(500)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @roles nvarchar(500)
	select @roles = coalesce(@roles + '|', '|') + r.RoleName FROM dbo.UserRole ur JOIN dbo.Roles r ON ur.RoleId = r.RoleId
	WHERE ur.UserId = @uid

	RETURN @roles + '|'

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SetMainDivision]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SetMainDivision](@orgid INT, @divid INT)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE dbo.DivOrg
	SET id = NULL
	WHERE OrgId = @orgid
	
	UPDATE dbo.DivOrg
	SET id = 1
	WHERE OrgId = @orgid AND DivId = @divid
	
	UPDATE dbo.Organizations
	SET DivisionId = @divid
	WHERE OrganizationId = @orgid
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastMemberTypeInTrans]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[LastMemberTypeInTrans] 
( @oid INT, @pid INT )
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mt INT

	-- Add the T-SQL statements to compute the return value here
SELECT TOP 1 @mt = MemberTypeId FROM dbo.EnrollmentTransaction et
WHERE OrganizationId = @oid AND PeopleId = @pid
AND TransactionTypeId <= 3
ORDER BY TransactionId DESC
	-- Return the result of the function
	RETURN @mt

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTotalContributions]'
GO
CREATE FUNCTION [dbo].[GetTotalContributions](@startdt DATETIME, @enddt DATETIME)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		hh.PeopleId, 
		hh.Name, 
		hh.SpouseName, 
		f.FundId,
		f.FundName AS FundDescription,
		(SELECT COUNT(*) FROM dbo.Contribution cc
				JOIN dbo.People p ON cc.PeopleId = p.PeopleId
				WHERE cc.FundId = f.Fundid 
				AND ( (cc.PeopleId = hh.PeopleId)
				 OR (cc.PeopleId IN (hh.SpouseId, hh.PeopleId) AND hh.ContributionOptionsId = 2 AND hh.SpouseContributionOptionsId = 2)
					)
				AND cc.ContributionTypeId NOT IN (6,7)
				AND cc.ContributionStatusId = 0
				AND cc.ContributionDate >= @startdt 
				AND cc.ContributionDate < DATEADD(hh, 24, @enddt)
				) Cnt,
		(SELECT SUM(cc.ContributionAmount) FROM dbo.Contribution cc
				JOIN dbo.People p ON cc.PeopleId = p.PeopleId
				WHERE cc.FundId = f.Fundid 
				AND ( (cc.PeopleId = hh.PeopleId)
				 OR (cc.PeopleId IN (hh.SpouseId, hh.PeopleId) AND hh.ContributionOptionsId = 2 AND hh.SpouseContributionOptionsId = 2)
					)
				AND cc.ContributionTypeId NOT IN (6,7,8)
				AND cc.ContributionStatusId = 0
				AND cc.ContributionDate >= @startdt 
				AND cc.ContributionDate < DATEADD(hh, 24, @enddt)
				) Amt,
		(SELECT SUM(cc.ContributionAmount) FROM dbo.Contribution cc
				JOIN dbo.People p ON cc.PeopleId = p.PeopleId
				WHERE cc.FundId = f.Fundid 
				AND ( (cc.PeopleId = hh.PeopleId)
				 OR (cc.PeopleId IN (hh.SpouseId, hh.PeopleId) AND hh.ContributionOptionsId = 2 AND hh.SpouseContributionOptionsId = 2)
					)
				AND cc.ContributionTypeId = 8
				AND cc.ContributionStatusId = 0
				AND cc.ContributionDate >= @startdt 
				AND cc.ContributionDate < DATEADD(hh, 24, @enddt)
				) Plg
	FROM Contributors(@startdt, @enddt, 0, 0, 0, 1) hh
	JOIN dbo.Families ff ON hh.FamilyId = ff.FamilyId
	JOIN dbo.Contribution c ON hh.PeopleId = c.PeopleId OR hh.SpouseId = c.PeopleId
	JOIN dbo.ContributionFund f ON c.FundId = f.FundId
	WHERE c.ContributionDate >= @startdt 
		AND c.ContributionDate < DATEADD(hh, 24, @enddt)
		AND ( (hh.PeopleId = ff.HeadOfHouseholdId AND hh.ContributionOptionsId = 2 AND hh.SpouseContributionOptionsId = 2)
				OR (hh.ContributionOptionsId <> 2)
			)
	GROUP BY hh.PeopleId, hh.spouseId, hh.Name, hh.SpouseName, f.FundId, f.FundName, hh.ContributionOptionsId, hh.SpouseContributionOptionsId
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MemberTypeAtLastDrop]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[MemberTypeAtLastDrop]
( @oid INT, @pid INT )
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mt INT

	-- Add the T-SQL statements to compute the return value here
SELECT TOP 1 @mt = MemberTypeId FROM dbo.EnrollmentTransaction et
WHERE OrganizationId = @oid AND PeopleId = @pid
AND TransactionTypeId = 5
ORDER BY TransactionId DESC
	-- Return the result of the function
	RETURN @mt

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FirstMeetingDateLastLear]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[FirstMeetingDateLastLear] ( @pid INT )
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @dt DATETIME

	-- Add the T-SQL statements to compute the return value here
SELECT TOP 1 @dt = MeetingDate FROM dbo.Attend
WHERE PeopleId = @pid
AND AttendanceFlag = 1
AND MeetingDate >= DATEADD(yy, -1, GETDATE())
ORDER BY MeetingDate
	-- Return the result of the function
	RETURN CONVERT(nvarchar, @dt, 111)

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastIdInTrans]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[LastIdInTrans] 
( @oid INT, @pid INT )
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mt INT

	-- Add the T-SQL statements to compute the return value here
SELECT TOP 1 @mt = TransactionId FROM dbo.EnrollmentTransaction et
WHERE OrganizationId = @oid AND PeopleId = @pid
AND TransactionTypeId <= 3
ORDER BY TransactionId DESC
	-- Return the result of the function
	RETURN @mt

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MemberTypeAsOf]'
GO
CREATE FUNCTION [dbo].[MemberTypeAsOf]
( @oid INT, @pid INT, @dt DATETIME )
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mt INT

	-- Add the T-SQL statements to compute the return value here
SELECT TOP 1 @mt = MemberTypeId FROM dbo.EnrollmentTransaction et
WHERE OrganizationId = @oid AND PeopleId = @pid
AND TransactionDate <= @dt 
AND (NextTranChangeDate >= @dt OR NextTranChangeDate IS NULL)
AND TransactionTypeId <= 3
ORDER BY TransactionDate DESC
	RETURN @mt

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PledgeCount]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PledgeCount](@pid INT, @days INT, @fundid INT)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @cnt int

	-- Add the T-SQL statements to compute the return value here
	DECLARE @mindt DATETIME = DATEADD(D, -@days, GETDATE())
	DECLARE @option INT
	DECLARE @spouse INT
	SELECT	@option = ISNULL(ContributionOptionsId,1), 
			@spouse = SpouseId
	FROM dbo.People 
	WHERE PeopleId = @pid
	
	
	SELECT @cnt = COUNT(*)
	FROM dbo.Contribution c
	WHERE 
	c.ContributionDate >= @mindt
	AND (c.FundId = @fundid OR @fundid IS NULL)
	AND c.ContributionStatusId = 0 --Recorded
	AND c.ContributionTypeId = 8
	AND ((@option <> 2 AND c.PeopleId = @pid)
		 OR (@option = 2 AND c.PeopleId IN (@pid, @spouse)))

	-- Return the result of the function
	RETURN @cnt

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PledgeAmount]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PledgeAmount](@pid INT, @days INT, @fundid INT)
RETURNS MONEY
AS
BEGIN
	-- Declare the return variable here
	DECLARE @amt MONEY

	-- Add the T-SQL statements to compute the return value here
	DECLARE @mindt DATETIME = DATEADD(D, -@days, GETDATE())
	DECLARE @option INT
	DECLARE @spouse INT
	SELECT	@option = ISNULL(ContributionOptionsId,1), 
			@spouse = SpouseId
	FROM dbo.People 
	WHERE PeopleId = @pid
	
	SELECT @amt = SUM(c.ContributionAmount)
	FROM dbo.Contribution c
	WHERE 
	c.ContributionDate >= @mindt
	AND (c.FundId = @fundid OR @fundid IS NULL)
	AND c.ContributionTypeId = 8
	AND c.ContributionStatusId = 0 --Recorded
	AND ((@option <> 2 AND c.PeopleId = @pid)
		 OR (@option = 2 AND c.PeopleId IN (@pid, @spouse)))

	-- Return the result of the function
	RETURN @amt

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopPledgers]'
GO
CREATE PROCEDURE [dbo].[TopPledgers](@top INT, @sdate DATETIME, @edate DATETIME)
AS
BEGIN

	SELECT TOP (@top) c.PeopleId, Name, SUM(ContributionAmount) FROM dbo.People p
	JOIN dbo.Contribution c ON p.PeopleId = c.PeopleId
	WHERE c.ContributionDate >= @sdate
	AND c.ContributionDate <= @edate
	AND c.ContributionTypeId = 8
	GROUP BY c.PeopleId, Name
	ORDER BY SUM(ContributionAmount) DESC

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MostRecentItems]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[MostRecentItems] (@uid INT)
RETURNS @t TABLE (Id int, Name nvarchar(150),[Type] nvarchar(3))
AS
BEGIN
	DECLARE @dt7 DateTime = DATEADD(DAY, -7, GETDATE())
	DECLARE @pid INT
	SELECT @pid = PeopleId FROM Users WHERE UserId = @uid
	INSERT INTO @t
	SELECT TOP 5 OrgId [Id], OrganizationName [Name], 'org' [Type]
	FROM (SELECT
	         ROW_NUMBER() OVER ( PARTITION BY OrgId ORDER BY ActivityDate DESC ) AS [RowNumber],
	         OrgId,
	         OrganizationName,
	         ActivityDate
	      FROM dbo.ActivityLog a
	      JOIN dbo.Organizations o ON a.OrgId = o.OrganizationId
	      WHERE OrgId IS NOT NULL 
	      AND UserId = @uid 
	      ) t
	WHERE RowNumber = 1
	ORDER BY t.ActivityDate DESC

	INSERT INTO @t
	SELECT TOP 5 PeopleId [Id], Name, 'per' [Type]
	FROM (SELECT
	         ROW_NUMBER() OVER ( PARTITION BY a.PeopleId ORDER BY ActivityDate DESC ) AS [RowNumber],
	         a.PeopleId,
	         Name,
	         ActivityDate
	      FROM dbo.ActivityLog a
	      JOIN dbo.People p ON a.PeopleId = p.PeopleId
	      WHERE a.PeopleId IS NOT NULL 
	      AND a.PeopleId <> @pid
	      AND UserId = @uid 
	      ) t
	WHERE RowNumber = 1
	ORDER BY t.ActivityDate DESC
	
	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[delDivOrg] on [dbo].[DivOrg]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[delDivOrg]
   ON  [dbo].[DivOrg]
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	UPDATE dbo.Organizations
	SET DivisionId = NULL
	FROM dbo.Organizations o
	JOIN DELETED i ON i.OrgId = o.OrganizationId
	WHERE o.DivisionId = i.DivId
	
	UPDATE dbo.Organizations
	SET DivisionId = (SELECT TOP 1 DivId FROM dbo.DivOrg WHERE OrgId = o.OrganizationId)
	FROM dbo.Organizations o
	WHERE o.OrganizationId IN (SELECT OrgId FROM DELETED)
	AND o.DivisionId IS NULL
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MemberStatusDescription]'
GO
CREATE FUNCTION [dbo].[MemberStatusDescription](@pid int)
RETURNS nvarchar(50)
AS
	BEGIN
	declare @desc nvarchar(50)
	select @desc = m.description from lookup.memberstatus m
	join dbo.People p on p.MemberStatusId = m.id
	where p.PeopleId = @pid
	return @desc
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserName]'
GO
CREATE FUNCTION [dbo].[UserName] (@pid int)
RETURNS nvarchar(100)
AS
	BEGIN
	declare @name nvarchar(100)
	
SELECT  @name = [LastName]+', '+(case when [Nickname]<>'' then [nickname] else [FirstName] end)
FROM         dbo.People
WHERE     PeopleId = @pid

	return @name
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetAttendType]'
GO
CREATE FUNCTION [dbo].[GetAttendType]
    (
      @attended BIT,
      @membertypeid INT,
      @group BIT
    )
RETURNS INT
AS 
BEGIN
	IF @group = 1
		RETURN 90 -- group
	IF @attended <> 1
		RETURN NULL
	DECLARE @at INT
	SELECT @at = AttendanceTypeId 
	FROM lookup.MemberType
	WHERE Id = @membertypeid
	RETURN @at
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updUser] on [dbo].[Users]'
GO
CREATE TRIGGER [dbo].[updUser] 
   ON  [dbo].[Users]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF UPDATE(PeopleId)
	BEGIN
		UPDATE Users
		SET Name = dbo.UName(PeopleId),
		Name2 = dbo.UName2(PeopleId)
		WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)
	END
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CreateOtherAttend]'
GO
CREATE PROCEDURE [dbo].[CreateOtherAttend]
    (
      @mid INT,
      @oid INT,
      @pid INT
    )
AS
BEGIN
	DECLARE @mdt DATETIME
	
	SELECT @mdt = MeetingDate 
	FROM dbo.Meetings
	WHERE MeetingId = @mid
	
	DECLARE @notweekly BIT
	SELECT @notweekly = NotWeekly
	FROM dbo.Organizations
	WHERE OrganizationId = @oid
	
	DECLARE @omid INT
	SELECT TOP 1 @omid = MeetingId
	FROM dbo.Meetings
	WHERE OrganizationId = @oid
	AND MeetingDate = @mdt
	
	IF @omid IS NULL AND @notweekly = 1
		RETURN NULL
	
	IF (@omid IS NULL)
	BEGIN
		DECLARE @acrid INT
		SELECT @acrid = AttendCreditId
		FROM dbo.OrgSchedule
		WHERE OrganizationId = @oid
		AND CAST(SchedTime AS TIME) = CAST(@mdt AS TIME)
		AND SchedDay = (DATEPART(dw, @mdt) - 1)
		INSERT dbo.Meetings
		        ( CreatedBy, CreatedDate , OrganizationId, MeetingDate, GroupMeetingFlag, AttendCreditId )
		VALUES  ( 0, GETDATE(), @oid, @mdt, 0, @acrid )
		SELECT @omid = SCOPE_IDENTITY()
	END
	
	DECLARE @oaid INT
	SELECT @oaid = AttendId
	FROM dbo.Attend
	WHERE PeopleId = @pid
	AND MeetingId = @omid
	
	IF @oaid IS NULL
	BEGIN
		DECLARE @omt INT
		SELECT @omt = MemberTypeId
		FROM dbo.OrganizationMembers
		WHERE OrganizationId = @oid
		AND PeopleId = @pid
	
		INSERT dbo.Attend
		        ( MeetingId, PeopleId, OrganizationId, MeetingDate, CreatedDate, MemberTypeId )
		VALUES  ( @omid, @pid, @oid, @mdt, GETDATE(), @omt )
		SELECT @oaid = SCOPE_IDENTITY()
	END
	RETURN @oaid
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateSchoolGrade]'
GO
CREATE PROCEDURE [dbo].[UpdateSchoolGrade] @pid INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-----------------------------------------------------------------
	
	UPDATE dbo.People SET Grade = dbo.SchoolGrade(@pid) WHERE PeopleId = @pid

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[AttendCredit]'
GO
CREATE TABLE [lookup].[AttendCredit]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (10) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_AttendCredit] on [lookup].[AttendCredit]'
GO
ALTER TABLE [lookup].[AttendCredit] ADD CONSTRAINT [PK_AttendCredit] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecordAttend]'
GO
CREATE PROCEDURE [dbo].[RecordAttend]
( @MeetingId INT, @PeopleId INT, @Present BIT)
AS
BEGIN
	DECLARE @ret nvarchar(100)

	--BEGIN TRANSACTION
	
	DECLARE @orgid INT
			,@meetingdate DATETIME
			,@meetdt DATE
			,@dt DATETIME
			,@regularhour BIT
			,@membertypeid INT
			,@allowoverlap BIT
			,@bfcattend INT
			,@bfcid INT
			,@name nvarchar(50)
			,@bfclassid INT
			,@ResetNewVisitorDays INT

	SELECT
		@orgid = o.OrganizationId,
		@meetingdate = m.MeetingDate,
		@meetdt = CONVERT(DATE, m.MeetingDate),
		@allowoverlap = o.AllowAttendOverlap,
		@membertypeid = dbo.MemberTypeAsOf(o.OrganizationId, @PeopleId, m.MeetingDate)
	FROM dbo.Meetings m
	JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
	WHERE m.MeetingId = @MeetingId
	
	SELECT @ResetNewVisitorDays = ISNULL((SELECT Setting FROM dbo.Setting WHERE Id = 'ResetNewVisitorDays'), 180)
	SELECT @dt = DATEADD(DAY, -@ResetNewVisitorDays, @meetdt)
	
	SELECT @regularhour = CASE WHEN EXISTS(
		SELECT null
			FROM dbo.Meetings m
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE m.MeetingId = @MeetingId
				AND EXISTS(SELECT NULL FROM dbo.OrgSchedule
							WHERE OrganizationId = o.OrganizationId
							AND SchedDay IN (DATEPART(weekday, m.MeetingDate)-1, 10)
							AND CONVERT(TIME, m.MeetingDate) = CONVERT(TIME, MeetingTime)
							AND (o.FirstMeetingDate IS NULL OR o.FirstMeetingDate < @meetingdate) 
							AND (o.LastMeetingDate IS NULL OR o.LastMeetingDate > @meetingdate)
							)
		)
		THEN 1 ELSE 0 END

	IF @dt IS NULL
		SELECT @dt = DATEADD(DAY, 3 * -7, @meetdt)

	SELECT @name = p.[Name], @bfclassid = BibleFellowshipClassId
	FROM dbo.People p
	WHERE PeopleId = @PeopleId
	
	--Check Attended Elsewhere
	IF EXISTS(SELECT NULL
			FROM Attend ae
			JOIN dbo.Meetings m ON ae.MeetingId = m.MeetingId
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE ae.PeopleId = @PeopleId
			AND ae.AttendanceFlag = 1
			AND ae.MeetingDate = @meetingdate
			AND ae.OrganizationId <> @orgid
			AND o.AllowAttendOverlap <> 1
			AND @allowoverlap <> 1)
	BEGIN
		SELECT @ret = @name + '(' + CONVERT(nvarchar(15), @PeopleId) + ') already attended elsewhere'
		--ROLLBACK TRANSACTION
		SELECT @ret AS ret
		RETURN
	END
	
	-- BFC class membership at same hour
	SELECT TOP 1 @bfcid = om.OrganizationId 
	FROM dbo.OrganizationMembers om
	JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	WHERE om.PeopleId = @PeopleId 
	AND om.OrganizationId <> @orgid
	AND om.MemberTypeId <> 230
	AND om.MemberTypeId <> 311
	AND ISNULL(om.Pending, 0) = 0
	AND @regularhour = 1
	AND EXISTS(SELECT NULL FROM dbo.OrgSchedule os
				JOIN lookup.AttendCredit at ON os.AttendCreditId = at.Id
				WHERE os.OrganizationId = o.OrganizationId
				AND os.SchedDay IN (DATEPART(weekday, @meetingdate)-1, 10)
				AND CONVERT(TIME, @meetingdate) = CONVERT(TIME, os.MeetingTime)
				AND at.Code = 'E' -- AttendCredit = Every Meeting vs Once a Week
				)

	-- BFC Attendance at same time
	SELECT TOP 1 @bfcattend = a.AttendId FROM dbo.Attend a
	JOIN dbo.OrganizationMembers om ON a.OrganizationId = om.OrganizationId AND a.PeopleId = om.PeopleId
	JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	WHERE a.MeetingDate = @meetingdate
	AND @regularhour = 1
	AND EXISTS(SELECT NULL FROM dbo.OrgSchedule
				WHERE OrganizationId = o.OrganizationId
				AND SchedDay IN (DATEPART(weekday, @meetingdate)-1, 10)
				AND CONVERT(TIME, @meetingdate) = CONVERT(TIME, MeetingTime))
	AND om.OrganizationId <> @orgid
	AND om.OrganizationId = @bfcid
	AND a.PeopleId = @PeopleId

----------------------------------

	DECLARE @AttendId INT 
	SELECT @AttendId = AttendId 
	FROM dbo.Attend 
	WHERE MeetingId = @MeetingId AND PeopleId = @PeopleId
	
	IF @AttendId IS NULL
	BEGIN
		INSERT dbo.Attend
		        ( PeopleId ,
		          MeetingId ,
		          OrganizationId ,
		          MeetingDate ,
		          AttendanceFlag ,
		          CreatedDate,
		          MemberTypeId
		        )
		VALUES  ( @PeopleId,
		          @MeetingId,
		          @orgid,
		          @meetingdate,
		          @Present,
		          GETDATE(),
		          220
		        )
		SELECT @AttendId = SCOPE_IDENTITY()
	END
	ELSE
		UPDATE dbo.Attend
		SET AttendanceFlag = @Present, SeqNo = NULL
		WHERE AttendId = @AttendId
	
	DECLARE @OtherMeetings TABLE ( id INT )
	
	DECLARE @GroupMeetingFlag BIT
	SELECT @GroupMeetingFlag = GroupMeetingFlag 
	FROM dbo.Meetings 
	WHERE MeetingId = @MeetingId
	
	DECLARE @VIPAttendance TABLE ( id INT )
	
	INSERT INTO @VIPAttendance ( id ) SELECT AttendId
				FROM Attend v
				JOIN dbo.OrganizationMembers om ON v.OrganizationId = om.OrganizationId AND v.PeopleId = om.PeopleId
				WHERE v.PeopleId = @PeopleId
				AND v.MeetingDate = @meetingdate
				AND v.AttendanceFlag = 1
				AND v.OrganizationId <> @orgid
				AND om.MemberTypeId = 700 	-- vip
				AND @orgid = @bfclassid
	
	IF @GroupMeetingFlag = 1 AND @membertypeid IS NOT NULL	
	BEGIN
		IF EXISTS(SELECT NULL FROM @VIPAttendance)
			UPDATE dbo.Attend
			SET AttendanceTypeId = 20, -- volunteer
				MemberTypeId = @membertypeid
			WHERE AttendId = @AttendId
		ELSE
			UPDATE dbo.Attend			
			SET AttendanceTypeId = 90, -- group
				MemberTypeId = @membertypeid
			WHERE AttendId = @AttendId
	END
	ELSE IF @membertypeid IS NOT NULL and @membertypeid <> 311 -- is a member of this class and not a prospect
	BEGIN
		UPDATE dbo.Attend
		SET MemberTypeId = @membertypeid,
			AttendanceTypeId = dbo.GetAttendType(@Present, @membertypeid, @GroupMeetingFlag),
			BFCAttendance = (CASE WHEN @bfclassid = @orgid THEN 1 ELSE 0 END)
		WHERE AttendId = @AttendId
		
		IF @bfcid IS NOT NULL AND (@Present = 1 OR @bfcattend IS NOT NULL)
		BEGIN
            /* At this point I am recording attendance for a vip class                     
             * or for a class where I am doing InService (long term) teaching
             * And now I am looking at the BFClass where I am a regular member or an InService Member
             * I don't need to be here if I am reversing my attendance and there is no BFCAttendance to fix
             */
			IF @bfcattend IS NULL
				EXECUTE @bfcattend = dbo.CreateOtherAttend @MeetingId, @bfcid, @PeopleId
				
			UPDATE dbo.Attend
			SET OtherAttends = @Present
			WHERE AttendId = @bfcattend
			
			UPDATE dbo.Attend
			SET OtherAttends = ISNULL((SELECT AttendanceFlag FROM dbo.Attend WHERE AttendId = @bfcattend), 0)
			WHERE AttendId = @AttendId
			
			DECLARE @BFCOtherAttends BIT
			IF EXISTS(SELECT NULL FROM dbo.Attend WHERE AttendId = @bfcattend AND OtherAttends > 0)
				SET @BFCOtherAttends = 1
							
			IF @membertypeid = 700 -- VIP
				IF @BFCOtherAttends = 1
					UPDATE dbo.Attend
					SET AttendanceTypeId = 20 -- Volunteer
					WHERE AttendId = @bfcattend
				ELSE
					UPDATE dbo.Attend
					SET AttendanceTypeId = 30 -- Member
					WHERE AttendId = @bfcattend
			ELSE IF @membertypeid = 500 -- InService Member
				IF @BFCOtherAttends = 1
					UPDATE dbo.Attend
					SET AttendanceTypeId = 70 -- InService
					WHERE AttendId = @bfcattend
				ELSE					
					UPDATE dbo.Attend
					SET AttendanceTypeId = 30 -- Member
					WHERE AttendId = @bfcattend
					
			INSERT @OtherMeetings ( id ) VALUES  ( @bfcattend )
		END
		ELSE IF EXISTS(SELECT NULL FROM @VIPAttendance) -- need to indicate BFCAttendance or not
		BEGIN
		/* At this point I am recording attendance for a BFClass
         * And now I am looking at the one or more VIP classes where I a sometimes volunteer
         */
			UPDATE dbo.Attend
			SET OtherAttends = @Present
			WHERE AttendId IN (SELECT Id FROM @VIPAttendance)
			
			UPDATE dbo.Attend
			SET AttendanceTypeId = 20,-- Volunteer
				OtherAttends = 1
			WHERE AttendId = @AttendId
			
			INSERT @OtherMeetings (id) SELECT Id FROM @VIPAttendance
		END
	END
	ELSE -- not a member of this class
	BEGIN
		IF NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers
				WHERE OrganizationId = @bfcid
				AND PeopleId = @PeopleId)
		BEGIN
			IF EXISTS(SELECT NULL FROM Attend -- RecentVisitor?
					WHERE PeopleId = @PeopleId
					AND AttendanceFlag = 1
					AND MeetingDate >= @dt
					AND MeetingDate <= @meetdt
					AND OrganizationId = @orgid
					AND AttendanceTypeId IN (50, 60)) -- new and recent
				UPDATE dbo.Attend
				SET AttendanceTypeId = 50, -- RecentVisitor
					MemberTypeId = isnull(@membertypeid, 310) -- prospect or Visitor
				WHERE AttendId = @AttendId
			ELSE
				UPDATE dbo.Attend
				SET AttendanceTypeId = 60, -- NewVisitor
					MemberTypeId = isnull(@membertypeid, 310) -- prospect or Visitor
				WHERE AttendId = @AttendId
		END
		ELSE -- member of another class (visiting member)
		BEGIN
			IF @Present = 1
				UPDATE dbo.Attend
				SET AttendanceTypeId = 40, -- Visiting Member
					MemberTypeId = 310 -- Visiting Member
				WHERE AttendId = @AttendId
				
			IF @bfcattend IS NULL
				EXECUTE @bfcattend = dbo.CreateOtherAttend @MeetingId, @bfcid, @PeopleId
				
			UPDATE dbo.Attend
			SET OtherAttends = @Present
			WHERE AttendId = @bfcattend
			
			IF @Present = 1
				UPDATE dbo.Attend
				SET AttendanceTypeId = 110 -- Other Class
				WHERE AttendId = @bfcattend
			ELSE
			BEGIN
				DECLARE @mt INT, @bfcoid INT, @group BIT
				SELECT @bfcoid = om.OrganizationId, @mt = om.MemberTypeId, @group = m.GroupMeetingFlag
				FROM dbo.Attend a 
				JOIN dbo.OrganizationMembers om ON a.PeopleId = om.PeopleId AND a.OrganizationId = om.OrganizationId
				JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
				WHERE a.AttendId = @bfcattend
				
				UPDATE dbo.Attend
				SET AttendanceTypeId = dbo.GetAttendType(AttendanceFlag, @mt, @group)
				WHERE AttendId = @bfcattend
			END	
			INSERT @OtherMeetings (id) VALUES(@bfcattend)
		END
	END
	EXEC dbo.UpdateAttendStr @orgid, @PeopleId
	EXEC dbo.UpdateMeetingCounters @MeetingId
	EXEC dbo.AttendUpdateN @PeopleId
	
	DECLARE othermeetingscursor CURSOR FOR SELECT DISTINCT id FROM @OtherMeetings
	OPEN othermeetingscursor
	DECLARE @oaid INT
	FETCH NEXT FROM othermeetingscursor INTO @oaid
	WHILE @@Fetch_Status=0
	BEGIN
		DECLARE @oid INT, @mid INT
		SELECT @oid = OrganizationId, @mid = MeetingId FROM dbo.Attend WHERE AttendId = @oaid
		EXEC dbo.UpdateAttendStr @oid, @PeopleId
		EXEC dbo.UpdateMeetingCounters @mid
		FETCH NEXT FROM othermeetingscursor INTO @oaid
	END
	CLOSE othermeetingscursor
	DEALLOCATE othermeetingscursor
	
	--COMMIT TRANSACTION
	SELECT 'ok' AS ret
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[delPeople] on [dbo].[People]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[delPeople] 
   ON  [dbo].[People]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @fid INT
	DECLARE c CURSOR FOR
	SELECT FamilyId FROM deleted GROUP BY FamilyId
	OPEN c;
	FETCH NEXT FROM c INTO @fid;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE dbo.Families SET HeadOfHouseHoldId = dbo.HeadOfHouseholdId(FamilyId),
			HeadOfHouseHoldSpouseId = dbo.HeadOfHouseHoldSpouseId(FamilyId),
			CoupleFlag = dbo.CoupleFlag(FamilyId)
		WHERE FamilyId = @fid

		UPDATE dbo.People
		SET SpouseId = dbo.SpouseId(PeopleId)
		WHERE FamilyId = @fid

		DECLARE @n INT
		SELECT @n = COUNT(*) FROM dbo.People WHERE FamilyId = @fid
		IF @n = 0
		BEGIN
			DELETE dbo.RelatedFamilies WHERE @fid IN(FamilyId, RelatedFamilyId)
			DELETE dbo.FamilyCheckinLock WHERE FamilyId = @fid
			DELETE dbo.Families WHERE FamilyId = @fid
		END
		FETCH NEXT FROM c INTO @fid;
	END;
	CLOSE c;
	DEALLOCATE c;

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAttendStrProc]'
GO
CREATE PROCEDURE [dbo].[UpdateAttendStrProc]
AS
BEGIN
	DECLARE @orgid INT, @dlgId UNIQUEIDENTIFIER	

	WHILE(1=1)
	BEGIN
		RECEIVE top(1) @orgid = CONVERT(INT, message_body), @dlgId = conversation_handle FROM dbo.UpdateAttendStrQueue
		IF @@ROWCOUNT = 0		
			BREAK;
		IF @orgid IS NOT NULL
			EXEC dbo.UpdateAllAttendStr @orgid
		END CONVERSATION @dlgId WITH CLEANUP
	END	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateResCodes]'
GO
CREATE PROCEDURE [dbo].[UpdateResCodes] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-----------------------------------------------------------------
	
UPDATE dbo.People
SET ResCodeId = dbo.FindResCode(ZipCode)

UPDATE dbo.Families
SET ResCodeId = dbo.FindResCode(ZipCode)


END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[updPeople] on [dbo].[People]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[updPeople] 
   ON  [dbo].[People]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF (
		UPDATE(PositionInFamilyId) 
		OR UPDATE(GenderId) 
		OR UPDATE(DeceasedDate) 
		OR UPDATE(FirstName)
		OR UPDATE(MaritalStatusId)
		OR UPDATE(FamilyId)
    )
	BEGIN
		UPDATE dbo.Families 
		SET HeadOfHouseHoldId = dbo.HeadOfHouseholdId(FamilyId),
			HeadOfHouseHoldSpouseId = dbo.HeadOfHouseHoldSpouseId(FamilyId),
			CoupleFlag = dbo.CoupleFlag(FamilyId)
		WHERE FamilyId IN (SELECT FamilyId FROM INSERTED) 
		OR FamilyId IN (SELECT FamilyId FROM DELETED)
		
		UPDATE dbo.People
		SET SpouseId = dbo.SpouseId(PeopleId)
		WHERE FamilyId IN (SELECT FamilyId FROM INSERTED)
		OR FamilyId IN (SELECT FamilyId FROM DELETED)

		IF (UPDATE(FamilyId))
		BEGIN
			DECLARE c CURSOR FOR
			SELECT FamilyId FROM deleted GROUP BY FamilyId
			OPEN c;
			DECLARE @fid INT
			FETCH NEXT FROM c INTO @fid;
			WHILE @@FETCH_STATUS = 0
			BEGIN
				DECLARE @n INT
				SELECT @n = COUNT(*) FROM dbo.People WHERE FamilyId = @fid
				IF @n = 0
				BEGIN
					DELETE dbo.RelatedFamilies WHERE @fid IN(FamilyId, RelatedFamilyId)
					DELETE dbo.FamilyCheckinLock WHERE @fid = FamilyId
					DELETE dbo.FamilyExtra WHERE @fid = FamilyId
					DELETE dbo.Families WHERE FamilyId = @fid
				END
				FETCH NEXT FROM c INTO @fid;
			END;
			CLOSE c;
			DEALLOCATE c;

			UPDATE dbo.People
			SET HomePhone = f.HomePhone
			FROM dbo.People p JOIN dbo.Families f ON p.FamilyId = f.FamilyId
			WHERE p.PeopleId IN (SELECT PeopleId FROM INSERTED)
		END

	END
    IF UPDATE(CellPhone)
	BEGIN
		UPDATE dbo.People
		SET CellPhoneLU = RIGHT(CellPhone, 7),
			CellPhoneAC = LEFT(RIGHT(REPLICATE('0',10) + CellPhone, 10), 3)
		WHERE PeopleId IN (SELECT PeopleId FROM inserted)
	END

	UPDATE dbo.People
		SET ResCodeId = dbo.FindResCode(ZipCode)
	WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)
	
	IF UPDATE(AddressTypeId)
	OR UPDATE(CityName) 
	OR UPDATE(AddressLineOne) 
	OR UPDATE(AddressLineTwo) 
	OR UPDATE(StateCode) 
	OR UPDATE(BadAddressFlag) 
	OR UPDATE(ZipCode)
	OR UPDATE(CountryName)
	OR UPDATE(FamilyId)
	BEGIN
		UPDATE dbo.People
		SET PrimaryCity = dbo.PrimaryCity(PeopleId),
		PrimaryAddress = dbo.PrimaryAddress(PeopleId),
		PrimaryAddress2 = dbo.PrimaryAddress2(PeopleId),
		PrimaryState = dbo.PrimaryState(PeopleId),
		PrimaryBadAddrFlag = dbo.PrimaryBadAddressFlag(PeopleId),
		PrimaryResCode = dbo.PrimaryResCode(PeopleId),
		PrimaryZip = dbo.PrimaryZip(PeopleId),
		PrimaryCountry = dbo.PrimaryCountry(PeopleId)
		WHERE PeopleId IN (SELECT PeopleId FROM inserted)
	END

	IF UPDATE(FirstName)
	OR UPDATE(LastName)
	OR UPDATE(NickName)
	OR UPDATE(MiddleName)
	BEGIN
		UPDATE Users
		SET Name = dbo.UName(PeopleId),
		Name2 = dbo.UName2(PeopleId)
		WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)
		
		UPDATE dbo.People 
		SET FirstName2 = REPLACE(FirstName + ISNULL(MiddleName, ''), ' ', '')
		WHERE PeopleId IN (SELECT PeopleId FROM INSERTED)
	END
	
	IF UPDATE(WeddingDate)
	BEGIN
		UPDATE dbo.People
		SET WeddingDate = i.WeddingDate
		FROM dbo.People p 
		JOIN INSERTED i ON i.PeopleId = p.SpouseId
	END

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetPeopleIdFromACS]'
GO
CREATE FUNCTION [dbo].[GetPeopleIdFromACS](@famnum int, @indnum int)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @id int

	-- Add the T-SQL statements to compute the return value here
	SELECT @id = PeopleId 
	FROM dbo.PeopleExtra
	WHERE Field = 'IndividualNumber' 
	AND IntValue = @famnum 
	AND IntValue2 = @indnum

	-- Return the result of the function
	RETURN @id

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BundleList]'
GO


CREATE VIEW [dbo].[BundleList]
AS
SELECT
	h.BundleHeaderId,
	MAX( ht.Description ) AS HeaderType,
	MAX(h.DepositDate) AS DepositDate,
	MAX(ISNULL(h.TotalCash,0)) + MAX(ISNULL(h.TotalChecks,0)) + MAX(ISNULL(h.TotalEnvelopes,0)) AS TotalBundle,
	MAX( h.FundId ) AS FundId,
	MAX( f.FundDescription ) AS Fund,
	MAX( bs.Description ) AS Status, 
	MAX( h.BundleStatusId ) AS [open],
	MAX( c.PostingDate ) AS PostingDate,
	MAX( c.TotalItems ) AS TotalItems,
	MAX( c.ItemCount ) AS ItemCount,
	MAX( c.TotalNonTaxDed ) AS TotalNonTaxDed
FROM BundleHeader AS h
INNER JOIN lookup.BundleHeaderTypes AS ht ON h.BundleHeaderTypeId = ht.Id
INNER JOIN lookup.BundleStatusTypes AS bs ON h.BundleStatusId = bs.Id
LEFT JOIN (
	SELECT d.BundleHeaderId,
		MAX(c.PostingDate) AS PostingDate,
		ISNULL( SUM(c.ContributionAmount), 0 ) AS TotalItems,
		COUNT(c.ContributionId) AS ItemCount,
		SUM( CASE WHEN c.ContributionTypeId = 9 or f.NonTaxDeductible = 1 THEN c.ContributionAmount ELSE 0 END ) AS TotalNonTaxDed
	FROM BundleDetail AS d
	INNER JOIN Contribution AS c ON c.ContributionId = d.ContributionId
	INNER JOIN ContributionFund AS f ON c.FundId = f.FundId
	GROUP BY d.BundleHeaderId
	) AS c ON c.BundleHeaderId = h.BundleHeaderId 
LEFT JOIN ContributionFund AS f ON h.FundId = f.FundId
WHERE h.RecordStatus = 0
GROUP BY h.BundleHeaderId




GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Contributions0]'
GO
CREATE FUNCTION [dbo].[Contributions0]
(
	@fd DATETIME, 
	@td DATETIME,
	@fundid INT,
	@campusid INT,
	@pledges BIT,
	@nontaxded BIT,
	@includeUnclosed BIT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT PeopleId FROM dbo.People 
	WHERE PeopleId NOT IN 
	(
		SELECT CreditGiverId
		FROM Contributions2(@fd, @td, @campusid, @pledges, @nontaxded, @includeUnclosed)
        WHERE (@fundid = 0 OR FundId = @fundid)
        AND Amount > 0
		GROUP BY CreditGiverId
	)
	AND PeopleId NOT IN
	(
		SELECT SpouseId
		FROM Contributions2(@fd, @td, @campusid, @pledges, @nontaxded, @includeUnclosed)
        WHERE (@fundid = 0 OR FundId = @fundid)
        AND Amount > 0
		AND SpouseId IS NOT NULL
		GROUP BY CreditGiverId, SpouseId
	)
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StatusFlagsAll]'
GO
CREATE FUNCTION [dbo].[StatusFlagsAll] 
(
	@pid INT
)

RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @Result NVARCHAR(200)

DECLARE @flags NVARCHAR(200)
DECLARE @show TABLE (Value nvarchar(10))

INSERT INTO @show SELECT substring(Description,1,3)
FROM dbo.QueryBuilderClauses
WHERE Description LIKE 'F[0-9][0-9]%'
GROUP BY Description


SELECT @Result = COALESCE(@Result + ', ', '') + c.Name
FROM dbo.People p
JOIN dbo.TagPerson tp ON p.PeopleId = tp.PeopleId
JOIN dbo.Tag t ON tp.Id = t.Id
JOIN dbo.Query c ON c.Name LIKE (t.Name + ':%')
WHERE t.Name IN (SELECT Value FROM @show)
AND p.PeopleId = @pid

RETURN ISNULL(@Result, '')
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Pledges0]'
GO
CREATE FUNCTION [dbo].[Pledges0]
(
	@fd DATETIME, 
	@td DATETIME,
	@fundid INT,
	@campusid INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT PeopleId FROM dbo.People 
	WHERE PeopleId NOT IN 
	(
		SELECT CreditGiverId
		FROM Contributions2(@fd, @td, @campusid, 1, NULL, 0)
        WHERE (@fundid = 0 OR FundId = @fundid)
        AND PledgeAmount > 0
		GROUP BY CreditGiverId
	)
	AND PeopleId NOT IN
	(
		SELECT SpouseId
		FROM Contributions2(@fd, @td, @campusid, 1, 0, 0)
        WHERE (@fundid = 0 OR FundId = @fundid)
        AND PledgeAmount > 0
		AND SpouseId IS NOT NULL
		GROUP BY CreditGiverId, SpouseId
	)
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastChanged]'
GO
CREATE FUNCTION [dbo].[LastChanged](@pid int, @field nvarchar(20))
RETURNS DATETIME
AS
BEGIN
	DECLARE @dt DATETIME
	SELECT TOP 1 @dt = Created FROM ChangeLog
	WHERE PeopleId = @pid
	AND Data LIKE ('%<td>' + @field + '</td>%')
	ORDER BY Created DESC
	RETURN @dt
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SundayDates]'
GO

CREATE  FUNCTION [dbo].[SundayDates](@dt1 datetime, @dt2 datetime)
RETURNS @dates TABLE
(   
	dt datetime
)
AS
BEGIN
	DECLARE @dt DATETIME = dbo.SundayForDate(@dt1)
	WHILE (@dt <= @dt2)
	BEGIN
		IF @dt >= @dt1
			INSERT INTO @dates VALUES (@dt)
		SET @dt = DATEADD(dd, 7, @dt)
	END
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTotalContributionsDonor2]'
GO

CREATE FUNCTION [dbo].[GetTotalContributionsDonor2]
(
	@fd DATETIME, 
	@td DATETIME,
	@campusid INT,
	@nontaxded BIT,
	@includeUnclosed BIT
)
RETURNS TABLE
AS
RETURN 
(
	SELECT tt.*, ISNULL(o.OrganizationName, '') MainFellowship, ms.Description MemberStatus FROM
	(
	SELECT 
		CreditGiverId, 
		HeadName, 
		SpouseName, 
		COUNT(*) AS [Count], 
		SUM(Amount) AS Amount, 
		SUM(PledgeAmount) AS PledgeAmount
	FROM dbo.Contributions2(@fd, @td, @campusid, NULL, @nontaxded, @includeUnclosed)
	GROUP BY CreditGiverId, HeadName, SpouseName
	) tt 
	JOIN dbo.People p ON p.PeopleId = tt.CreditGiverId
	JOIN lookup.MemberStatus ms ON p.MemberStatusId = ms.Id
	LEFT OUTER JOIN dbo.Organizations o ON o.OrganizationId = p.BibleFellowshipClassId
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendDaysAfterNthVisitInDateRange]'
GO
CREATE FUNCTION [dbo].[AttendDaysAfterNthVisitInDateRange](@pid INT, @progid INT, @divid INT, @orgid INT,
	@d1 DATETIME, @d2 DATETIME, @n INT)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @days INT, @nthAttend DATETIME, @epoch DATETIME, @d3 DATETIME
	
	SELECT @epoch = Setting FROM dbo.Setting WHERE Id = 'DbCreatedDate'

	SELECT TOP 1 @nthAttend = MeetingDate FROM Attend a
	WHERE a.PeopleId = @pid
	AND a.AttendanceFlag = 1 
	AND a.MeetingDate > @epoch
	AND a.SeqNo = @n
	ORDER BY a.MeetingDate
	
	IF (@nthAttend < @d1 OR @nthAttend > @d2 OR @nthAttend IS NULL)
		RETURN NULL
	
	SELECT TOP 1 @d3 = MeetingDate FROM Attend a
	WHERE a.PeopleId = @pid AND (@orgid = 0 OR @orgid = a.OrganizationId)
	AND (@divid = 0 OR EXISTS(SELECT NULL FROM dbo.DivOrg do WHERE do.OrgId = a.OrganizationId AND do.DivId = @divid))
	AND (@progid = 0 OR EXISTS(SELECT NULL FROM dbo.DivOrg do JOIN dbo.Division d ON do.DivId = d.Id JOIN dbo.ProgDiv pd ON d.Id = pd.DivId WHERE pd.ProgId = @progid AND do.OrgId = a.OrganizationId))
	AND a.AttendanceFlag = 1
	AND DATEDIFF(d, @nthAttend, a.MeetingDate) >= 1 -- some day after the nth visit
	ORDER BY a.MeetingDate
	
	SELECT @days = DATEDIFF(d, @nthAttend, @d3)
	
	IF @days IS NULL
		SET @days = 9999
		
	-- Return the result of the function
	RETURN @days

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Churches]'
GO

CREATE VIEW [dbo].Churches
AS
SELECT c FROM (
SELECT OtherNewChurch c FROM dbo.People
UNION 
SELECT OtherPreviousChurch c FROM dbo.People
) AS t
GROUP BY c

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CreateMeeting]'
GO
CREATE PROCEDURE [dbo].[CreateMeeting]
    (
      @oid INT,
      @mdt DATETIME
    )
AS
BEGIN
	DECLARE @mid INT
	
	SELECT TOP 1 @mid = MeetingId
	FROM dbo.Meetings
	WHERE OrganizationId = @oid
	AND MeetingDate = @mdt
	
	IF (@mid IS NULL)
	BEGIN
		DECLARE @acrid INT
		SELECT @acrid = AttendCreditId
		FROM dbo.OrgSchedule
		WHERE OrganizationId = @oid
		AND CAST(SchedTime AS TIME) = CAST(@mdt AS TIME)
		AND SchedDay = (DATEPART(dw, @mdt) - 1)
		INSERT dbo.Meetings
		        ( CreatedBy, CreatedDate , OrganizationId, MeetingDate, GroupMeetingFlag, AttendCreditId )
		VALUES  ( 0, GETDATE(), @oid, @mdt, 0, @acrid )
		SELECT @mid = SCOPE_IDENTITY()
	END
	RETURN @mid
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FmtPhone]'
GO

CREATE FUNCTION [dbo].[FmtPhone](@PhoneNumber nvarchar(32))
RETURNS nvarchar(32)
AS
BEGIN
	IF LEN(@PhoneNumber) >= 10
		RETURN Stuff(Stuff(@PhoneNumber,7,0,'-'),4,0,'-')
	IF LEN(@PhoneNumber) = 7
		RETURN Stuff(@PhoneNumber,4,0,'-')
	RETURN @PhoneNumber
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ParentNamesAndCells]'
GO
CREATE FUNCTION [dbo].[ParentNamesAndCells](@pid INT) 

RETURNS nvarchar(200)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @name1 nvarchar(30)
	DECLARE @cell1 nvarchar(20)
	DECLARE @name2 nvarchar(30)
	DECLARE @cell2 nvarchar(20)
	DECLARE @names nvarchar(100)

	-- Add the T-SQL statements to compute the return value here
	SELECT	@name1 = h.PreferredName, 
			@cell1 = h.CellPhone,
			@name2 = s.PreferredName,
			@cell2 = s.CellPhone  
	FROM dbo.People p
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	LEFT JOIN dbo.People h ON f.FamilyId = h.FamilyId AND h.PeopleId = f.HeadOfHouseholdId
	LEFT JOIN dbo.People s ON f.FamilyId = s.FamilyId AND s.PeopleId = f.HeadOfHouseholdSpouseId
	WHERE p.PeopleId = @pid

	SET @names = @name1
	IF LEN(@name2) > 0
		SET @names = @name1 + ' and ' + @name2
	IF LEN(@cell1) > 0
		SET @names = @names + ', c ' + dbo.FmtPhone(@cell1)
	IF LEN(@cell2) > 0
		SET @names = @names + ', c ' + dbo.FmtPhone(@cell2)
	
	-- Return the result of the function
	RETURN @names

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecordAttend2]'
GO
CREATE PROCEDURE [dbo].[RecordAttend2]
( @orgid INT, @mdt DATETIME, @pid INT)
AS
BEGIN
	DECLARE @mid INT
	
	EXEC @mid = dbo.CreateMeeting @orgid, @mdt
	EXEC  dbo.RecordAttend @mid, @pid, 1
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationPrevMemberCount]'
GO
CREATE FUNCTION [dbo].[OrganizationPrevMemberCount](@oid int) 
RETURNS int
AS
BEGIN
	DECLARE @c int
	
SELECT @c = COUNT(*)
FROM dbo.EnrollmentTransaction et
WHERE TransactionStatus = 0
AND OrganizationId = @oid
AND TransactionTypeId > 3
AND TransactionDate = (SELECT MAX(TransactionDate) FROM dbo.EnrollmentTransaction WHERE PeopleId = et.PeopleId AND OrganizationId = et.OrganizationId AND TransactionTypeId > 3 AND TransactionStatus = 0)
AND NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers WHERE PeopleId = et.PeopleId AND OrganizationId = et.OrganizationId)
	
	RETURN @c
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[OrganizationStatus]'
GO
CREATE TABLE [lookup].[OrganizationStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrganizationStatus] on [lookup].[OrganizationStatus]'
GO
ALTER TABLE [lookup].[OrganizationStatus] ADD CONSTRAINT [PK_OrganizationStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationStructure]'
GO
CREATE VIEW [dbo].[OrganizationStructure]
AS
SELECT 
	 p.Name Program 
	,d.Name Division 
	,os.Description OrgStatus
	,o.OrganizationName Organization
	,(SELECT COUNT(*) FROM dbo.OrganizationMembers om WHERE om.OrganizationId = o.OrganizationId) Members
	,(SELECT COUNT(*) FROM dbo.EnrollmentTransaction et 
		WHERE et.OrganizationId = o.OrganizationId 
		AND et.TransactionTypeId = 5 
		AND NOT EXISTS (SELECT NULL FROM dbo.OrganizationMembers 
			WHERE OrganizationId = o.OrganizationId AND PeopleId = et.PeopleId) 
	 ) Previous
	,p.Id ProgId
	,d.Id DivId
	,o.OrganizationId OrgId
FROM dbo.Program p
JOIN dbo.ProgDiv pd ON p.Id = pd.ProgId
JOIN dbo.Division  d ON d.Id = pd.DivId
JOIN dbo.DivOrg do ON pd.DivId = do.DivId
JOIN dbo.Organizations o ON do.OrgId = o.OrganizationId
JOIN lookup.OrganizationStatus os ON o.OrganizationStatusId = os.Id
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TaggedPeople]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[TaggedPeople](@tagid INT) 
RETURNS @t TABLE ( PeopleId INT)
AS
BEGIN
	INSERT INTO @t (PeopleId)
	SELECT p.PeopleId FROM dbo.People p
	WHERE EXISTS(
    SELECT NULL
    FROM dbo.TagPerson t
    WHERE (t.Id = @tagid) AND (t.PeopleId = p.PeopleId))
    RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[delOrg] on [dbo].[Organizations]'
GO
CREATE TRIGGER [dbo].[delOrg] 
   ON  [dbo].[Organizations] 
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT NULL FROM dbo.Organizations)
	BEGIN
		SET IDENTITY_INSERT [dbo].[Organizations] ON
		INSERT INTO [dbo].[Organizations] ([OrganizationId], [CreatedBy], [CreatedDate], [OrganizationStatusId], [DivisionId], [LeaderMemberTypeId], [GradeAgeStart], [GradeAgeEnd], [RollSheetVisitorWks], [SecurityTypeId], [FirstMeetingDate], [LastMeetingDate], [OrganizationClosedDate], [Location], [OrganizationName], [ModifiedBy], [ModifiedDate], [EntryPointId], [ParentOrgId], [AllowAttendOverlap], [MemberCount], [LeaderId], [LeaderName], [ClassFilled], [OnLineCatalogSort], [PendingLoc], [CanSelfCheckin], [NumCheckInLabels], [CampusId], [AllowNonCampusCheckIn], [NumWorkerCheckInLabels], [ShowOnlyRegisteredAtCheckIn], [Limit], [GenderId], [Description], [BirthDayStart], [BirthDayEnd], [LastDayBeforeExtra], [RegistrationTypeId], [ValidateOrgs], [PhoneNumber], [RegistrationClosed], [AllowKioskRegister], [WorshipGroupCodes], [IsBibleFellowshipOrg], [NoSecurityLabel], [AlwaysSecurityLabel], [DaysToIgnoreHistory], [NotifyIds], [lat], [long], [RegSetting], [OrgPickList], [Offsite]) VALUES (1, 1, '2009-05-05T22:46:43.983', 30, 1, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, '', 'First Organization', NULL, NULL, 0, NULL, 0, 2, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
	END
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DecToBase]'
GO
CREATE function [dbo].DecToBase
(
@val as BigInt,
@base as int
)
returns nvarchar(63)
as
Begin
	If (@val<0) OR (@base < 2) OR (@base> 36) 
		Return Null;
	Declare @answer as nvarchar(63) = '';
	Declare @alldigits as nvarchar(36) = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	While @val>0
	Begin
		Set @answer=Substring(@alldigits,@val % @base + 1,1) + @answer;
		Set @val = @val / @base;
	End
	return @answer;
End
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[NextSecurityCode]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NextSecurityCode] (@dt DATETIME)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ct INT
	SELECT @ct = COUNT(*) FROM SecurityCodes
	IF (@ct = 0)
	BEGIN
		DECLARE @n int = 45000
		DECLARE @v nvarchar(3)
		WHILE @n > 0
		BEGIN
			SELECT @v = dbo.DecToBase(RAND() * 45000, 36)
			IF @v LIKE '%[0-9]%' AND LEN(@v) = 3
				INSERT SecurityCodes (Code, DateUsed) VALUES(@v, '1/1/80')
			SET @n = @n -1
		END
	END

	DECLARE @id INT
	DECLARE @midnight DATETIME = DATEADD(dd, DATEDIFF(dd,0,getdate()), 0)
	BEGIN TRANSACTION
		SELECT TOP 1 @id = id FROM SecurityCodes WHERE DateUsed < @midnight ORDER BY NEWID()
		UPDATE SecurityCodes SET DateUsed = @dt WHERE id = @id
	COMMIT TRANSACTION
	
	SELECT TOP 1 * FROM dbo.SecurityCodes WHERE id = @id
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PreviousMemberCounts]'
GO

CREATE VIEW [dbo].[PreviousMemberCounts]
AS
SELECT et.OrganizationId, COUNT(*) prevcount
FROM dbo.EnrollmentTransaction et 
WHERE TransactionStatus = 0
AND TransactionTypeId > 3
AND TransactionDate = (SELECT MAX(TransactionDate) FROM dbo.EnrollmentTransaction WHERE PeopleId = et.PeopleId AND OrganizationId = et.OrganizationId AND TransactionTypeId > 3) 
AND NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers WHERE PeopleId = et.PeopleId AND OrganizationId = et.OrganizationId)
GROUP BY et.OrganizationId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrgMembersAsOfDate]'
GO
CREATE FUNCTION [dbo].[OrgMembersAsOfDate](@orgid INT, @meetingdt DATETIME)

RETURNS TABLE 
AS
RETURN 
(
SELECT 
	p.PeopleId,
	p.FamilyId,
	p.PreferredName,
	p.LastName,
	p.BirthDay,
	p.BirthMonth,
	p.BirthYear,
	p.PrimaryAddress,
	p.PrimaryAddress2,
	p.PrimaryCity,
	p.PrimaryState,
	p.PrimaryZip,
	p.HomePhone,
	p.CellPhone,
	p.WorkPhone,
	p.EmailAddress,
	ms.Description MemberStatus,
	pp.Name BFTeacher,
	pp.PeopleId BFTeacherId,
	p.Age,
	mt.Description MemberType,
	mt.Id MemberTypeId,
	ISNULL(ee.EnrollmentDate, ee.TransactionDate) Joined
FROM dbo.EnrollmentTransaction ee
JOIN dbo.People p ON ee.PeopleId = p.PeopleId
JOIN lookup.MemberStatus ms ON p.MemberStatusId = ms.Id
JOIN lookup.MemberType mt ON ee.MemberTypeId = mt.Id
LEFT JOIN dbo.Organizations o ON p.BibleFellowshipClassId = o.OrganizationId
LEFT JOIN dbo.People pp ON o.LeaderId = pp.PeopleId
WHERE ee.OrganizationId = @orgid
AND ee.TransactionTypeId <= 3 -- Enrollment transaction
AND ee.TransactionStatus = 0
AND ee.MemberTypeId != 311 -- not a prospect
AND ISNULL(ee.Pending, 0) = 0 -- not a pending member
AND ee.TransactionDate < @meetingdt -- enrolled before the meetingdate
AND (ee.NextTranChangeDate >= @meetingdt -- still enrolled
	OR ee.NextTranChangeDate IS NULL) -- or no change in status
AND (ee.NextTranChangeDate != NULL
	OR ee.TransactionId = 
		(SELECT MAX(TransactionId)
		 FROM dbo.EnrollmentTransaction 
		 WHERE PeopleId = p.PeopleId 
		 AND OrganizationId = ee.OrganizationId 
		 AND TransactionTypeId <= 3 
		 AND TransactionDate < @meetingdt)
	)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PledgeFulfillment]'
GO
CREATE FUNCTION [dbo].[PledgeFulfillment] ( @fundid INT )
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		p.PreferredName [First]
		,p.LastName [Last]
		,sp.PreferredName Spouse
		,ms.Description [MemberStatus]
		,(SELECT MIN(Date) FROM Contributions2('1/1/1', '1/1/3000', 0, NULL, NULL, 1) WHERE FundId = @fundid AND CreditGiverId = c.CreditGiverId AND PledgeAmount > 0) PledgeDate
		,MAX(Date) LastDate
		,SUM(PledgeAmount) PledgeAmt
		,SUM(Amount) TotalGiven
		,CASE WHEN SUM(ISNULL(c.PledgeAmount, 0)) > 0 
				THEN SUM(ISNULL(PledgeAmount, 0)) - SUM(ISNULL(Amount, 0))
				ELSE 0
		 END Balance
		,p.PrimaryAddress [Address]
		,p.PrimaryCity [City]
		,p.PrimaryState [State]
		,p.PrimaryZip [Zip]
		,c.CreditGiverId
		,c.SpouseId
		,c.FamilyId
	FROM Contributions2('1/1/1', '1/1/3000', 0, NULL, NULL, 1) c
	JOIN dbo.People p ON c.CreditGiverId = p.PeopleId
	JOIN lookup.MemberStatus ms ON p.MemberStatusId = ms.Id
	LEFT OUTER JOIN dbo.People sp ON p.SpouseId = sp.PeopleId
	WHERE c.FundId = @fundid
	GROUP BY c.CreditGiverId, c.SpouseId, p.PreferredName, p.LastName, sp.PreferredName, p.PrimaryAddress, p.PrimaryCity, p.PrimaryState, p.PrimaryZip, ms.Description, c.FamilyId
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ContributionType]'
GO
CREATE TABLE [lookup].[ContributionType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (5) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContributionType] on [lookup].[ContributionType]'
GO
ALTER TABLE [lookup].[ContributionType] ADD CONSTRAINT [PK_ContributionType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ContributionStatus]'
GO
CREATE TABLE [lookup].[ContributionStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (5) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContributionStatus] on [lookup].[ContributionStatus]'
GO
ALTER TABLE [lookup].[ContributionStatus] ADD CONSTRAINT [PK_ContributionStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionsView]'
GO



CREATE VIEW [dbo].[ContributionsView]
AS
SELECT
	f.FundId, 
	ContributionTypeId AS TypeId, 
	ContributionDate AS CDate, 
	ContributionAmount AS Amount, 
	ContributionStatusId AS StatusId,
	CONVERT(BIT, CASE WHEN ContributionTypeId = 8 THEN 1 ELSE 0 END) AS Pledged,
	Age,
	Age / 10 AS AgeRange,
	f.FundDescription AS Fund,
	cs.Description AS [Status],
	ct.Description AS [Type],
	p.Name
FROM dbo.Contribution c
JOIN dbo.People p ON c.PeopleId = p.PeopleId
JOIN lookup.ContributionStatus cs ON c.ContributionStatusId = cs.Id
JOIN lookup.ContributionType ct ON c.ContributionTypeId = ct.Id
JOIN dbo.ContributionFund f ON c.FundId = f.FundId


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetSecurityCode]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSecurityCode]()
RETURNS CHAR(3)
AS
BEGIN
	DECLARE @code CHAR(3)
	EXEC NextSecurityCode @code OUTPUT
	RETURN @code
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrgVisitorsAsOfDate]'
GO
CREATE FUNCTION [dbo].[OrgVisitorsAsOfDate](@orgid INT, @meetingdt DATETIME, @NoCurrentMembers BIT)

RETURNS TABLE 
AS
RETURN 
(
SELECT 
	CASE WHEN p.MemberStatusId = 10 THEN 'VM' ELSE 'VS' END VisitorType,
	p.PeopleId,
	p.FamilyId,
	p.PreferredName,
	p.LastName,
	p.BirthYear,
	p.BirthMonth,
	p.BirthDay,
	p.PrimaryAddress,
	p.PrimaryAddress2,
	p.PrimaryCity,
	p.PrimaryState,
	p.PrimaryZip,
	p.HomePhone,
	p.CellPhone,
	p.WorkPhone,
	ms.Description MemberStatus,
	p.EmailAddress Email,
	pp.Name2 BFTeacher,
	pp.PeopleId BFTeacherId,
	p.Age,
	dbo.LastAttended(@orgid, p.PeopleId) LastAttended
FROM dbo.People p
JOIN lookup.MemberStatus ms ON p.MemberStatusId = ms.Id
JOIN dbo.Families f ON f.FamilyId = p.FamilyId
LEFT JOIN dbo.Organizations om ON p.BibleFellowshipClassId = om.OrganizationId
LEFT JOIN dbo.People pp ON om.LeaderId = pp.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.Attend a 
			 JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
			 JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			 WHERE a.PeopleId = p.PeopleId AND m.OrganizationId = @orgid
			 AND (a.AttendanceFlag = 1 OR a.Commitment IN (1, 4))
			 AND a.MeetingDate >= DATEADD(day, ISNULL(o.RollSheetVisitorWks, 3) * -7, @meetingdt)
			 AND a.MeetingDate <= @meetingdt
			 AND (a.MeetingDate > o.FirstMeetingDate OR o.FirstMeetingDate IS NULL)
			 AND a.AttendanceTypeId IN (40,50,60,110)
			 )
AND  (@NoCurrentMembers = 0 
		OR NOT EXISTS(
			SELECT NULL FROM dbo.OrganizationMembers om 
			WHERE om.OrganizationId = @orgid 
			AND om.PeopleId = p.PeopleId
			AND om.MemberTypeId <> 311 -- prospect
	  ))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserList]'
GO
CREATE VIEW [dbo].[UserList]
AS
SELECT u.Username, u.UserId, u.Name, u.Name2, u.IsApproved, u.MustChangePassword, u.IsLockedOut, u.EmailAddress, ttt.LastActivityDate, u.PeopleId, dbo.UserRoleList(u.UserId) Roles FROM Users u
JOIN ( SELECT UserId, MAX(ActivityDate) AS LastActivityDate FROM dbo.ActivityLog GROUP BY UserId ) AS ttt
ON u.UserId = ttt.UserId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StatusFlag]'
GO
CREATE FUNCTION [dbo].[StatusFlag] 
(
	@pid INT
)

RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @Result NVARCHAR(200)

DECLARE @flags NVARCHAR(200)
SELECT @flags = Setting FROM dbo.Setting WHERE Id = 'StatusFlags'
DECLARE @show TABLE (Value nvarchar(100))
INSERT INTO @show SELECT Value FROM dbo.Split(@flags, ',')
SELECT @Result = COALESCE(@Result + ', ', '') + SUBSTRING(c.Name, 5, 50)
FROM dbo.People p
JOIN dbo.TagPerson tp ON p.PeopleId = tp.PeopleId
JOIN dbo.Tag t ON tp.Id = t.Id
JOIN dbo.Query c ON c.Name LIKE (t.Name + ':%')
WHERE t.Name IN (SELECT Value FROM @show)
AND p.PeopleId = @pid

RETURN @Result
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrgMembers]'
GO
CREATE PROCEDURE [dbo].[OrgMembers](@oid INT, @gid nvarchar(200))
AS
BEGIN

DECLARE @headers nvarchar(MAX)
SELECT @headers = 
  COALESCE(
    @headers + ',[' + cast(Name as nvarchar(200)) + ']',
    '[' + cast(Name as nvarchar(200))+ ']'
  )
FROM dbo.MemberTags mt 
JOIN dbo.OrgMemMemTags omt ON mt.Id = omt.MemberTagId 
WHERE omt.OrgId = @oid
GROUP BY mt.Name
SET @headers = ISNULL(@headers, '[No Groups]')
PRINT @headers

DECLARE @PivotTableSQL NVARCHAR(MAX)
SET @PivotTableSQL = N'
SELECT t1.*, t2.*
FROM (
  SELECT *
  FROM (
    SELECT isnull(omt.Number, 1) num, p.PeopleId, mt.Name TagName
    FROM dbo.OrganizationMembers om
    JOIN dbo.People p ON om.PeopleId = p.PeopleId
    LEFT JOIN dbo.OrgMemMemTags omt ON omt.OrgId = om.OrganizationId AND omt.PeopleId = om.PeopleId
    LEFT JOIN dbo.MemberTags mt on omt.MemberTagId = mt.Id
	WHERE OrganizationId = ' + CAST(@oid AS nvarchar(10)) + '
  ) AS pdata
  PIVOT 
  (
    sum(num)
    FOR TagName IN (
      ' + @headers + '
    )
  ) AS ptable
) t2
JOIN 
	(select p.PreferredName AS FirstName, 
			p.LastName, 
			g.Code AS Gender,
			CAST(p.Grade AS nvarchar(10)) AS Grade,
			om.ShirtSize,
			om.Request,
			ISNULL(om.Amount, 0) AS Amount,
			ISNULL(om.AmountPaid, 0) AS AmountPaid,
			p.EmailAddress AS Email,
			mas.Description AS Marital,
			dbo.FmtPhone(p.HomePhone) AS HomePhone,
			dbo.FmtPhone(p.CellPhone) AS CellPhone,
			dbo.FmtPhone(p.WorkPhone) AS WorkPhone,
			CAST(p.Age AS nvarchar(3)) AS Age,
			CAST(dbo.Birthday(p.PeopleId) AS nvarchar(20)) AS Birthday,
			CONVERT(nvarchar(12), p.JoinDate, 101) AS JoinDate,
			ms.Description AS MemberStatus,
			p.SchoolOther AS School,
			CONVERT(nvarchar(12),om.LastAttended, 101) AS LastAttend,
			CAST(om.AttendPct AS nvarchar(12)) AS AttendPct,
			om.AttendStr,
			mt.Description AS MemberType,
			REPLACE(om.UserData, ''
'', ''<br/>'') AS MemberInfo,
			CONVERT(nvarchar(12), om.EnrollmentDate, 101) AS EnrollDate,
			p.PeopleId
	from People p
	JOIN dbo.OrganizationMembers om ON p.PeopleId = om.PeopleId
	JOIN lookup.Gender g ON p.GenderId = g.Id
	JOIN lookup.MemberStatus ms ON p.MemberStatusId = ms.Id
	JOIN lookup.MaritalStatus mas ON p.MaritalStatusId = mas.Id
	JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
	WHERE om.OrganizationId = ' + CAST(@oid AS nvarchar(10)) + '
	AND (''' + @gid + ''' = ''0'' OR EXISTS(SELECT NULL FROM dbo.OrgMemMemTags 
			WHERE OrgId = ' + CAST(@oid AS nvarchar(10)) + ' 
			AND PeopleId = p.PeopleId 
			AND MemberTagId in (' + @gid + ')))) t1
	ON t1.PeopleId = t2.PeopleId
'
PRINT @PivotTableSQL

EXECUTE(@PivotTableSQL)

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SaveUsers]'
GO
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
CREATE PROCEDURE [dbo].[SaveUsers]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT Name, EmailAddress, 
		LEFT(Roles, LEN(Roles) -1) AS Roles
	FROM (SELECT DISTINCT Name, EmailAddress,
			(SELECT RoleName + ',' AS [text()] 
			FROM Roles r
			JOIN dbo.UserRole ur ON r.RoleId = ur.RoleId
			WHERE ur.UserId = u.UserId
			FOR XML PATH ('')) Roles
	FROM dbo.Users u
	WHERE EmailAddress NOT IN ('david@bvcms.com','karen@bvcms.com', 'support@bvcms.com')
	) tt

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateETAttendPct]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateETAttendPct] (@tid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-----------------------------------------------------------------
    DECLARE @yearago DATETIME
    DECLARE @lastmeet DATETIME 
    DECLARE @tct INT 
    DECLARE @act INT
    DECLARE @pct REAL
    DECLARE @fromdt DATETIME
    DECLARE @pid INT, @orgid INT
		
	SELECT @fromdt = TransactionDate, @pid = PeopleId, @orgid = OrganizationId
	FROM dbo.EnrollmentTransaction WHERE @tid = TransactionId
		
    SELECT @lastmeet = MAX(MeetingDate) FROM dbo.Meetings
    WHERE OrganizationId = @orgid AND MeetingDate <= @fromdt
    
    SELECT @yearago = DATEADD(year,-1,@lastmeet)
    
	SELECT @tct = COUNT(*) FROM dbo.Attend
     WHERE PeopleId = @pid
       AND OrganizationId = @orgid
       AND EffAttendFlag IS NOT NULL
       AND MeetingDate >= @yearago
       AND MeetingDate <= @fromdt
       
    SELECT @act = COUNT(*) FROM dbo.Attend
     WHERE PeopleId = @pid
       AND OrganizationId = @orgid
       AND EffAttendFlag = 1
       AND MeetingDate >= @yearago
       AND MeetingDate <= @fromdt
      
       
	if @tct = 0
			select @pct = 0
		else
			SELECT @pct = @act * 100.0 / @tct
			
	--------------------------------------------	
	
		
	UPDATE dbo.EnrollmentTransaction SET
		AttendancePercentage = @pct
	WHERE TransactionId = @tid

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StatusFlags]'
GO
CREATE FUNCTION [dbo].[StatusFlags](@flags nvarchar(100))
RETURNS TABLE 
AS
RETURN 
(
SELECT PeopleId,
SUBSTRING((Select ', ' + SUBSTRING(c.Name, 5, 50) AS [text()]
FROM dbo.People p1
JOIN dbo.TagPerson tp ON p1.PeopleId = tp.PeopleId
JOIN dbo.Tag t ON tp.Id = t.Id
JOIN dbo.Query c ON c.Name LIKE (t.Name + ':%')
JOIN dbo.Split(@flags, ',') ff ON t.Name = ff.Value
WHERE p1.PeopleId = p2.PeopleId
ORDER BY ff.TokenID
FOR XML PATH ('')),3, 1000) StatusFlags
From dbo.People p2
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TopGivers]'
GO
CREATE PROCEDURE [dbo].[TopGivers](@top INT, @sdate DATETIME, @edate DATETIME)
AS
BEGIN

	SELECT TOP (@top) c.PeopleId, Name, SUM(ContributionAmount) FROM dbo.People p
	JOIN dbo.Contribution c ON p.PeopleId = c.PeopleId
	WHERE c.ContributionDate >= @sdate
	AND c.ContributionDate <= @edate
	AND c.ContributionTypeId NOT IN (6,7,8)
	GROUP BY c.PeopleId, Name
	ORDER BY SUM(ContributionAmount) DESC

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllETAttendPct]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAllETAttendPct]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		DECLARE cur CURSOR FOR SELECT TransactionId FROM dbo.EnrollmentTransaction WHERE TransactionTypeId > 3
		OPEN cur
		DECLARE @tid INT, @n INT
		SET @n = 0
		FETCH NEXT FROM cur INTO @tid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.UpdateETAttendPct @tid
			SET @n = @n + 1
			IF (@n % 1000) = 0
				RAISERROR ('%d', 0, 1, @n) WITH NOWAIT
			FETCH NEXT FROM cur INTO @tid
		END
		CLOSE cur
		DEALLOCATE cur
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[UpdateContribution] on [dbo].[Contribution]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[UpdateContribution] 
   ON  [dbo].[Contribution]
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF(UPDATE(FundId))
	BEGIN
		UPDATE dbo.Contribution
		SET ContributionTypeId = 9
		FROM dbo.Contribution c
		JOIN INSERTED i ON c.ContributionId = i.ContributionId
		JOIN dbo.ContributionFund f ON i.FundId = f.FundId
		WHERE f.NonTaxDeductible = 1
	END

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StatusGrid]'
GO
CREATE PROCEDURE [dbo].[StatusGrid](@tagid INT)
AS
BEGIN
DECLARE @cases nvarchar(MAX) = ''
SELECT @cases = @cases +
', MAX(CASE t.Name WHEN ''' + t.Name + ''' THEN ''X'' ELSE '''' END) AS [' 
+ REPLACE(
	+ REPLACE(SUBSTRING(c.Name, 5, 50), ' ', '_')
, '.', '_') + ']
'
FROM Tag t
JOIN dbo.Query c ON LEFT(c.Name,3) = t.Name
WHERE t.TypeId = 100
GROUP BY t.Name, c.Name
ORDER BY t.Name

DECLARE @sql nvarchar(MAX) = '
SELECT 
PreferredName First, 
LastName Last, 
ISNULL(CAST(Age AS nvarchar),'''') Age, 
ms.Description Marital,
REPLACE(ISNULL(CONVERT(nvarchar(10), dbo.FirstMeetingDateLastLear(p.PeopleId), 20), ''''), ''/'', ''-'') FirstAttend,
tt.*
FROM dbo.People p
JOIN lookup.MaritalStatus ms on p.MaritalStatusId = ms.Id
JOIN 
(
SELECT pp.PeopleId
' + @cases +
'FROM
dbo.People pp
JOIN dbo.TagPerson tp ON pp.PeopleId = tp.PeopleId
JOIN Tag t ON tp.Id = t.Id
WHERE t.Name LIKE ''F[0-9][0-9]''
GROUP BY pp.PeopleId
) tt
ON p.PeopleId = tt.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = ' + CAST(@tagid AS nvarchar)
+ ' AND tp.PeopleId = p.PeopleId)'
PRINT @sql
EXEC (@sql)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAbsents2]'
GO
CREATE FUNCTION [dbo].[RecentAbsents2](@orgid INT, @divid INT, @days INT)
RETURNS 
@ret TABLE 
(
OrganizationId INT,
OrganizationName nvarchar(70),
LeaderName nvarchar(60),
consecutive INT,
PeopleId INT,
Name2 nvarchar(50),
HomePhone nvarchar(15),
CellPhone nvarchar(15),
EmailAddress nvarchar(50),
MeetingId INT,
ConsecutiveAbsentsThreshhold INT
)
AS
BEGIN
DECLARE @t TABLE ( Oid INT NOT NULL, Pid INT NOT NULL, consecutive INT,
PRIMARY KEY (Oid, Pid));

WITH LastAbsents AS
(
  SELECT OrganizationId, PeopleId, MAX(MeetingDate) ld
  FROM Attend
  WHERE EffAttendFlag = 0
  GROUP BY OrganizationId, PeopleId
)
INSERT INTO @t (Oid, Pid, consecutive) 
SELECT a.OrganizationId, a.PeopleId, count(*) As ConsecutiveAbsents
FROM dbo.Attend a
INNER JOIN LastAbsents la 
			ON la.OrganizationId = a.OrganizationId 
			AND la.PeopleId = a.PeopleId
			AND a.MeetingDate > la.ld
			AND a.MeetingDate < GETDATE()
		WHERE (a.OrganizationId = @orgid OR @orgid IS NULL)
		AND (@divid IS NULL 
			OR EXISTS(SELECT NULL 
						FROM dbo.DivOrg 
						WHERE OrgId = a.OrganizationId AND DivId = @divid))
group by a.OrganizationId, a.PeopleId
		
		
INSERT INTO @ret (
	OrganizationId,
	OrganizationName,
	LeaderName,
	consecutive,
	PeopleId,
	Name2,
	HomePhone,
	CellPhone,
	EmailAddress,
	ConsecutiveAbsentsThreshhold
)
	SELECT 
		 pp.OrganizationId
		,oo.OrganizationName
		,oo.LeaderName
		,consecutive
		,pp.PeopleId 
		,pp.Name2
		,pp.HomePhone
		,pp.CellPhone
		,pp.EmailAddress
		,ConsecutiveAbsentsThreshold
	FROM @t t
	JOIN
	(
		SELECT 
			m.PeopleId, 
			p.Name2, 
			p.EmailAddress, 
			p.HomePhone, 
			p.CellPhone, 
			m.OrganizationId, 
			m.MemberTypeId, 
			at.Id AttendTypeId
		FROM dbo.OrganizationMembers m
		JOIN lookup.MemberType mt ON m.MemberTypeId = mt.Id
		JOIN lookup.AttendType at ON at.Id = mt.AttendanceTypeId
		JOIN dbo.People p ON m.PeopleId = p.PeopleId
	) pp ON t.Pid = pp.PeopleId AND t.Oid = pp.OrganizationId
	JOIN
	(
		SELECT 
			o.OrganizationId, 
			o.OrganizationName, 
			o.LeaderName, 
			ISNULL(o.ConsecutiveAbsentsThreshold, 2) AS ConsecutiveAbsentsThreshold
		FROM dbo.Organizations o
		WHERE (o.OrganizationId = @orgid OR @orgid IS NULL)
		AND (@divid IS NULL 
			OR EXISTS(SELECT NULL 
						FROM dbo.DivOrg 
						WHERE OrgId = o.OrganizationId AND DivId = @divid))
	) oo ON pp.OrganizationId = oo.OrganizationId
	WHERE consecutive >= ISNULL(oo.ConsecutiveAbsentsThreshold, 2)
	AND pp.AttendTypeId NOT IN (70, 100) --inservice and homebound
	AND pp.MemberTypeId != 230 --inactive	
	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ExtraValues]'
GO
CREATE PROCEDURE [dbo].[ExtraValues](@tagid INT, @sort nvarchar(100) = '', @nodisplaycols nvarchar(MAX))
AS
BEGIN
--DECLARE @nodisplaycols nvarchar(200) = 'Ted|PastoralCare'
DECLARE @Cols TABLE (Value nvarchar(100))
INSERT INTO @Cols SELECT Value FROM dbo.Split(@nodisplaycols, '|')

DECLARE @sql nvarchar(MAX) = 'select * from (SELECT PeopleId, (SELECT p2.Name FROM dbo.People p2 WHERE p2.PeopleId = p.PeopleId) FullName'

SELECT @sql = 
      @sql + ',ISNULL((SELECT TOP 1 pe.StrValue FROM dbo.PeopleExtra pe WHERE pe.PeopleId = p.PeopleId AND pe.Field = ''' +  CAST(Field as nvarchar(100)) + '''),'''') [' + CAST(Field AS nvarchar(100)) + ']'
FROM dbo.PeopleExtra pe 
JOIN dbo.People p ON pe.PeopleId = p.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = @tagid AND tp.PeopleId = p.PeopleId)
AND pe.StrValue IS NOT NULL
AND pe.Field NOT IN (SELECT Value FROM @Cols)
GROUP BY pe.Field

SELECT @sql = 
      @sql + ',
ISNULL((SELECT TOP 1 pe.Data FROM dbo.PeopleExtra pe WHERE pe.PeopleId = p.PeopleId AND pe.Field = ''' +  CAST(Field as nvarchar(100)) + '''),'''') [' + CAST(Field AS nvarchar(100)) + ']'
      FROM dbo.PeopleExtra pe 
JOIN dbo.People p ON pe.PeopleId = p.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = @tagid AND tp.PeopleId = p.PeopleId)
AND pe.Data IS NOT NULL
AND pe.Field NOT IN (SELECT Value FROM @Cols)
GROUP BY pe.Field

SELECT @sql = 
      @sql + ',
ISNULL((SELECT TOP 1 CONVERT(nvarchar, pe.DateValue, 111) FROM dbo.PeopleExtra pe WHERE pe.PeopleId = p.PeopleId AND pe.Field = ''' +  CAST(Field as nvarchar(100)) + '''),'''') [' + CAST(Field AS nvarchar(100)) + ']'
            FROM dbo.PeopleExtra pe 
JOIN dbo.People p ON pe.PeopleId = p.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = @tagid AND tp.PeopleId = p.PeopleId)
AND pe.DateValue IS NOT NULL
AND pe.Field NOT IN (SELECT Value FROM @Cols)
GROUP BY pe.Field

SELECT @sql = 
      @sql + ',
ISNULL((SELECT TOP 1 CONVERT(nvarchar, pe.IntValue) FROM dbo.PeopleExtra pe WHERE pe.PeopleId = p.PeopleId AND pe.Field = ''' +  CAST(Field as nvarchar(100)) + '''),'''') [' + CAST(Field AS nvarchar(100)) + ']'
      FROM dbo.PeopleExtra pe 
JOIN dbo.People p ON pe.PeopleId = p.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = @tagid AND tp.PeopleId = p.PeopleId)
AND pe.IntValue IS NOT NULL
AND pe.Field NOT IN (SELECT Value FROM @Cols)
GROUP BY pe.Field

SELECT @sql = 
      @sql + ',
ISNULL((SELECT TOP 1 CONVERT(nvarchar, pe.BitValue) FROM dbo.PeopleExtra pe WHERE pe.PeopleId = p.PeopleId AND pe.Field = ''' +  CAST(Field as nvarchar(100)) + '''),'''') [' + CAST(Field AS nvarchar(100)) + ']'
      FROM dbo.PeopleExtra pe 
JOIN dbo.People p ON pe.PeopleId = p.PeopleId
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = @tagid AND tp.PeopleId = p.PeopleId)
AND pe.BitValue IS NOT NULL
AND pe.Field NOT IN (SELECT Value FROM @Cols)
GROUP BY pe.Field

SELECT @sql = @sql + '
FROM dbo.People p
WHERE EXISTS(SELECT NULL FROM dbo.TagPerson tp WHERE tp.Id = ' + CONVERT(nvarchar(100), @tagid) + ' AND tp.PeopleId = p.PeopleId)
GROUP By p.PeopleId) tt'

IF LEN(@sort) > 0 
	SELECT @sql = @sql + '
	ORDER BY CASE
				WHEN IsNumeric(' + @sort + ') = 1 THEN Replicate(Char(0), 100 - Len(' + @sort + ')) + ' + @sort + '
			    ELSE ' + @sort + '
		      END'PRINT @sql;

EXECUTE (@sql)

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAbsentsSP]'
GO
CREATE PROCEDURE [dbo].[RecentAbsentsSP](@orgid INT, @divid INT, @days INT)
AS
BEGIN
	SELECT
		o.OrganizationId,
		o.OrganizationName,
		o.LeaderName,
		consecutive, 
		om.PeopleId,
		p.Name2,
		p.HomePhone,
		p.CellPhone,
		p.EmailAddress,
			(SELECT MAX(Attend.MeetingDate) 
			 FROM dbo.Attend
			 JOIN dbo.Meetings mm ON dbo.Attend.MeetingId = mm.MeetingId
			 WHERE mm.OrganizationId = o.OrganizationId 
			 AND AttendanceFlag = 1 
			 AND mm.MeetingDate > DATEADD(d, -@days, GETDATE()) 
			 AND mm.MeetingDate < GETDATE())
		lastmeeting,
			(SELECT MAX(mm.MeetingDate)
			FROM Attend 
			JOIN dbo.Meetings mm ON dbo.Attend.MeetingId = mm.MeetingId
			WHERE AttendanceFlag = 1 
			AND mm.OrganizationId = o.OrganizationId
			AND Attend.PeopleId = om.PeopleId)
		lastattend,
		ISNULL(o.ConsecutiveAbsentsThreshold, 2) ConsecutiveAbsentsThreshold
	FROM 
		(SELECT 
			OrganizationId, 
			PeopleId, 
			COUNT(*) consecutive
		 FROM dbo.Attend a
		 WHERE MeetingDate > (SELECT MAX(MeetingDate)
							  FROM Attend 
							  WHERE AttendanceFlag = 1 
							  AND a.OrganizationId = OrganizationId
							  AND a.PeopleId = PeopleId
							  GROUP BY OrganizationId, PeopleId)
		 GROUP BY OrganizationId, PeopleId
	    ) tt1
	JOIN OrganizationMembers om ON tt1.OrganizationId = om.OrganizationId AND tt1.PeopleId = om.PeopleId
	JOIN dbo.People p ON om.PeopleId = p.PeopleId
	JOIN Organizations o ON om.OrganizationId = o.OrganizationId
	JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
	JOIN lookup.AttendType at ON at.Id = mt.AttendanceTypeId
	where (o.OrganizationId = @orgid OR @orgid IS NULL)
	AND consecutive >= ISNULL(o.ConsecutiveAbsentsThreshold, 2)
	AND at.Id NOT IN (70, 100) --inservice and homebound
	AND om.MemberTypeId != 230 --inactive
	AND (@divid IS NULL 
		OR EXISTS(SELECT NULL 
					FROM dbo.DivOrg 
					WHERE OrgId = o.OrganizationId AND DivId = @divid))
	ORDER BY o.OrganizationName, o.OrganizationId, consecutive, p.Name2
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ConsecutiveAbsents]'
GO
CREATE FUNCTION [dbo].[ConsecutiveAbsents](@orgid INT, @divid INT, @days INT)
RETURNS TABLE
AS
RETURN
(
	WITH LastAbsents AS
	(
	  SELECT OrganizationId, PeopleId, MAX(MeetingDate) ld
	  FROM Attend
	  WHERE AttendanceFlag = 1
	  GROUP BY OrganizationId, PeopleId
	)
	SELECT a.OrganizationId, a.PeopleId, count(*) As consecutive,
			(SELECT MAX(MeetingDate) 
			 FROM dbo.Attend aa 
			 WHERE aa.PeopleId = a.PeopleId  
			 AND aa.OrganizationId = a.OrganizationId 
			 AND aa.AttendanceFlag = 1) 
		lastattend
	FROM dbo.Attend a
	JOIN LastAbsents la 
				ON la.OrganizationId = a.OrganizationId 
				AND la.PeopleId = a.PeopleId
				AND a.MeetingDate > la.ld
			where (a.OrganizationId = @orgid OR @orgid IS NULL)
			AND (@divid IS NULL 
				OR EXISTS(SELECT NULL 
							FROM dbo.DivOrg 
							WHERE OrgId = a.OrganizationId AND DivId = @divid))
	group by a.OrganizationId, a.PeopleId
)
/*
	SELECT 
		tt.OrganizationId, 
		--o.OrganizationName, 
		--o.LeaderName, 
		consecutive,
		tt.PeopleId,
		--p.Name2,
		--p.HomePhone,
		--p.CellPhone,
		--p.EmailAddress,
			(SELECT MAX(MeetingDate) 
			 FROM dbo.Attend aa 
			 WHERE aa.PeopleId = tt.PeopleId  
			 AND aa.OrganizationId = tt.OrganizationId 
			 AND aa.AttendanceFlag = 1) 
		lastattend
		--lastmeeting,
		--m.MeetingId,
		--ConsecutiveAbsentsThreshold
	FROM
	(
	SELECT a.OrganizationId, a.PeopleId, count(*) As consecutive
	FROM dbo.Attend a
	JOIN LastAbsents la 
				ON la.OrganizationId = a.OrganizationId 
				AND la.PeopleId = a.PeopleId
				AND a.MeetingDate > la.ld
	group by a.OrganizationId, a.PeopleId
	) tt
	JOIN dbo.Organizations o ON tt.OrganizationId = o.OrganizationId
	JOIN dbo.Meetings m ON tt.OrganizationId = m.OrganizationId 
		AND m.MeetingDate = ( SELECT MAX(a.MeetingDate) FROM dbo.Attend a
							  JOIN dbo.Meetings mm ON mm.MeetingId = a.MeetingId
							  WHERE mm.OrganizationId = tt.OrganizationId
							  AND a.AttendanceFlag = 1 
							  AND mm.MeetingDate > DATEADD(d, -@days, GETDATE()) 
							  AND mm.MeetingDate < GETDATE()
							)
	JOIN OrganizationMembers om ON om.PeopleId = tt.PeopleId AND om.OrganizationId = o.OrganizationId
	JOIN dbo.People p ON tt.PeopleId = p.PeopleId
	JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
	JOIN lookup.AttendType at ON at.Id = mt.AttendanceTypeId
	WHERE consecutive > ISNULL(ConsecutiveAbsentsThreshold, 2)
	AND m.MeetingDate IS NOT NULL
	AND at.Id NOT IN (70, 100) --inservice and homebound
	AND om.MemberTypeId != 230 --inactive
			AND (tt.OrganizationId = @orgid OR @orgid IS NULL)
			AND (@divid IS NULL 
				OR EXISTS(SELECT NULL 
							FROM dbo.DivOrg 
							WHERE OrgId = tt.OrganizationId AND DivId = @divid))
*/	
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ActivityAll]'
GO

CREATE VIEW [dbo].[ActivityAll]
	AS
	SELECT Machine, ActivityDate, ISNULL(u.Name, '') Name, ISNULL(g.UserId, 0) UserId, g.Activity FROM dbo.ActivityLog g
	LEFT JOIN dbo.Users u ON g.UserId = u.UserId
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Duplicate]'
GO
CREATE TABLE [dbo].[Duplicate]
(
[id1] [int] NOT NULL,
[id2] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Duplicate] on [dbo].[Duplicate]'
GO
ALTER TABLE [dbo].[Duplicate] ADD CONSTRAINT [PK_Duplicate] PRIMARY KEY CLUSTERED  ([id1], [id2])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[InsertDuplicate]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertDuplicate](@i1 INT, @i2 INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF NOT EXISTS(SELECT NULL FROM dbo.Duplicate WHERE (id1 = @i1 AND id2 = @i2) OR (id1 = @i2 AND id2 = @i1))
		IF @i1 < @i2
			INSERT dbo.Duplicate
			        ( id1, id2 )
			VALUES  ( @i1, @i2 )
		ELSE
			INSERT dbo.Duplicate			
			        ( id1, id2 )
			VALUES  ( @i2, @i1 )
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MasterOrgs]'
GO

CREATE VIEW [dbo].[MasterOrgs]
AS

SELECT o.OrganizationId, PickListOrgId, o.OrganizationName FROM Organizations o 
CROSS APPLY ( SELECT CAST(value AS INT) PickListOrgId 
	FROM dbo.Split(o.OrgPickList, ',') ) T 
WHERE o.OrgPickList IS NOT NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendMeetingInfo]'
GO
CREATE PROCEDURE [dbo].[AttendMeetingInfo]
( @MeetingId INT, @PeopleId INT)
AS
BEGIN
	DECLARE @orgid INT
			,@meetingdate DATETIME
			,@meetdt DATE
			,@tm TIME
			,@dt DATETIME
			,@regularhour BIT
			,@membertypeid INT
			,@attendedelsewhere INT
			,@allowoverlap BIT

	SELECT @regularhour = CASE WHEN EXISTS(
		SELECT null
			FROM dbo.Meetings m
			JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
			WHERE m.MeetingId = @MeetingId
				AND EXISTS(SELECT NULL FROM dbo.OrgSchedule
							WHERE OrganizationId = o.OrganizationId
							AND SchedDay IN (DATEPART(weekday, m.MeetingDate)-1, 10)
							AND CONVERT(TIME, m.MeetingDate) = CONVERT(TIME, MeetingTime)))
		THEN 1 ELSE 0 END

	SELECT
		@orgid = o.OrganizationId,
		@dt = DATEADD(DAY, o.RollSheetVisitorWks * -7, m.MeetingDate),
		@meetingdate = m.MeetingDate,
		@allowoverlap = o.AllowAttendOverlap,
		@membertypeid = dbo.MemberTypeAsOf(o.OrganizationId, @PeopleId, m.MeetingDate)
	FROM dbo.Meetings m
	JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
	WHERE m.MeetingId = @MeetingId

	DECLARE @name nvarchar(50), @bfclassid INT

	SELECT @name = p.[Name], @bfclassid = BibleFellowshipClassId
	FROM dbo.People p
	WHERE PeopleId = @PeopleId

	SELECT
		@meetdt = CONVERT(DATE, m.MeetingDate),
		@tm = CONVERT(TIME, m.MeetingDate)
	FROM dbo.Meetings m
	WHERE m.MeetingId = @MeetingId
		
	IF @dt IS NULL
		SELECT @dt = DATEADD(DAY, 3 * -7, @meetdt)

	DECLARE	@isrecentvisitor BIT
			,@isoffsite BIT
			,@otherattend INT
			,@bfcattend INT
			,@bfcid INT
			--,@isinservice BIT
			--,@issamehour bit

	SELECT @isrecentvisitor = CASE WHEN exists(
				SELECT NULL FROM Attend
				WHERE PeopleId = @PeopleId
				AND AttendanceFlag = 1
				AND MeetingDate >= @dt
				AND MeetingDate <= @meetdt
				AND OrganizationId = @orgid
				AND AttendanceTypeId IN (50, 60)) -- new and recent
			THEN 1 ELSE 0 END

	--SELECT @isinservice = CASE WHEN exists(
	--			SELECT NULL FROM dbo.OrganizationMembers om
	--			JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	--			WHERE om.PeopleId = @PeopleId
	--			AND om.OrganizationId <> @orgid
	--			AND om.MemberTypeId = 500 -- inservice member
	--			AND o.ScheduleId = @schedid)
	--		THEN 1 ELSE 0 END
			
	SELECT @isoffsite = CASE WHEN exists(
				SELECT NULL FROM dbo.OrganizationMembers om
				JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
				WHERE om.PeopleId = @PeopleId
				AND om.OrganizationId <> @orgid
				AND o.Offsite = 1
				AND o.FirstMeetingDate <= @meetdt
				AND @meetdt <= o.LastMeetingDate)
			THEN 1 ELSE 0 END

	SELECT TOP 1 @otherattend = ae.AttendId
	FROM Attend ae
	JOIN dbo.Organizations o ON ae.OrganizationId = o.OrganizationId
	WHERE ae.PeopleId = @PeopleId
	AND ae.MeetingDate = @meetingdate
	AND ae.OrganizationId <> @orgid
	
	-- BFC class membership
	SELECT TOP 1 @bfcid = om.OrganizationId FROM dbo.OrganizationMembers om
	JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	WHERE om.PeopleId = @PeopleId 
	AND om.OrganizationId <> @orgid
	AND @regularhour = 1
	AND EXISTS(SELECT NULL FROM dbo.OrgSchedule
				WHERE OrganizationId = o.OrganizationId
				AND SchedDay IN (DATEPART(weekday, @meetingdate)-1, 10)
				AND CONVERT(TIME, @meetingdate) = CONVERT(TIME, MeetingTime))
	--AND (om.OrganizationId = @bfclassid OR om.MemberTypeId = 500) -- regular or InSvc

	-- BFC Attendance at same time
	SELECT TOP 1 @bfcattend = a.AttendId FROM dbo.Attend a
	JOIN dbo.OrganizationMembers om ON a.OrganizationId = om.OrganizationId AND a.PeopleId = om.PeopleId
	JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	WHERE a.MeetingDate = @meetingdate
	AND @regularhour = 1
	AND EXISTS(SELECT NULL FROM dbo.OrgSchedule
				WHERE OrganizationId = o.OrganizationId
				AND SchedDay IN (DATEPART(weekday, @meetingdate)-1, 10)
				AND CONVERT(TIME, @meetingdate) = CONVERT(TIME, MeetingTime))
	AND om.OrganizationId <> @orgid
	AND om.OrganizationId = @bfcid
	AND a.PeopleId = @PeopleId

	-- attended elsewhere at same time
	SELECT TOP 1 @attendedelsewhere = ae.AttendId
	FROM Attend ae
	JOIN dbo.Organizations o ON ae.OrganizationId = o.OrganizationId
	WHERE ae.PeopleId = @PeopleId
	AND ae.AttendanceFlag = 1
	AND ae.MeetingDate = @meetingdate
	AND ae.OrganizationId <> @orgid
	AND o.AllowAttendOverlap <> 1
	AND @allowoverlap <> 1

-- The returned records:
			
	SELECT
		 @attendedelsewhere AttendedElsewhere
		,@membertypeid MemberTypeId
		,@isoffsite IsOffSite
		,@isrecentvisitor IsRecentVisitor
		,@name Name
		,@bfclassid BFClassId
	
	-- Attend if any
	SELECT * FROM dbo.Attend
	WHERE MeetingId = @MeetingId AND PeopleId = @PeopleId
		
	-- the meeting
	SELECT * FROM dbo.Meetings
	WHERE MeetingId = @MeetingId
	
	-- Related VIP Attendance
	SELECT v.*
	FROM Attend v
	JOIN dbo.OrganizationMembers om ON v.OrganizationId = om.OrganizationId AND v.PeopleId = om.PeopleId
	WHERE v.PeopleId = @PeopleId
	AND v.MeetingDate = @meetingdate
	AND v.OrganizationId <> @orgid
	AND om.MemberTypeId = 700 -- vip
	AND @orgid = @bfclassid
	
	-- BFC class membership 
	SELECT * FROM dbo.OrganizationMembers
	WHERE OrganizationId = @bfcid
	AND PeopleId = @PeopleId
	
	-- BFC Attendance at same time
	SELECT * FROM dbo.Attend
	WHERE AttendId = @bfcattend

	-- BFC Meeting at same time
	SELECT m.* FROM dbo.Meetings m
	JOIN dbo.Attend a ON m.MeetingId = a.MeetingId
	WHERE AttendId = @bfcattend
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PickListOrgs2]'
GO




CREATE VIEW [dbo].[PickListOrgs2]
AS

SELECT o.OrganizationId, OrgId FROM Organizations o 
CROSS APPLY ( SELECT CAST(value AS INT) OrgId 
	FROM dbo.Split(o.OrgPickList, ',') ) T 
WHERE o.OrgPickList IS NOT NULL


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FindPerson4]'
GO
CREATE FUNCTION [dbo].[FindPerson4]
(
	@PeopleId1 INT
)
RETURNS @t TABLE ( PeopleId INT)
AS
BEGIN
	
	DECLARE @first nvarchar(30), 
			@last nvarchar(50), 
			@m INT, @d INT, @y INT, 
			@email nvarchar(100), 
			@email2 nvarchar(60), 
			@phone1 nvarchar(20),
			@phone2 nvarchar(20),
			@phone3 nvarchar(20),
			@familyid INT
			
	SELECT 
		@first = PreferredName,
		@last = LastName,
		@m = BirthMonth,
		@d = BirthDay,
		@y = BirthYear,
		@email = dbo.SpaceToNull(EmailAddress),
		@email2 = dbo.SpaceToNull(EmailAddress2),
		@phone1 = dbo.SpaceToNull(CellPhone),
		@phone2 = dbo.SpaceToNull(WorkPhone),
		@phone3 = dbo.SpaceToNull(HomePhone),
		@familyid = FamilyId
		
	FROM dbo.People
	WHERE PeopleId = @PeopleId1
	
	DECLARE @fname nvarchar(50) = REPLACE(@first,' ', '')
	
	INSERT INTO @t SELECT PeopleId FROM dbo.People p
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	WHERE
	(
		@email IS NOT NULL
		OR @email2 IS NOT NULL
		OR @phone1 IS NOT NULL
		OR @phone2 IS NOT NULL
		OR @phone3 IS NOT NULL
		OR (@m IS NOT NULL AND @d IS NOT NULL AND @y IS NOT NULL)
	)
	AND PeopleId <> @PeopleId1
	AND
	(
		FirstName2 LIKE (@fname + '%')
		OR @fname LIKE (FirstName + '%')
		OR @fname = NickName
		OR @fname IS NULL
	)
	AND (@last = LastName OR @last = MaidenName OR @last = MiddleName)
	AND
	(
		p.EmailAddress = @email
		OR p.EmailAddress = @email2
		OR p.EmailAddress2 = @email
		OR p.EmailAddress2 = @email2
		OR CellPhone = @phone1
		OR WorkPhone = @phone1
		OR CellPhone = @phone2
		OR WorkPhone = @phone2
		OR CellPhone = @phone3
		OR WorkPhone = @phone3
		OR (BirthDay = @d AND BirthMonth = @m AND BirthYear = @y)
		OR 
		( p.FamilyId <> @familyid
		  AND
		  ( f.HomePhone = @phone1		
			OR f.HomePhone = @phone2				
			OR f.HomePhone = @phone3				
		  )
		)
	)
	AND
	(
		@d IS NULL OR BirthDay IS NULL
		OR (BirthDay = @d AND BirthMonth = @m AND ABS(BirthYear - @y) <= 1)
	)
		
    RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllAttendStrAllOrgs]'
GO

CREATE PROCEDURE [dbo].[UpdateAllAttendStrAllOrgs]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
		DECLARE curorg CURSOR FOR 
		SELECT OrganizationId
		FROM dbo.Organizations
		OPEN curorg
		DECLARE @oid INT
		FETCH NEXT FROM curorg INTO @oid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.UpdateAllAttendStr @oid
			FETCH NEXT FROM curorg INTO @oid
		END
		CLOSE curorg
		DEALLOCATE curorg
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecordAttendance]'
GO
CREATE PROCEDURE [dbo].[RecordAttendance]
( @orgId INT, @peopleId INT, @meetingDate DateTime, @present BIT, @location nvarchar(50), @userid INT )
AS
BEGIN
-- Check to see if meeting exists and create it if not
-- Do this outside the transaction scope to prevent deadlocks
	DECLARE  @MeetingId INT
	SELECT TOP 1 @MeetingId = MeetingId FROM dbo.Meetings
	WHERE OrganizationId = @OrgId
	AND MeetingDate = @MeetingDate
	IF (@MeetingId IS NULL)
	BEGIN
		DECLARE	@acr INT
		SELECT @acr = AttendCreditId 
		FROM dbo.OrgSchedule
		WHERE OrganizationId = @OrgId
		AND SchedDay = (DATEPART(weekday, @MeetingDate)-1)
		AND CONVERT(TIME, @MeetingDate) = CONVERT(TIME, SchedTime)
		INSERT INTO dbo.Meetings
		        ( CreatedBy, CreatedDate , OrganizationId , MeetingDate , AttendCreditId, Location )
		VALUES  ( @userid, GETDATE(), @OrgId, @MeetingDate , @acr, @location )
		SET @MeetingId = SCOPE_IDENTITY()
	END

-- now we know the meeting exists
	EXEC dbo.RecordAttend @MeetingId, @peopleid, @present
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTotalContributions3]'
GO
CREATE FUNCTION [dbo].[GetTotalContributions3]
(
	@fd DATETIME, 
	@td DATETIME,
	@campusid INT,
	@nontaxded BIT,
	@includeUnclosed BIT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT tt.*, 
	(SELECT TOP 1 OrganizationName from dbo.Organizations o WHERE o.OrganizationId = p.BibleFellowshipClassId) MainFellowship,
	(SELECT TOP 1 Description FROM lookup.MemberStatus ms WHERE p.MemberStatusId = ms.Id) MemberStatus
	FROM
	(
	SELECT 
		CreditGiverId, 
		(HeadName + CASE WHEN SpouseId <> CreditGiverId THEN '*' ELSE '' END) HeadName, 
		(SpouseName + CASE WHEN SpouseId = CreditGiverId THEN '*' ELSE '' END) SpouseName, 
		COUNT(*) AS [Count], 
		SUM(Amount) AS Amount, 
		SUM(PledgeAmount) AS PledgeAmount, 
		c2.FundId, 
		FundName
	FROM dbo.Contributions2(@fd, @td, @campusid, NULL, @nontaxded, @includeUnclosed) c2
	GROUP BY CreditGiverId, HeadName, SpouseId, SpouseName, SpouseId, c2.FundId, FundName
	) tt 
	JOIN dbo.People p ON p.PeopleId = tt.CreditGiverId
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionCount]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ContributionCount](@pid INT, @days INT, @fundid INT)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @cnt int

	-- Add the T-SQL statements to compute the return value here
	DECLARE @mindt DATETIME = DATEADD(D, -@days, GETDATE())
	DECLARE @option INT
	DECLARE @spouse INT
	SELECT	@option = ISNULL(ContributionOptionsId,1), 
			@spouse = SpouseId
	FROM dbo.People 
	WHERE PeopleId = @pid
	
	IF (@option = 2)
		SELECT @cnt = COUNT(*)
		FROM dbo.Contribution c
		WHERE 
		c.ContributionDate >= @mindt
		AND (c.FundId = @fundid OR @fundid IS NULL)
		AND c.ContributionStatusId = 0 --Recorded
		AND c.ContributionTypeId NOT IN (6,7,8) --Reversed or returned
		AND c.PeopleId IN (@spouse, @pid)
	else
		SELECT @cnt = COUNT(*)
		FROM dbo.Contribution c
		WHERE 
		c.ContributionDate >= @mindt
		AND (c.FundId = @fundid OR @fundid IS NULL)
		AND c.ContributionStatusId = 0 --Recorded
		AND c.ContributionTypeId NOT IN (6,7,8) --Reversed or returned
		AND c.PeopleId = @pid
	
/*	AND ((@option <> 2 AND c.PeopleId = @pid)
		 OR (@option = 2 AND c.PeopleId IN (@pid, @spouse))) */

	-- Return the result of the function
	RETURN @cnt

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Ministries]'
GO
CREATE TABLE [dbo].[Ministries]
(
[MinistryId] [int] NOT NULL IDENTITY(1, 1),
[MinistryName] [nvarchar] (50) NULL,
[CreatedBy] [int] NULL,
[CreatedDate] [datetime] NULL,
[ModifiedBy] [int] NULL,
[ModifiedDate] [datetime] NULL,
[RecordStatus] [bit] NULL,
[DepartmentId] [int] NULL,
[MinistryDescription] [nvarchar] (512) NULL,
[MinistryContactId] [int] NULL,
[ChurchId] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MINISTRIES_TBL] on [dbo].[Ministries]'
GO
ALTER TABLE [dbo].[Ministries] ADD CONSTRAINT [PK_MINISTRIES_TBL] PRIMARY KEY CLUSTERED  ([MinistryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [MINISTRIES_PK_IX] on [dbo].[Ministries]'
GO
CREATE NONCLUSTERED INDEX [MINISTRIES_PK_IX] ON [dbo].[Ministries] ([MinistryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContactSummary]'
GO
CREATE FUNCTION [dbo].[ContactSummary](@dt1 DATETIME, @dt2 DATETIME, @min INT, @type INT, @reas INT)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		COUNT(*) [Count] 
		, ContactType
		, ReasonType
		, Ministry
		, Comments
		, ContactDate
		, Contactor
	FROM
	(
		SELECT 
			t.Description ContactType
			, r.Description ReasonType
			, m.MinistryName Ministry
			, CASE WHEN LEN(c.Comments) > 0 THEN '' ELSE 'No Comments' END Comments
			, CASE WHEN c.ContactDate IS NOT NULL THEN '' ELSE 'No Date' END ContactDate
			, CASE WHEN (SELECT COUNT(*) FROM dbo.Contactors) > 0 THEN '' ELSE 'No Contactor' END Contactor
		FROM dbo.Contact c
		left JOIN lookup.ContactType t ON c.ContactTypeId = t.Id
		left JOIN lookup.ContactReason r ON c.ContactReasonId = r.Id
		LEFT JOIN dbo.Ministries m ON c.MinistryId = m.MinistryId
		WHERE (@dt1 IS NULL OR c.ContactDate >= @dt1)
		AND (@dt2 IS NULL OR c.ContactDate <= @dt2)
		AND (@min = 0 OR @min = c.MinistryId)
		AND (@type = 0 OR @type = c.ContactTypeId)
		AND (@reas = 0 OR @reas = c.ContactReasonId)
	) tt
	GROUP BY  ContactType, ReasonType, Ministry, Comments, ContactDate, Contactor
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendItem]'
GO
CREATE FUNCTION [dbo].[AttendItem] (@pid INT, @n INT)
RETURNS DATETIME
AS
	BEGIN
	DECLARE @dt DATETIME
	
	IF (SELECT COUNT(*) FROM dbo.Attend WHERE PeopleId = @pid) < @n
		RETURN NULL
	
	SELECT @dt = MeetingDate
	FROM
	(
		SELECT MeetingDate, ROW_NUMBER() OVER(ORDER BY MeetingDate) AS SeqNo
        FROM
        (
			SELECT DISTINCT TOP(@n) CAST(MeetingDate AS DATE) MeetingDate
			FROM Attend a
	        WHERE PeopleId = @pid AND AttendanceFlag = 1
	        ORDER BY MeetingDate
        ) tt
     ) yy
     WHERE SeqNo = @n

	
	RETURN @dt
	END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionAmount]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ContributionAmount](@pid INT, @days INT, @fundid INT)
RETURNS MONEY
AS
BEGIN
	-- Declare the return variable here
	DECLARE @amt MONEY

	-- Add the T-SQL statements to compute the return value here
	DECLARE @mindt DATETIME = DATEADD(D, -@days, GETDATE())
	DECLARE @option INT
	DECLARE @spouse INT
	SELECT	@option = ISNULL(ContributionOptionsId,1), 
			@spouse = SpouseId
	FROM dbo.People 
	WHERE PeopleId = @pid
	
	SELECT @amt = SUM(c.ContributionAmount)
	FROM dbo.Contribution c
	WHERE 
	c.ContributionDate >= @mindt
	AND (c.FundId = @fundid OR @fundid IS NULL)
	AND c.ContributionStatusId = 0 --Recorded
	AND c.ContributionTypeId NOT IN (6,7,9) --Reversed or returned
	AND ((@option <> 2 AND c.PeopleId = @pid)
		 OR (@option = 2 AND c.PeopleId IN (@pid, @spouse)))

	-- Return the result of the function
	RETURN @amt

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AvgSunAttendance]'
GO
CREATE FUNCTION [dbo].[AvgSunAttendance]()
RETURNS int
AS
	BEGIN
	
	DECLARE @a INT
	
	SELECT @a = AVG(cnt)
	FROM
		(
		SELECT dbo.SundayForDate(MeetingDate) sun, SUM(NumPresent) cnt 
		FROM Meetings
		WHERE DATEPART(dw, MeetingDate) = 1 and MeetingDate > DATEADD(d, -365, GETDATE())
		GROUP BY dbo.SundayForDate(MeetingDate)
	) tt	

	RETURN @a
	
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastActive]'
GO
CREATE FUNCTION [dbo].[LastActive] (@uid INT)
RETURNS DATETIME
AS
	BEGIN
	DECLARE @dt DATETIME
		SELECT @dt = MAX(a.ActivityDate) 
		FROM dbo.ActivityLog a
		WHERE @uid = a.UserId
	RETURN @dt
	END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GetTodaysMeetingHours3]'
GO
CREATE FUNCTION [dbo].[GetTodaysMeetingHours3]
    (
      @thisday INT
    )
RETURNS @ta TABLE ( [hour] DATETIME, OrganizationId INT)
AS 
    BEGIN
        DECLARE 
            @prevMidnight DATETIME,
            @ninetyMinutesAgo DATETIME,
            @nextMidnight DATETIME
            
        DECLARE @dt DATETIME = GETDATE()
		DECLARE @d DATETIME = DATEADD(dd, 0, DATEDIFF(dd, 0, @dt))
		DECLARE @t DATETIME = @dt - @d
		DECLARE @simulatedTime DATETIME

        IF @thisday IS NULL
			SELECT @thisday = DATEPART(dw, GETDATE()) - 1
			
		DECLARE @plusdays INT = @thisday - (DATEPART(dw, GETDATE())-1) + 7
		IF @plusdays > 6
			SELECT @plusdays = @plusdays - 7
		SELECT @prevMidnight = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays
        SELECT @nextMidnight = @prevMidnight + 1
		SELECT @simulatedTime = @prevMidnight + @t
        SELECT @ninetyMinutesAgo = DATEADD(mi, -90, @simulatedTime)
        
        DECLARE @defaultPrevMidnight DATETIME = dateadd(dd,0, datediff(dd,0,GETDATE())) + @plusdays

		INSERT INTO @ta 
			SELECT dbo.GetTodaysMeetingHour(@thisday, MeetingTime, SchedDay), o.OrganizationId 
			FROM dbo.OrgSchedule os
			JOIN dbo.Organizations o ON os.OrganizationId = o.OrganizationId
			WHERE dbo.GetTodaysMeetingHour(@thisday, MeetingTime, SchedDay) IS NOT NULL
			AND ISNULL(o.NotWeekly, 0) = 0
			ORDER BY Id
        
		INSERT INTO @ta 
			SELECT MeetingDate, OrganizationId
			FROM dbo.Meetings m
			WHERE MeetingDate NOT IN (SELECT hour FROM @ta t WHERE t.OrganizationId = m.OrganizationId)
			AND MeetingDate >= @prevMidnight
			AND MeetingDate < @nextMidnight
			ORDER BY MeetingDate
			
		RETURN

    END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FetchCreateFund]'
GO
CREATE PROCEDURE [dbo].[FetchCreateFund]
    (
      @name nvarchar(256)
    )
AS
BEGIN
	DECLARE @fid INT
	
	SELECT @fid = FundId
	FROM dbo.ContributionFund
	WHERE FundName = @name
	
	IF (@fid IS NULL)
	BEGIN
		SELECT @fid = MAX(FundId) + 1 FROM dbo.ContributionFund
		INSERT INTO dbo.ContributionFund
		        ( FundId,
		          CreatedBy ,
		          CreatedDate ,
		          FundName ,
		          FundDescription ,
		          FundStatusId ,
		          FundTypeId ,
		          FundPledgeFlag 
		        )
		VALUES  ( @fid,
		          1 , -- CreatedBy - int
		          GETDATE() , -- CreatedDate - datetime
		          @name , -- FundName - nvarchar(256)
		          @name , -- FundDescription - nvarchar(256)
		          1 , -- FundStatusId - int
		          1 , -- FundTypeId - int
		          0  -- FundPledgeFlag - bit
		        )
	END
	RETURN @fid
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[Gender]'
GO
CREATE TABLE [lookup].[Gender]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Gender] on [lookup].[Gender]'
GO
ALTER TABLE [lookup].[Gender] ADD CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CheckinFamilyMembers]'
GO
CREATE FUNCTION [dbo].[CheckinFamilyMembers] ( @familyid INT, @campus INT, @thisday INT )
RETURNS 
@t TABLE 
(
	Id INT, 
	[Position] INT,
	MemberVisitor CHAR,
	[Name] VARCHAR(150),
	[First] VARCHAR(50),
	PreferredName VARCHAR(50),
	[Last] VARCHAR(100)
	,BYear INT
	,BMon INT
	,BDay INT
	,Class VARCHAR(100)
	,Leader VARCHAR(100)
	,OrgId INT
	,Location VARCHAR(200)
	,Age INT
	,Gender VARCHAR(10)
	,NumLabels INT
	,[hour] DATETIME
	,CheckedIn BIT
	,goesby VARCHAR(50)
	,email VARCHAR(150)
	,addr VARCHAR(100)
	,zip VARCHAR(15)
	,home VARCHAR(20)
	,cell VARCHAR(20)
	,marital INT
	,genderid INT
	,CampusId INT
	,allergies VARCHAR(1000)
	,emfriend VARCHAR(100)
	,emphone VARCHAR(100)
	,activeother BIT
	,parent VARCHAR(100)
	,grade INT
	,HasPicture BIT
	,Custody BIT
	,Transport BIT
	,RequiresSecurityLabel BIT
	,church VARCHAR(130)
)
AS
BEGIN
	----------------
	--Family Members
	----------------
	DECLARE @pids TABLE (pid INT)
	INSERT INTO @pids
	SELECT PeopleId FROM dbo.People p
	WHERE p.DeceasedDate IS NULL
	AND (p.FamilyId = @familyid)
		OR (EXISTS( SELECT NULL 
					FROM dbo.PeopleExtra e 
					JOIN dbo.People hh ON e.PeopleId = p.PeopleId AND e.Field = 'Parent' 
					WHERE hh.FamilyId = @familyid
					AND e.IntValue = hh.PeopleId)
			AND EXISTS(SELECT NULL FROM dbo.Setting WHERE Id = 'ShowChildInExtraValueParentFamily' AND Setting = 'true'))
			
	---------
	--Members
	---------
	INSERT @t SELECT
		om.PeopleId
		,p.PositionInFamilyId 
		,'M'
		,p.Name
		,p.FirstName
		,p.PreferredName
		,p.LastName
		,p.BirthYear
		,p.BirthMonth
		,p.BirthDay
		,o.OrganizationName
		,o.LeaderName
		,om.OrganizationId
		,o.Location
		,ISNULL(p.Age, 0)
		,g.Code
		,CASE WHEN om.MemberTypeId IN (220, 230) 
				THEN ISNULL(o.NumCheckInLabels, 1) 
				ELSE ISNULL(o.NumWorkerCheckInLabels, 0) 
		 END
		,mh.[hour]
		,CASE WHEN EXISTS(SELECT NULL 
							FROM dbo.Attend aa
							JOIN dbo.Meetings mm ON aa.MeetingId = mm.MeetingId
							WHERE aa.PeopleId = om.PeopleId
							AND mm.OrganizationId = om.OrganizationId
							AND mm.MeetingDate = mh.[hour]
							AND aa.AttendanceFlag = 1) 
			   THEN 1 ELSE 0 
		 END
		,p.NickName
		,p.EmailAddress
		,f.AddressLineOne
		,f.ZipCode
		,f.HomePhone
		,p.CellPhone
		,p.MaritalStatusId 
		,p.GenderId
		,p.CampusId
		,rr.MedicalDescription
		,rr.emcontact
		,rr.emphone
		,ISNULL(rr.ActiveInAnotherChurch, 0)
		,ISNULL(rr.mname, rr.fname)
		,p.Grade
		,CASE WHEN p.PictureId IS NULL THEN 0 ELSE 1 END
		,ISNULL(p.CustodyIssue, 0)
		,ISNULL(p.OkTransport, 0)
		,CASE WHEN om.MemberTypeId IN (220, 230) 
				AND ISNULL(p.Age,0) < 18 
				AND ISNULL(o.NoSecurityLabel, 0) = 0 
			THEN 1 ELSE 0 
		 END
		,p.OtherNewChurch
		 
	FROM dbo.OrganizationMembers om
	JOIN dbo.Organizations o ON om.OrganizationId = o.OrganizationId
	JOIN dbo.People p ON om.PeopleId = p.PeopleId AND om.OrganizationId = o.OrganizationId
	JOIN @pids ON pid = p.PeopleId
	JOIN dbo.Families f ON f.FamilyId = p.FamilyId
	LEFT JOIN dbo.RecReg rr ON p.PeopleId = rr.PeopleId
	JOIN lookup.Gender g ON p.GenderId = g.Id
	JOIN dbo.GetTodaysMeetingHours3(@thisday) mh ON mh.OrganizationId = o.OrganizationId
	WHERE ISNULL(o.CanSelfCheckin, 0) = 1
	AND isnull(om.Pending, 0) = 0 -- not pending
	AND om.MemberTypeId <> 311 -- not a prospect
	AND (o.CampusId = @campus OR @campus IS NULL OR @campus = 0)
	AND o.OrganizationStatusId = 30
			
	-----------------
	--Recent Visitors
	-----------------
	INSERT @t SELECT 
		 p.PeopleId 
		,p.PositionInFamilyId
		,'V'
		,p.Name
		,p.FirstName 
		,p.PreferredName
		,p.LastName
		,p.BirthYear
		,p.BirthMonth
		,p.BirthDay
		,o.OrganizationName
		,o.LeaderName
		,o.OrganizationId
		,o.Location
		,ISNULL(p.Age, 0)
		,g.Code
		, ISNULL(o.NumCheckInLabels, 1)
		,mh.[hour]
		,CASE WHEN EXISTS(SELECT NULL 
							FROM dbo.Attend aa
							JOIN dbo.Meetings mm ON mm.MeetingId = aa.MeetingId
							WHERE aa.PeopleId = p.PeopleId
							AND mm.OrganizationId = tt.OrganizationId
							AND aa.MeetingDate = mh.[hour]
							AND aa.AttendanceFlag = 1) 
			   THEN 1 ELSE 0 
		 END
		,p.NickName
		,p.EmailAddress
		,f.AddressLineOne
		,f.ZipCode
		,f.HomePhone
		,p.CellPhone
		,p.MaritalStatusId
		,p.GenderId
		,p.CampusId
		,rr.MedicalDescription
		,rr.emcontact
		,rr.emphone
		,ISNULL(rr.ActiveInAnotherChurch, 0)
		,ISNULL(rr.mname, rr.fname)
		,p.Grade
		,CASE WHEN p.PictureId IS NULL THEN 0 ELSE 1 END
		,ISNULL(p.CustodyIssue, 0)
		,ISNULL(p.OkTransport, 0)
		,CASE WHEN ISNULL(p.Age,0) < 18 AND ISNULL(o.NoSecurityLabel, 0) = 0 
			THEN 1 ELSE 0 
		 END
		,p.OtherNewChurch
	 
	FROM
	(
		SELECT
			a.PeopleId, m.OrganizationId
		FROM dbo.Attend a
		JOIN dbo.People p ON a.PeopleId = p.PeopleId
		JOIN @pids ON pid = p.PeopleId
		JOIN dbo.Meetings m ON m.MeetingId = a.MeetingId
		JOIN dbo.Organizations o ON m.OrganizationId = o.OrganizationId
		WHERE ISNULL(o.CanSelfCheckin, 0) = 1
		AND (o.AllowNonCampusCheckIn = 1 OR o.CampusId = @campus OR @campus IS NULL OR @campus = 0)
		AND o.OrganizationStatusId = 30
		AND a.AttendanceFlag = 1 
		AND (a.MeetingDate >= o.FirstMeetingDate OR o.FirstMeetingDate IS NULL)
		AND a.MeetingDate >= o.VisitorDate
		AND a.AttendanceTypeId IN (40,50,60)
		AND NOT EXISTS(SELECT NULL FROM dbo.OrganizationMembers om 
						WHERE om.PeopleId = a.PeopleId 
						AND om.OrganizationId = m.OrganizationId 
						AND om.MemberTypeId <> 311) --NOT a member, ok if Prospect
		GROUP BY a.PeopleId, m.OrganizationId
	) tt
	JOIN dbo.GetTodaysMeetingHours3(@thisday) mh ON tt.OrganizationId = mh.OrganizationId
	JOIN dbo.People p ON tt.PeopleId = p.PeopleId
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	JOIN dbo.Organizations o ON tt.OrganizationId = o.OrganizationId
	JOIN lookup.Gender g ON p.GenderId = g.Id
	LEFT JOIN dbo.RecReg rr ON rr.PeopleId = p.PeopleId
	
	
	-------------------------------
	-- AllowNonCampusCheckin Orgs
	-------------------------------

	DECLARE @visitorgs TABLE
	(
		VisitorOrgName VARCHAR(80),
		VisitorOrgId INT,
		VisitorOrgHour DATETIME
	)
	INSERT INTO @visitorgs 
	SELECT o.OrganizationName, o.OrganizationId, mh.[hour]
	FROM dbo.Organizations o
	JOIN dbo.GetTodaysMeetingHours3(@thisday) mh ON o.OrganizationId = mh.OrganizationId
	WHERE o.OrganizationStatusId = 30
	AND (o.CampusId = @campus OR @campus IS NULL OR @campus = 1)
	AND o.CanSelfCheckin = 1
	AND o.AllowNonCampusCheckIn = 1
	

	INSERT @t SELECT
		 p.PeopleId 
		,p.PositionInFamilyId
		,NULL --neither Member nor Visitor
		,p.Name
		,p.FirstName 
		,p.PreferredName
		,p.LastName
		,p.BirthYear
		,p.BirthMonth
		,p.BirthDay
		,vo.VisitorOrgName -- class
		,'' -- leader
		,vo.VisitorOrgId -- orgid
		,'' -- location
		,ISNULL(p.Age, 0)
		,g.Code -- Gender
		,0 -- number of checkin labels
		,NULL -- hour
		,0 -- CheckedIn
		,p.NickName
		,p.EmailAddress
		,f.AddressLineOne
		,f.ZipCode
		,f.HomePhone
		,p.CellPhone
		,p.MaritalStatusId
		,p.GenderId
		,p.CampusId
		,rr.MedicalDescription
		,rr.emcontact
		,rr.emphone
		,ISNULL(rr.ActiveInAnotherChurch, 0)
		,ISNULL(rr.mname, rr.fname)
		,p.Grade
		,CASE WHEN p.PictureId IS NULL THEN 0 ELSE 1 END
		,ISNULL(p.CustodyIssue, 0)
		,ISNULL(p.OkTransport, 0)
		,0 -- no security label
		,p.OtherNewChurch
	FROM dbo.People p
	JOIN @pids ON pid = p.PeopleId
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	JOIN lookup.Gender g ON g.Id = p.GenderId
	LEFT JOIN dbo.RecReg rr ON p.PeopleId = rr.PeopleId
	JOIN @visitorgs vo ON (p.CampusId != @campus OR p.CampusId IS NULL) AND p.Age > 12
	WHERE NOT EXISTS(SELECT NULL FROM @t WHERE Id = p.PeopleId)		
	
	-----------------------------------------------
	-- Rest of Family that cannot checkin anywhere
	------------------------------------------------
	
	INSERT INTO @t SELECT
		 p.PeopleId 
		,p.PositionInFamilyId
		,NULL --neither Member nor Visitor
		,p.Name
		,p.FirstName 
		,p.PreferredName
		,p.LastName
		,p.BirthYear
		,p.BirthMonth
		,p.BirthDay
		,'No self check-in meetings available' --class
		,'' -- leader
		,0 -- orgid
		,'' -- location
		,ISNULL(p.Age, 0)
		,g.Code -- Gender
		,0 -- number of checkin labels
		,NULL -- hour
		,0 -- CheckedIn
		,p.NickName
		,p.EmailAddress
		,f.AddressLineOne
		,f.ZipCode
		,f.HomePhone
		,p.CellPhone
		,p.MaritalStatusId
		,p.GenderId
		,p.CampusId
		,rr.MedicalDescription
		,rr.emcontact
		,rr.emphone
		,ISNULL(rr.ActiveInAnotherChurch, 0)
		,ISNULL(rr.mname, rr.fname)
		,p.Grade
		,CASE WHEN p.PictureId IS NULL THEN 0 ELSE 1 END
		,ISNULL(p.CustodyIssue, 0)
		,ISNULL(p.OkTransport, 0)
		,0 -- no security label
		,p.OtherNewChurch
	FROM dbo.People p
	JOIN @pids ON pid = p.PeopleId
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	JOIN lookup.Gender g ON g.Id = p.GenderId
	LEFT JOIN dbo.RecReg rr ON p.PeopleId = rr.PeopleId
	WHERE NOT EXISTS(SELECT NULL FROM @t WHERE Id = p.PeopleId)		
	
	RETURN 
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllMeetingCounters]'
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateAllMeetingCounters]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		DECLARE cur CURSOR FOR SELECT MeetingId FROM dbo.Meetings 
		OPEN cur
		DECLARE @mid int
		FETCH NEXT FROM cur INTO @mid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE dbo.UpdateMeetingCounters @mid
			FETCH NEXT FROM cur INTO @mid
		END
		CLOSE cur
		DEALLOCATE cur
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionChange]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ContributionChange](@pid INT, @dt1 DATETIME, @dt2 DATETIME)
RETURNS FLOAT
AS
BEGIN
	DECLARE @pct FLOAT
	DECLARE @amt1 MONEY
	DECLARE @amt2 MONEY
	DECLARE @option INT
	DECLARE @spouse INT
	SELECT	@option = ISNULL(ContributionOptionsId,1), 
			@spouse = SpouseId
	FROM dbo.People 
	WHERE PeopleId = @pid
	
	SELECT @amt1 = SUM(ContributionAmount)
	FROM dbo.Contribution
	WHERE 
	ContributionDate >= @dt1
	AND ContributionDate < @dt2
	AND ContributionStatusId = 0 --Recorded
	AND ContributionTypeId NOT IN (6,7) --Reversed or returned
	AND ((@option <> 2 AND PeopleId = @pid)
		 OR (@option = 2 AND PeopleId IN (@pid, @spouse)))
		 
	SELECT @amt2 = SUM(ContributionAmount)
	FROM dbo.Contribution
	WHERE 
	ContributionDate >= @dt2
	AND ContributionStatusId = 0 --Recorded
	AND ContributionTypeId NOT IN (6,7) --Reversed or returned
	AND ((@option <> 2 AND PeopleId = @pid)
		 OR (@option = 2 AND PeopleId IN (@pid, @spouse)))

	-- Return the result of the function
	IF @amt1 = 0
		SET @amt1 = .01
	IF @amt2 is NULL	
		SET @amt2 = 0
	SET @pct = @amt2 / @amt1 * 100
	RETURN @pct

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CheckinMatch]'
GO
CREATE FUNCTION [dbo].[CheckinMatch]( @id nvarchar(20) )
RETURNS 
@t TABLE 
(
	 familyid INT
	,areacode nvarchar(3)
	,NAME nvarchar(100)
	,phone nvarchar(20)
	,locked BIT
)
AS
BEGIN
	SET @id = dbo.GetDigits(@id)
	DECLARE @ph nvarchar(10) = REPLACE(STR(@id, 10), SPACE(1), '0') 
	DECLARE @p7 nvarchar(7) = SUBSTRING(@ph, 4, 7) + '%'
	DECLARE @ac nvarchar(4) = SUBSTRING(@ph, 1, 3)

	DECLARE @tpins TABLE ( fid INT )
	INSERT @tpins SELECT f.FamilyId 
	FROM dbo.PeopleExtra e 
	JOIN dbo.People p ON e.PeopleId = p.PeopleId
	JOIN dbo.Families f ON p.FamilyId = f.FamilyId
	WHERE e.Field = 'PIN' AND e.Data = @id
	
	DECLARE @cells TABLE(fid INT)
	INSERT @cells SELECT p.FamilyId
	FROM dbo.People p 
	WHERE p.CellPhoneLU LIKE @p7
	
	DECLARE @locks TABLE ( fid INT )
	INSERT @locks
		SELECT FamilyId FROM dbo.FamilyCheckinLock WHERE DATEDIFF(s, Created, GETDATE()) < 60 AND Locked = 1
		
	INSERT INTO @t SELECT
		f.FamilyId,
		f.HomePhoneAC AreaCode,
		hh.Name,
		@id phone,
		CAST(CASE WHEN lo.fid IS NOT NULL THEN 1 ELSE 0 END AS bit) locked
	FROM dbo.Families f
	JOIN dbo.People hh ON f.HeadOfHouseholdId = hh.PeopleId AND hh.DeceasedDate IS NULL
	LEFT JOIN @locks lo ON fid = f.FamilyId
	WHERE f.HomePhoneLU LIKE @p7
			OR EXISTS(SELECT NULL FROM @cells WHERE fid = f.FamilyId)
			OR EXISTS(SELECT NULL FROM @tpins WHERE fid = f.FamilyId)
			
	--IF @ac <> '000' AND (select count(*) FROM @t) > 1
	--	DELETE @t WHERE areacode <> @ac
		
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UserRoles]'
GO


CREATE VIEW [dbo].[UserRoles]
AS
SELECT Name, EmailAddress, 
	LEFT(Roles, LEN(Roles) -1) AS Roles
FROM (SELECT DISTINCT Name, EmailAddress,
		(SELECT RoleName + ',' AS [text()] 
		FROM Roles r
		JOIN dbo.UserRole ur ON r.RoleId = ur.RoleId
		WHERE ur.UserId = u.UserId
		FOR XML PATH ('')) Roles
FROM dbo.Users u
WHERE EmailAddress NOT IN ('david@bvcms.com','karen@bvcms.com', 'support@bvcms.com')
) tt

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionAmount2]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ContributionAmount2](@pid INT, @dt1 DATETIME, @dt2 DATETIME, @fundid INT)
RETURNS MONEY
AS
BEGIN
	-- Declare the return variable here
	DECLARE @amt MONEY

	-- Add the T-SQL statements to compute the return value here
	DECLARE @option INT
	DECLARE @spouse INT
	SELECT	@option = ISNULL(ContributionOptionsId,1), 
			@spouse = SpouseId
	FROM dbo.People 
	WHERE PeopleId = @pid
	
	SELECT @amt = SUM(c.ContributionAmount)
	FROM dbo.Contribution c
	WHERE 
	c.ContributionDate >= @dt1
	AND (c.FundId = @fundid OR @fundid IS NULL)
	AND	c.ContributionDate < @dt2
	AND c.ContributionStatusId = 0 --Recorded
	AND c.ContributionTypeId NOT IN (6,7,8) --Reversed or returned
	AND ((@option <> 2 AND c.PeopleId = @pid)
		 OR (@option = 2 AND c.PeopleId IN (@pid, @spouse)))

	-- Return the result of the function
	RETURN @amt

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SubRequest]'
GO
CREATE TABLE [dbo].[SubRequest]
(
[AttendId] [int] NOT NULL,
[RequestorId] [int] NOT NULL,
[Requested] [datetime] NOT NULL,
[SubstituteId] [int] NOT NULL,
[Responded] [datetime] NULL,
[CanSub] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SubRequest] on [dbo].[SubRequest]'
GO
ALTER TABLE [dbo].[SubRequest] ADD CONSTRAINT [PK_SubRequest] PRIMARY KEY CLUSTERED  ([AttendId], [RequestorId], [Requested], [SubstituteId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DropOrgMember]'
GO
CREATE PROCEDURE [dbo].[DropOrgMember](@oid INT, @pid INT)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @attendcount INT
	DECLARE @daystoignorehistory INT
	DECLARE @enrolled DATETIME
	DECLARE @created DATETIME
	DECLARE @orgname nvarchar(100)
	DECLARE @attpct REAL
	DECLARE @membertype INT
	DECLARE @pending BIT

	SELECT 
		@enrolled = EnrollmentDate,
		@created = CreatedDate,
		@attpct = AttendPct,
		@membertype = MemberTypeId,
		@pending = Pending
	FROM dbo.OrganizationMembers om
	WHERE om.PeopleId = @pid AND om.OrganizationId = @oid
	
	IF(@membertype IS NULL)
		RETURN 0

	SELECT @attendcount = (SELECT COUNT(*) FROM dbo.Attend a
						   JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
						   WHERE m.OrganizationId = o.OrganizationId
						   AND a.PeopleId = @pid
						   AND (a.MeetingDate < GETDATE() OR a.AttendanceFlag = 1)),
		   @daystoignorehistory = o.DaysToIgnoreHistory,
		   @orgname = OrganizationName
	FROM dbo.Organizations o
	WHERE OrganizationId = @oid

	IF(@enrolled IS NULL)
		SET @enrolled = @created

	INSERT dbo.EnrollmentTransaction
	        ( CreatedBy ,
	          CreatedDate ,
	          TransactionDate ,
	          TransactionTypeId ,
	          OrganizationId ,
	          OrganizationName ,
	          PeopleId ,
	          MemberTypeId ,
	          AttendancePercentage ,
	          Pending
	        )
	VALUES  ( 0 , -- CreatedBy - int
	          GETDATE() , -- CreatedDate - datetime
	          GETDATE() , -- TransactionDate - datetime
	          5 , -- TransactionTypeId - int
	          @oid , -- OrganizationId - int
	          @orgname , -- OrganizationName - nvarchar(100)
	          @pid , -- PeopleId - int
	          @membertype , -- MemberTypeId - int
	          @attpct , -- AttendancePercentage - real
	          @pending  -- Pending - bit
	        )
	DECLARE @tranid INT = SCOPE_IDENTITY()
	        
	DELETE dbo.OrgMemMemTags 
	WHERE PeopleId = @pid AND OrgId = @oid

	DELETE dbo.OrganizationMembers 
	WHERE PeopleId = @pid AND OrganizationId = @oid

	DELETE dbo.SubRequest 
	WHERE EXISTS(SELECT NULL FROM Attend a 
				 WHERE a.AttendId = AttendId 
				 AND a.OrganizationId = @oid 
				 AND a.MeetingDate > GETDATE() 
				 AND a.PeopleId = @pid)
				 
	DELETE dbo.Attend 
	WHERE OrganizationId = @oid 
	AND MeetingDate > GETDATE() 
	AND PeopleId = @pid 
	AND ISNULL(Commitment, 1) = 1

	RETURN @tranid
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FirstTimeGivers]'
GO

CREATE FUNCTION [dbo].[FirstTimeGivers] ( @days INT, @fundid INT )
RETURNS TABLE 
AS
RETURN 
	SELECT PeopleId, FirstDate, Amt
	FROM
	(
		SELECT CreditGiverId, SUM(Amount) AS Amt, MIN(Date) as FirstDate
		FROM dbo.Contributions2('1/1/1900', GETDATE(), 0, 0, 0, 0) c
		WHERE c.FundId = @fundid OR @fundid = 0
		GROUP BY CreditGiverId
	) tt
	JOIN dbo.People p ON p.PeopleId = tt.CreditGiverId
	WHERE FirstDate > DATEADD(dd, -@days, GETDATE())
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RecentAbsentsSP2]'
GO
CREATE PROCEDURE [dbo].[RecentAbsentsSP2]
(
	 @name nvarchar(100)
	,@prog INT
	,@div INT 
	,@type INT 
	,@campus INT
	,@sched INT 
	,@status INT
	,@onlinereg INT
	,@mainfellowship BIT
	,@parentorg BIT
)
AS
BEGIN

DECLARE @t TABLE (orgid INT PRIMARY KEY, cathreshhold INT, orgname nvarchar(100), leader nvarchar(70))

INSERT @t
SELECT  OrganizationId, ConsecutiveAbsentsThreshold, OrganizationName, LeaderName
FROM Organizations o 
	WHERE (@name IS NULL OR o.OrganizationName LIKE '%' + @name + '%')
	
	AND (ISNULL(@prog, 0) = 0
		OR EXISTS(SELECT NULL 
					FROM dbo.DivOrg dd
					JOIN dbo.Division di ON dd.DivId = di.Id
					JOIN dbo.ProgDiv pp ON di.Id = pp.DivId
					WHERE dd.OrgId = o.OrganizationId AND pp.ProgId = @prog))
					
	AND (ISNULL(@div, 0) = 0
		OR EXISTS(SELECT NULL 
					FROM dbo.DivOrg dd
					WHERE dd.OrgId = o.OrganizationId AND dd.DivId = @div))
					
	AND (ISNULL(@type, 0) = 0 OR o.OrganizationTypeId = @type)
	
	AND (ISNULL(@campus, 0) = 0 OR o.CampusId = @campus)
	
	AND (ISNULL(@sched, 0) = 0
		OR EXISTS(SELECT NULL 
					FROM dbo.OrgSchedule os 
					WHERE os.OrganizationId = o.OrganizationId AND os.ScheduleId = @sched))
					
	AND (ISNULL(@status, 0) = 0 OR o.OrganizationStatusId = @status)
	
	AND ((@onlinereg = 0 AND ISNULL(o.RegistrationTypeId, 0) = 0) 
		  OR (@onlinereg = 99 AND ISNULL(o.RegistrationTypeId, 0) > 0) 
		  OR (@onlinereg > 0 AND ISNULL(o.RegistrationTypeId, 0) = @onlinereg) 
		  OR @onlinereg = -1
		)
	AND (@mainfellowship = 0 OR (@mainfellowship = 1 AND o.IsBibleFellowshipOrg = 1))
	
	AND (@parentorg = 0 
		OR (ISNULL(@parentorg, 0) = 1 AND EXISTS(SELECT NULL FROM dbo.Organizations co WHERE co.ParentOrgId = o.OrganizationId)))
		
	DECLARE @days INT = 36
	SELECT
		om.OrganizationId,
		t.orgname OrganizationName,
		t.leader LeaderName,
		consecutive, 
		om.PeopleId,
		p.Name2,
		p.HomePhone,
		p.CellPhone,
		p.EmailAddress,
			(SELECT MAX(Attend.MeetingDate) 
			 FROM dbo.Attend
			 JOIN dbo.Meetings mm ON dbo.Attend.MeetingId = mm.MeetingId
			 WHERE mm.OrganizationId = t.orgid 
			 AND AttendanceFlag = 1 
			 AND mm.MeetingDate > DATEADD(d, -@days, GETDATE()) 
			 AND mm.MeetingDate < GETDATE())
		lastmeeting,
			(SELECT MAX(mm.MeetingDate) 
			FROM Attend 
			JOIN dbo.Meetings mm ON dbo.Attend.MeetingId = mm.MeetingId
			WHERE AttendanceFlag = 1 
			AND mm.OrganizationId = t.orgid
			AND Attend.PeopleId = om.PeopleId)
		lastattend,
		ISNULL(t.cathreshhold, 2) ConsecutiveAbsentsThreshold
	FROM 
		(SELECT 
			OrganizationId, 
			PeopleId, 
			COUNT(*) consecutive
		 FROM dbo.Attend a
		 WHERE MeetingDate > (SELECT MAX(MeetingDate)
							  FROM Attend 
							  WHERE AttendanceFlag = 1 
							  AND a.OrganizationId = OrganizationId
							  AND a.PeopleId = PeopleId
							  GROUP BY OrganizationId, PeopleId)
		 GROUP BY OrganizationId, PeopleId
	    ) tt1
	JOIN OrganizationMembers om ON tt1.OrganizationId = om.OrganizationId AND tt1.PeopleId = om.PeopleId
	JOIN dbo.People p ON om.PeopleId = p.PeopleId
	JOIN @t t ON orgid = om.OrganizationId
	JOIN lookup.MemberType mt ON om.MemberTypeId = mt.Id
	JOIN lookup.AttendType at ON at.Id = mt.AttendanceTypeId
	WHERE consecutive >= ISNULL(t.cathreshhold, 2)
	AND at.Id NOT IN (70, 100) --inservice and homebound
	AND om.MemberTypeId != 230 --inactive
	ORDER BY t.orgname, t.orgid, consecutive, p.Name2
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MemberDesc]'
GO
CREATE FUNCTION [dbo].[MemberDesc](@id int) 
RETURNS nvarchar(100)
AS
BEGIN
	DECLARE @ret nvarchar(100)
	SELECT @ret =  Description FROM lookup.MemberType WHERE id = @id
	RETURN @ret
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ChangedGiving]'
GO
CREATE PROCEDURE [dbo].[ChangedGiving](@dt1 DATETIME, @dt2 DATETIME, @lopct FLOAT, @hipct FLOAT)
AS
BEGIN

	SELECT PeopleId, Name, dbo.ContributionAmount2(PeopleId, @dt1, @dt2, NULL) FROM dbo.People
	WHERE dbo.ContributionChange(PeopleId, @dt1, @dt2) BETWEEN @lopct AND @hipct
	
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AddEditExtraValues]'
GO
CREATE PROCEDURE dbo.AddEditExtraValues
(
	@List VARCHAR(MAX), 
	@Name VARCHAR(100), 
	@StrValue VARCHAR(100),
	@Data VARCHAR(MAX),
	@DateValue DATETIME,
	@IntValue INT,
	@BitValue BIT
)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @t TABLE(PeopleId INT)
	INSERT INTO @t SELECT Value FROM dbo.SplitInts(@List)
	
	DECLARE @updates TABLE(PeopleId INT)
	INSERT INTO @updates
	SELECT e.PeopleId FROM dbo.PeopleExtra e
	JOIN @t t ON e.PeopleId = t.PeopleId AND e.Field = @Name
	
	DECLARE @inserts TABLE(PeopleId INT)
	INSERT INTO @inserts
	SELECT PeopleId FROM @t WHERE PeopleId NOT IN (SELECT PeopleId FROM @updates)
	
	IF LEN(@StrValue) > 0
	BEGIN
		UPDATE dbo.PeopleExtra
		SET Field = @Name,
			StrValue = @StrValue
		FROM dbo.PeopleExtra e
		JOIN @updates u ON e.PeopleId = u.PeopleId
		
		INSERT dbo.PeopleExtra ( PeopleId, Field, StrValue )
			SELECT i.PeopleId, @Name, @StrValue 
			FROM @inserts i
	END
	ELSE IF @DateValue IS NOT NULL
	BEGIN
		UPDATE dbo.PeopleExtra
		SET Field = @Name,
			DateValue = @DateValue
		FROM dbo.PeopleExtra e
		JOIN @t ON e.PeopleId = [@t].PeopleId
		
		INSERT dbo.PeopleExtra ( PeopleId, Field, DateValue )
			SELECT t.PeopleId, @Name, @DateValue FROM @t t
			LEFT JOIN dbo.PeopleExtra e ON t.PeopleId = e.PeopleId
			WHERE e.PeopleId IS NULL
	END
	ELSE IF @IntValue IS NOT NULL
	BEGIN
		UPDATE dbo.PeopleExtra
		SET Field = @Name,
			IntValue = @IntValue
		FROM dbo.PeopleExtra e
		JOIN @t ON e.PeopleId = [@t].PeopleId
		
		INSERT dbo.PeopleExtra ( PeopleId, Field, IntValue )
			SELECT t.PeopleId, @Name, @IntValue FROM @t t
			LEFT JOIN dbo.PeopleExtra e ON t.PeopleId = e.PeopleId
			WHERE e.PeopleId IS NULL
	END
	ELSE IF @BitValue IS NOT NULL
	BEGIN
		UPDATE dbo.PeopleExtra
		SET Field = @Name,
			BitValue = @BitValue
		FROM dbo.PeopleExtra e
		JOIN @t ON e.PeopleId = [@t].PeopleId
		
		INSERT dbo.PeopleExtra ( PeopleId, Field, BitValue )
			SELECT t.PeopleId, @Name, @BitValue FROM @t t
			LEFT JOIN dbo.PeopleExtra e ON t.PeopleId = e.PeopleId
			WHERE e.PeopleId IS NULL
	END
	ELSE IF LEN(@Data) > 0
	BEGIN
		UPDATE dbo.PeopleExtra
		SET Field = @Name,
			Data = @Data
		FROM dbo.PeopleExtra e
		JOIN @t ON e.PeopleId = [@t].PeopleId
		
		INSERT dbo.PeopleExtra ( PeopleId, Field, Data )
			SELECT t.PeopleId, @Name, @Data FROM @t t
			LEFT JOIN dbo.PeopleExtra e ON t.PeopleId = e.PeopleId
			WHERE e.PeopleId IS NULL
	END
	        
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationLeaders]'
GO
CREATE VIEW [dbo].[OrganizationLeaders]
AS
SELECT DISTINCT * FROM
(

SELECT om.PeopleId, om.OrganizationId 
FROM dbo.OrganizationMembers om
JOIN lookup.MemberType t ON om.MemberTypeId = t.Id
WHERE t.AttendanceTypeId = 10
GROUP BY om.PeopleId, om.OrganizationId

UNION

SELECT om.PeopleId, o.OrganizationId 
FROM dbo.Organizations po
JOIN dbo.OrganizationMembers om ON po.OrganizationId = om.OrganizationId 
JOIN dbo.Organizations o ON o.ParentOrgId = po.OrganizationId
JOIN lookup.MemberType t ON om.MemberTypeId = t.Id
WHERE t.AttendanceTypeId = 10
GROUP BY om.PeopleId, o.OrganizationId

) tt

WHERE EXISTS(
		SELECT NULL FROM Users u
		JOIN dbo.UserRole ur ON u.UserId = ur.UserId
		JOIN dbo.Roles r ON ur.RoleId = r.RoleId
		WHERE r.RoleName = 'Access'
		AND u.PeopleId = tt.PeopleId )

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DaysSinceContact]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.DaysSinceContact(@pid INT)
RETURNS int
AS
BEGIN
	DECLARE @days int

	SELECT @days = MIN(DATEDIFF(D,c.ContactDate,GETDATE())) FROM dbo.Contact c
	JOIN dbo.Contactees ce ON c.ContactId = ce.ContactId
	WHERE ce.PeopleId = @pid

	RETURN @days

END



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MembersAsOf]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[MembersAsOf]
(	
	@from DATETIME,
	@to DATETIME,
	@progid INT,
	@divid INT,
	@orgid INT
)
RETURNS @t TABLE ( PeopleId INT )
AS
BEGIN
	INSERT INTO @t (PeopleId) SELECT p.PeopleId FROM dbo.People p
	WHERE
	EXISTS (
		SELECT NULL FROM dbo.EnrollmentTransaction et
		WHERE et.PeopleId = p.PeopleId
		AND et.TransactionTypeId <= 3
		AND @from <= COALESCE(et.NextTranChangeDate, GETDATE())
		AND et.TransactionDate <= @to
		AND (et.OrganizationId = @orgid OR @orgid = 0)
		AND (EXISTS(SELECT NULL FROM DivOrg d1
				WHERE d1.OrgId = et.OrganizationId
				AND d1.DivId = @divid) OR @divid = 0)
		AND (EXISTS(SELECT NULL FROM DivOrg d2
				WHERE d2.OrgId = et.OrganizationId
				AND EXISTS(SELECT NULL FROM Division d
						WHERE d2.DivId = d.Id
						AND d.ProgId = @progid)) OR @progid = 0)
		)
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrganizationMemberCount2]'
GO

CREATE FUNCTION [dbo].[OrganizationMemberCount2](@oid int) 
RETURNS int
AS
BEGIN
	DECLARE @c int
	SELECT @c = count(*) from dbo.OrganizationMembers 
	where OrganizationId = @oid AND (Pending IS NULL OR Pending = 0)
	RETURN @c
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UpdateAllAttendStrBig]'
GO
CREATE PROCEDURE [dbo].[UpdateAllAttendStrBig] (@orgid INT)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @start DATETIME = CURRENT_TIMESTAMP;
	DECLARE @pid INT, @n INT
	
	DECLARE @a nvarchar(200) = '', -- attendance string
			@mindt DATETIME, 
			@dt DATETIME,
			@tct INT, -- total count
			@act INT, -- attended count
			@pct REAL,
			@lastattend DATETIME
    DECLARE @yearago DATETIME,
			@lastmeet DATETIME,
			@maxfuturemeeting DATETIME,
			@tzoffset INT,
			@earlycheckinhours INT = 10 -- to include future meetings
			
	SELECT @tzoffset = CONVERT(INT, Setting) FROM dbo.Setting WHERE Id = 'TZOffset'
	SELECT @maxfuturemeeting = DATEADD(hh ,ISNULL(@tzoffset,0) + @earlycheckinhours, GETDATE())
		
    SELECT @lastmeet = MAX(MeetingDate) 
    FROM dbo.Meetings
    WHERE OrganizationId = @orgid
    AND MeetingDate <= @maxfuturemeeting
    
    SELECT @yearago = DATEADD(year, -1, @lastmeet)
			
	CREATE TABLE #t
	(
		PeopleId INT NOT NULL,
		Attended BIT,
		[Year] INT NOT NULL,
		[Week] INT NOT NULL,
		AttendCreditCode INT NOT NULL,
		AttendanceTypeId INT
	)
	INSERT INTO #t
	        ( PeopleId,
	          Attended,
	          [Year],
	          [Week],
	          AttendCreditCode,
	          AttendanceTypeId
	        )
	SELECT
		PeopleId,
		CONVERT(BIT, MAX(Attended)) AS Attended,
		[Year],
		[Week],
		AttendCredit,
		MAX(AttendanceTypeId) AS AttendanceTypeId
	FROM (
		SELECT	PeopleId,
				CONVERT(INT, EffAttendFlag) AS Attended, 
				DATEPART(yy, m.MeetingDate) AS [Year], 
				DATEPART(ww, m.MeetingDate) AS [Week], 
				s.ScheduleId,
				AttendanceTypeId,
				CASE WHEN ISNULL(m.AttendCreditId, 1) = 1 
					THEN AttendId + 20 -- make every meeting count, 20 gets it out of the way of AttendCredit codes
					ELSE m.AttendCreditId
				END AS AttendCredit
		FROM dbo.Attend AS a
		JOIN dbo.Meetings m ON a.MeetingId = m.MeetingId
		LEFT JOIN dbo.OrgSchedule s 
			ON m.OrganizationId = s.OrganizationId 
			AND s.ScheduleId = dbo.ScheduleId(NULL, a.MeetingDate)
		WHERE m.OrganizationId = @orgid
			AND m.MeetingDate >= @yearago
			AND m.MeetingDate <= @maxfuturemeeting
	) AS InlineView
	GROUP BY PeopleId, [Year], [Week], AttendCredit
	        
	CREATE INDEX IDX_PeopleId ON #t(PeopleId, [Year] DESC, [Week] DESC)
	
	DECLARE cur CURSOR FOR 
	SELECT PeopleId 
	FROM dbo.OrganizationMembers
	WHERE OrganizationId = @orgid
	
	OPEN cur
	
	FETCH NEXT FROM cur INTO @pid
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		raiserror ('%d %d', 10,1, @orgid, @pid) with nowait
		
	    SELECT @tct = COUNT(*) 
		FROM (
				SELECT TOP 52 * 
				FROM #t 
				WHERE PeopleId = @pid 
				ORDER BY [Year] DESC, [Week] DESC
			  ) tt 
		WHERE Attended IS NOT NULL
	    
	    SELECT @act = COUNT(*) 
		FROM (
				SELECT TOP 52 * 
				FROM #t 
				WHERE PeopleId = @pid 
				ORDER BY [Year] DESC, [Week] DESC
			  ) tt 
	    WHERE Attended = 1
	       
		if @tct = 0
			SELECT @pct = 0
		else
			SELECT @pct = @act * 100.0 / @tct
				
		SELECT TOP 52 @a = 
			CASE 
			WHEN Attended IS NULL THEN
				CASE AttendanceTypeId
				WHEN 20 THEN 'V'
				WHEN 70 THEN 'I'
				WHEN 90 THEN 'G'
				WHEN 80 THEN 'O'
				WHEN 110 THEN '*'
				ELSE '*'
				END
			WHEN Attended = 1 THEN 'P'
			ELSE '.'
			END + @a
		FROM #t
		WHERE PeopleId = @pid
		ORDER BY [Year] DESC, [Week] DESC
		
		SELECT @lastattend = MAX(m.MeetingDate) 
		FROM dbo.Meetings m
		WHERE m.OrganizationId = @orgid 
		AND EXISTS
		(
			SELECT NULL 
			FROM dbo.Attend 
			WHERE MeetingId = m.MeetingId 
			AND PeopleId = @pid 
			AND AttendanceFlag = 1
		)

		UPDATE dbo.OrganizationMembers SET
			AttendPct = @pct,
			AttendStr = @a,
			LastAttended = @lastattend
		WHERE OrganizationId = @orgid AND PeopleId = @pid

		
		FETCH NEXT FROM cur INTO @pid
	END
	CLOSE cur
	DEALLOCATE cur
		
	INSERT INTO dbo.ActivityLog
	        ( ActivityDate , UserId , Activity , Machine )
	VALUES  ( GETDATE(), NULL , 'UpdateAllAttendStr (' + CONVERT(nvarchar, @orgid) + ',' + CONVERT(nvarchar, DATEDIFF(ms, @start, CURRENT_TIMESTAMP) / 1000) + ')', 'DB' )
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AttendMemberTypeAsOf]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[AttendMemberTypeAsOf]
(	
	@from DATETIME,
	@to DATETIME,
	@progid INT,
	@divid INT,
	@orgid INT,
	@ids nvarchar(4000)
)
RETURNS @t TABLE ( PeopleId INT )
AS
BEGIN
	INSERT INTO @t (PeopleId) SELECT p.PeopleId FROM dbo.People p
	WHERE EXISTS (
		SELECT NULL FROM dbo.Attend a
		WHERE a.PeopleId = p.PeopleId
		AND a.MemberTypeId IN (SELECT id FROM CsvTable(@ids))
		AND a.AttendanceFlag = 1
		AND a.MeetingDate >= @from
		AND a.MeetingDate < @to
		AND (a.OrganizationId = @orgid OR @orgid = 0)
		AND (EXISTS(SELECT NULL FROM DivOrg d1
				WHERE d1.OrgId = a.OrganizationId
				AND d1.DivId = @divid) OR @divid = 0)
		AND (EXISTS(SELECT NULL FROM DivOrg d2
				WHERE d2.OrgId = a.OrganizationId
				AND EXISTS(SELECT NULL FROM Division d
						WHERE d2.DivId = d.Id
						AND d.ProgId = @progid)) OR @progid = 0)
		)
	RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BackgroundChecks]'
GO
CREATE TABLE [dbo].[BackgroundChecks]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Created] [datetime] NOT NULL CONSTRAINT [DF_BackgroundChecks_Created] DEFAULT (getdate()),
[Updated] [datetime] NOT NULL CONSTRAINT [DF_BackgroundChecks_Updated] DEFAULT (getdate()),
[UserID] [int] NOT NULL CONSTRAINT [DF_Table_1_Status] DEFAULT ((1)),
[StatusID] [int] NOT NULL CONSTRAINT [DF_Table_1_UserID] DEFAULT ((1)),
[PeopleID] [int] NOT NULL CONSTRAINT [DF_Table_1_ReportID] DEFAULT ((1)),
[ServiceCode] [nvarchar] (25) NOT NULL CONSTRAINT [DF_BackgroundChecks_ServiceCode] DEFAULT (''),
[ReportID] [int] NOT NULL CONSTRAINT [DF_BackgroundChecks_ReportID] DEFAULT ((0)),
[ReportLink] [nvarchar] (255) NULL CONSTRAINT [DF_BackgroundChecks_ReportLink] DEFAULT (''),
[IssueCount] [int] NOT NULL CONSTRAINT [DF_Table_1_AlertCount] DEFAULT ((0)),
[ErrorMessages] [nvarchar] (max) NULL,
[ReportTypeID] [int] NOT NULL CONSTRAINT [DF_BackgroundChecks_ReportTypeID] DEFAULT ((0)),
[ReportLabelID] [int] NOT NULL CONSTRAINT [DF_BackgroundChecks_ReportLabelID] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BackgroundChecks] on [dbo].[BackgroundChecks]'
GO
ALTER TABLE [dbo].[BackgroundChecks] ADD CONSTRAINT [PK_BackgroundChecks] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BackgroundCheckMVRCodes]'
GO
CREATE TABLE [dbo].[BackgroundCheckMVRCodes]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Code] [nvarchar] (10) NOT NULL,
[Description] [nvarchar] (100) NOT NULL,
[StateAbbr] [nvarchar] (3) NOT NULL CONSTRAINT [DF_BackgroundCheckMVRCodes_StateCode] DEFAULT ('')
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BackgroundCheckMVRCodes] on [dbo].[BackgroundCheckMVRCodes]'
GO
ALTER TABLE [dbo].[BackgroundCheckMVRCodes] ADD CONSTRAINT [PK_BackgroundCheckMVRCodes] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OneTimeLinks]'
GO
CREATE TABLE [dbo].[OneTimeLinks]
(
[Id] [uniqueidentifier] NOT NULL,
[querystring] [nvarchar] (2000) NULL,
[used] [bit] NOT NULL CONSTRAINT [DF_OneTimeLinks_used] DEFAULT ((0)),
[expires] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OneTimeLinks] on [dbo].[OneTimeLinks]'
GO
ALTER TABLE [dbo].[OneTimeLinks] ADD CONSTRAINT [PK_OneTimeLinks] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SMSNumbers]'
GO
CREATE TABLE [dbo].[SMSNumbers]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[GroupID] [int] NOT NULL CONSTRAINT [DF_SMSNumber_GroupID] DEFAULT ((0)),
[Number] [nvarchar] (50) NOT NULL CONSTRAINT [DF_SMSNumbers_Number] DEFAULT (''),
[LastUpdated] [datetime] NOT NULL CONSTRAINT [DF_SMSNumbers_LastUpdated] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SMSNumber] on [dbo].[SMSNumbers]'
GO
ALTER TABLE [dbo].[SMSNumbers] ADD CONSTRAINT [PK_SMSNumber] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Content]'
GO
CREATE TABLE [dbo].[Content]
(
[Name] [nvarchar] (400) NOT NULL,
[Title] [nvarchar] (500) NULL,
[Body] [nvarchar] (max) NULL,
[DateCreated] [datetime] NULL,
[Id] [int] NOT NULL IDENTITY(1, 1),
[TextOnly] [bit] NULL,
[TypeID] [int] NOT NULL CONSTRAINT [DF_Content_Type] DEFAULT ((0)),
[ThumbID] [int] NOT NULL CONSTRAINT [DF_Content_ThumbID] DEFAULT ((0)),
[RoleID] [int] NOT NULL CONSTRAINT [DF_Content_RoleID] DEFAULT ((0)),
[OwnerID] [int] NOT NULL CONSTRAINT [DF_Content_OwnerID] DEFAULT ((0)),
[CreatedBy] [nvarchar] (50) NULL,
[Archived] [datetime] NULL,
[ArchivedFromId] [int] NULL,
[UseTimes] [int] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Content_1] on [dbo].[Content]'
GO
ALTER TABLE [dbo].[Content] ADD CONSTRAINT [PK_Content_1] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Content] on [dbo].[Content]'
GO
CREATE NONCLUSTERED INDEX [IX_Content] ON [dbo].[Content] ([Name])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Content_1] on [dbo].[Content]'
GO
CREATE NONCLUSTERED INDEX [IX_Content_1] ON [dbo].[Content] ([ArchivedFromId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SMSList]'
GO
CREATE TABLE [dbo].[SMSList]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Created] [datetime] NOT NULL CONSTRAINT [DF_SMSList1_slCreated] DEFAULT ((0)),
[SenderID] [int] NOT NULL CONSTRAINT [DF_SMSList1_slSenderID] DEFAULT ((0)),
[SendAt] [datetime] NOT NULL CONSTRAINT [DF_SMSList1_slSendAt] DEFAULT ((0)),
[SendGroupID] [int] NOT NULL CONSTRAINT [DF_SMSList_SendGroupID] DEFAULT ((0)),
[Message] [nvarchar] (160) NOT NULL CONSTRAINT [DF_SMSList1_slMessage] DEFAULT (''),
[SentSMS] [int] NOT NULL CONSTRAINT [DF_SMSList1_slSentSMS] DEFAULT ((0)),
[SentNone] [int] NOT NULL CONSTRAINT [DF_SMSList1_slSentNone] DEFAULT ((0)),
[Title] [nvarchar] (150) NOT NULL CONSTRAINT [DF_SMSList_Title] DEFAULT ('')
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SMSList] on [dbo].[SMSList]'
GO
ALTER TABLE [dbo].[SMSList] ADD CONSTRAINT [PK_SMSList] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[GeoCodes]'
GO
CREATE TABLE [dbo].[GeoCodes]
(
[Address] [nvarchar] (80) NOT NULL,
[Latitude] [float] NOT NULL CONSTRAINT [DF_GeoCodes_Latitude] DEFAULT ((0)),
[Longitude] [float] NOT NULL CONSTRAINT [DF_GeoCodes_Longitude] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_GeoCodes_1] on [dbo].[GeoCodes]'
GO
ALTER TABLE [dbo].[GeoCodes] ADD CONSTRAINT [PK_GeoCodes_1] PRIMARY KEY CLUSTERED  ([Address])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[QBConnections]'
GO
CREATE TABLE [dbo].[QBConnections]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Creation] [datetime] NOT NULL CONSTRAINT [DF_QBConnections_Creation] DEFAULT ((0)),
[UserID] [int] NOT NULL CONSTRAINT [DF_QBConnections_UserID] DEFAULT ((0)),
[Active] [tinyint] NOT NULL CONSTRAINT [DF_QBConnections_Active] DEFAULT ((0)),
[DataSource] [char] (3) NOT NULL CONSTRAINT [DF_QBConnections_DataSource] DEFAULT (''),
[Token] [nvarchar] (max) NOT NULL CONSTRAINT [DF_QBConnections_Token] DEFAULT (''),
[Secret] [nvarchar] (max) NOT NULL CONSTRAINT [DF_QBConnections_Secret] DEFAULT (''),
[RealmID] [nvarchar] (max) NOT NULL CONSTRAINT [DF_QBConnections_RealmID] DEFAULT ('')
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_QBConnections] on [dbo].[QBConnections]'
GO
ALTER TABLE [dbo].[QBConnections] ADD CONSTRAINT [PK_QBConnections] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailLinks]'
GO
CREATE TABLE [dbo].[EmailLinks]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Created] [datetime] NULL,
[EmailID] [int] NULL,
[Hash] [nvarchar] (50) NULL,
[Link] [nvarchar] (500) NULL,
[Count] [int] NOT NULL CONSTRAINT [DF_EmailLinks_Count] DEFAULT ((0))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailLinks] on [dbo].[EmailLinks]'
GO
ALTER TABLE [dbo].[EmailLinks] ADD CONSTRAINT [PK_EmailLinks] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LabelFormats]'
GO
CREATE TABLE [dbo].[LabelFormats]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (30) NOT NULL CONSTRAINT [DF_LabelFormats_Name] DEFAULT (''),
[Size] [int] NOT NULL CONSTRAINT [DF_LabelFormats_Size] DEFAULT ((0)),
[Format] [text] NOT NULL CONSTRAINT [DF_LabelFormats_Format] DEFAULT ('')
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_LabelFormats] on [dbo].[LabelFormats]'
GO
ALTER TABLE [dbo].[LabelFormats] ADD CONSTRAINT [PK_LabelFormats] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[EnvelopeOption]'
GO
CREATE TABLE [lookup].[EnvelopeOption]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EnvelopeOption] on [lookup].[EnvelopeOption]'
GO
ALTER TABLE [lookup].[EnvelopeOption] ADD CONSTRAINT [PK_EnvelopeOption] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ChangeDetails]'
GO
CREATE TABLE [dbo].[ChangeDetails]
(
[Id] [int] NOT NULL,
[Field] [nvarchar] (50) NOT NULL,
[Before] [nvarchar] (max) NULL,
[After] [nvarchar] (max) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ChangeDetails] on [dbo].[ChangeDetails]'
GO
ALTER TABLE [dbo].[ChangeDetails] ADD CONSTRAINT [PK_ChangeDetails] PRIMARY KEY CLUSTERED  ([Id], [Field])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContentKeyWords]'
GO
CREATE TABLE [dbo].[ContentKeyWords]
(
[Id] [int] NOT NULL,
[Word] [nvarchar] (50) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContentKeyWords] on [dbo].[ContentKeyWords]'
GO
ALTER TABLE [dbo].[ContentKeyWords] ADD CONSTRAINT [PK_ContentKeyWords] PRIMARY KEY CLUSTERED  ([Id], [Word])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_ContentKeyWords] on [dbo].[ContentKeyWords]'
GO
CREATE NONCLUSTERED INDEX [IX_ContentKeyWords] ON [dbo].[ContentKeyWords] ([Word])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[MeetingExtra]'
GO
CREATE TABLE [dbo].[MeetingExtra]
(
[MeetingId] [int] NOT NULL,
[Field] [nvarchar] (50) NOT NULL,
[Data] [nvarchar] (max) NULL,
[DataType] [nvarchar] (5) NULL,
[StrValue] [nvarchar] (200) NULL,
[DateValue] [datetime] NULL,
[IntValue] [int] NULL,
[BitValue] [bit] NULL,
[Type] AS ((((case when [StrValue] IS NOT NULL then 'Code' else '' end+case when [Data] IS NOT NULL then 'Text' else '' end)+case when [DateValue] IS NOT NULL then 'Date' else '' end)+case when [IntValue] IS NOT NULL then 'Int' else '' end)+case when [BitValue] IS NOT NULL then 'Bit' else '' end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MeetingExtra] on [dbo].[MeetingExtra]'
GO
ALTER TABLE [dbo].[MeetingExtra] ADD CONSTRAINT [PK_MeetingExtra] PRIMARY KEY CLUSTERED  ([MeetingId], [Field])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[Campus]'
GO
CREATE TABLE [lookup].[Campus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Campus] on [lookup].[Campus]'
GO
ALTER TABLE [lookup].[Campus] ADD CONSTRAINT [PK_Campus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[OrganizationType]'
GO
CREATE TABLE [lookup].[OrganizationType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrganizationType] on [lookup].[OrganizationType]'
GO
ALTER TABLE [lookup].[OrganizationType] ADD CONSTRAINT [PK_OrganizationType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[BaptismStatus]'
GO
CREATE TABLE [lookup].[BaptismStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BaptismStatus] on [lookup].[BaptismStatus]'
GO
ALTER TABLE [lookup].[BaptismStatus] ADD CONSTRAINT [PK_BaptismStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[BaptismType]'
GO
CREATE TABLE [lookup].[BaptismType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BaptismType] on [lookup].[BaptismType]'
GO
ALTER TABLE [lookup].[BaptismType] ADD CONSTRAINT [PK_BaptismType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[DecisionType]'
GO
CREATE TABLE [lookup].[DecisionType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DecisionType] on [lookup].[DecisionType]'
GO
ALTER TABLE [lookup].[DecisionType] ADD CONSTRAINT [PK_DecisionType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[NewMemberClassStatus]'
GO
CREATE TABLE [lookup].[NewMemberClassStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DiscoveryClassStatus] on [lookup].[NewMemberClassStatus]'
GO
ALTER TABLE [lookup].[NewMemberClassStatus] ADD CONSTRAINT [PK_DiscoveryClassStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[DropType]'
GO
CREATE TABLE [lookup].[DropType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DropType] on [lookup].[DropType]'
GO
ALTER TABLE [lookup].[DropType] ADD CONSTRAINT [PK_DropType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[FamilyPosition]'
GO
CREATE TABLE [lookup].[FamilyPosition]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FamilyPosition] on [lookup].[FamilyPosition]'
GO
ALTER TABLE [lookup].[FamilyPosition] ADD CONSTRAINT [PK_FamilyPosition] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[InterestPoint]'
GO
CREATE TABLE [lookup].[InterestPoint]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_InterestPoint] on [lookup].[InterestPoint]'
GO
ALTER TABLE [lookup].[InterestPoint] ADD CONSTRAINT [PK_InterestPoint] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[JoinType]'
GO
CREATE TABLE [lookup].[JoinType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_JoinType] on [lookup].[JoinType]'
GO
ALTER TABLE [lookup].[JoinType] ADD CONSTRAINT [PK_JoinType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[MaritalStatus]'
GO
CREATE TABLE [lookup].[MaritalStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MaritalStatus] on [lookup].[MaritalStatus]'
GO
ALTER TABLE [lookup].[MaritalStatus] ADD CONSTRAINT [PK_MaritalStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[MemberLetterStatus]'
GO
CREATE TABLE [lookup].[MemberLetterStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MemberLetterStatus] on [lookup].[MemberLetterStatus]'
GO
ALTER TABLE [lookup].[MemberLetterStatus] ADD CONSTRAINT [PK_MemberLetterStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[Origin]'
GO
CREATE TABLE [lookup].[Origin]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Origin] on [lookup].[Origin]'
GO
ALTER TABLE [lookup].[Origin] ADD CONSTRAINT [PK_Origin] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SMSGroups]'
GO
CREATE TABLE [dbo].[SMSGroups]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) NOT NULL,
[Description] [nvarchar] (max) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SMSGroup] on [dbo].[SMSGroups]'
GO
ALTER TABLE [dbo].[SMSGroups] ADD CONSTRAINT [PK_SMSGroup] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SMSGroupMembers]'
GO
CREATE TABLE [dbo].[SMSGroupMembers]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[GroupID] [int] NOT NULL,
[UserID] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_SMSGroupMembers] on [dbo].[SMSGroupMembers]'
GO
ALTER TABLE [dbo].[SMSGroupMembers] ADD CONSTRAINT [PK_SMSGroupMembers] PRIMARY KEY CLUSTERED  ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[TaskStatus]'
GO
CREATE TABLE [lookup].[TaskStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (50) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TaskStatus] on [lookup].[TaskStatus]'
GO
ALTER TABLE [lookup].[TaskStatus] ADD CONSTRAINT [PK_TaskStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[VolApplicationStatus]'
GO
CREATE TABLE [lookup].[VolApplicationStatus]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (10) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolApplicationStatus] on [lookup].[VolApplicationStatus]'
GO
ALTER TABLE [lookup].[VolApplicationStatus] ADD CONSTRAINT [PK_VolApplicationStatus] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[VolunteerCodes]'
GO
CREATE TABLE [lookup].[VolunteerCodes]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (10) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_VolunteerCodes] on [lookup].[VolunteerCodes]'
GO
ALTER TABLE [lookup].[VolunteerCodes] ADD CONSTRAINT [PK_VolunteerCodes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ResidentCode]'
GO
CREATE TABLE [lookup].[ResidentCode]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ResidentCode] on [lookup].[ResidentCode]'
GO
ALTER TABLE [lookup].[ResidentCode] ADD CONSTRAINT [PK_ResidentCode] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating trigger [dbo].[delMeeting] on [dbo].[Meetings]'
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE TRIGGER [dbo].[delMeeting] 
   ON  [dbo].[Meetings]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @oid INT, @mid INT, @att INT
	
	SELECT @mid = MeetingId, @oid = OrganizationId FROM DELETED;
	IF @oid IS NULL
		RETURN
	
	--DECLARE attendcursor CURSOR FOR
	--SELECT PeopleId, AttendanceFlag
	--FROM dbo.Attend
	--WHERE MeetingId = @mid
	
	--OPEN attendcursor;
	--FETCH NEXT FROM attendcursor INTO @pid, @att;
	
	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	--	IF @att = 1
	--		EXEC dbo.RecordAttend @mid, @pid, 0
	--	FETCH NEXT FROM attendcursor INTO @pid, @att;
	--END;
	--CLOSE attendcursor;
	--DEALLOCATE attendcursor;
	
	DECLARE @dialog UNIQUEIDENTIFIER
	BEGIN DIALOG CONVERSATION @dialog
	  FROM SERVICE UpdateAttendStrService
	  TO SERVICE 'UpdateAttendStrService'
	  ON CONTRACT UpdateAttendStrContract
	  WITH ENCRYPTION = OFF;
	SEND ON CONVERSATION @dialog MESSAGE TYPE UpdateAttendStrMessage (@oid)
END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BaptismAgeRange]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[BaptismAgeRange](@age int) 
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r nvarchar(20)

	-- Add the T-SQL statements to compute the return value here
	SELECT @r = 
		CASE 
		WHEN @age < 12 THEN '0-11'
		WHEN @age < 19 THEN '12-18'
		WHEN @age < 24 THEN '19-23'
		WHEN @age < 31 THEN '24-30'
		WHEN @age < 41 THEN '31-40'
		WHEN @age < 51 THEN '41-50'
		WHEN @age < 61 THEN '51-60'
		WHEN @age < 71 THEN '61-70'
		ELSE 'Over 70'
		END
		

	-- Return the result of the function
	RETURN @r

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Tool_VarbinaryToVarcharHex]'
GO
/**
<summary>
Based on ufn_VarbinaryToVarcharHex by Clay Beatty.
Used by Tool_ScriptDiagram2005

Function has two 'parts':

PART ONE: takes large VarbinaryValue chunks (greater than four bytes) 
and splits them into half, calling the function recursively with 
each half until the chunks are only four bytes long

PART TWO: notices the VarbinaryValue is four bytes or less, and 
starts actually processing these four byte chunks. It does this
by splitting the least-significant (rightmost) byte into two 
hexadecimal characters and recursively calling the function
with the more significant bytes until none remain (four recursive
calls in total).
</summary>
<author>Craig Dunn</author>
<remarks>
Clay Beatty's original function was written for Sql Server 2000.
Sql Server 2005 introduces the VARBINARY(max) datatype which this 
function now uses.

References
----------
1) MSDN: Using Large-Value Data Types
http://msdn2.microsoft.com/en-us/library/ms178158.aspx

2) Clay's "original" Script, Save, Export SQL 2000 Database Diagrams
http://www.thescripts.com/forum/thread81534.html or
http://groups-beta.google.com/group/comp.databases.ms-sqlserver/browse_frm/thread/ca9a9229d06a56f9?dq=&hl=en&lr=&ie=UTF-8&oe=UTF-8&prev=/groups%3Fdq%3D%26num%3D25%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26group%3Dcomp.databases.ms-sqlserver%26start%3D25
</remarks>
<param name="VarbinaryValue">binary data to be converted to Hexadecimal </param>
<returns>Hexadecimal representation of binary data, using chars [0-0a-f]</returns>
*/
CREATE FUNCTION [dbo].[Tool_VarbinaryToVarcharHex]
(
	@VarbinaryValue	VARBINARY(max)
)
RETURNS nvarchar(max) AS
	BEGIN
	DECLARE @NumberOfBytes 	INT

	SET @NumberOfBytes = DATALENGTH(@VarbinaryValue)
	-- PART ONE --
	IF (@NumberOfBytes > 4)
	BEGIN
		DECLARE @FirstHalfNumberOfBytes INT
		DECLARE @SecondHalfNumberOfBytes INT
		SET @FirstHalfNumberOfBytes  = @NumberOfBytes/2
		SET @SecondHalfNumberOfBytes = @NumberOfBytes - @FirstHalfNumberOfBytes
		-- Call this function recursively with the two parts of the input split in half
		RETURN dbo.Tool_VarbinaryToVarcharHex(CAST(SUBSTRING(@VarbinaryValue, 1					        , @FirstHalfNumberOfBytes)  AS VARBINARY(max)))
			 + dbo.Tool_VarbinaryToVarcharHex(CAST(SUBSTRING(@VarbinaryValue, @FirstHalfNumberOfBytes+1 , @SecondHalfNumberOfBytes) AS VARBINARY(max)))
	END
	
	IF (@NumberOfBytes = 0)
	BEGIN
		RETURN ''	-- No bytes found, therefore no 'hex string' is returned
	END
	
	-- PART TWO --
	DECLARE @LowByte 		INT
	DECLARE @HighByte 		INT
	-- @NumberOfBytes <= 4 (four or less characters/8 hex digits were input)
	--						 eg. 88887777 66665555 44443333 22221111
	-- We'll process ONLY the right-most (least-significant) Byte, which consists
	-- of eight bits, or two hexadecimal values (eg. 22221111 --> XY) 
	-- where XY are two hex digits [0-f]

	-- 1. Carve off the rightmost four bits/single hex digit (ie 1111)
	--    BINARY AND 15 will result in a number with maxvalue of 15
	SET @LowByte = CAST(@VarbinaryValue AS INT) & 15
	-- Now determine which ASCII char value
	SET @LowByte = CASE 
	WHEN (@LowByte < 10)		-- 9 or less, convert to digits [0-9]
		THEN (48 + @LowByte)	-- 48 ASCII = 0 ... 57 ASCII = 9
		ELSE (87 + @LowByte)	-- else 10-15, convert to chars [a-f]
	END							-- (87+10)97 ASCII = a ... (87+15_102 ASCII = f

	-- 2. Carve off the rightmost eight bits/single hex digit (ie 22221111)
	--    Divide by 16 does a shift-left (now processing 2222)
	SET @HighByte = CAST(@VarbinaryValue AS INT) & 255
	SET @HighByte = (@HighByte / 16)
	-- Again determine which ASCII char value	
	SET @HighByte = CASE 
	WHEN (@HighByte < 10)		-- 9 or less, convert to digits [0-9]
		THEN (48 + @HighByte)	-- 48 ASCII = 0 ... 57 ASCII = 9
		ELSE (87 + @HighByte)	-- else 10-15, convert to chars [a-f]
	END							-- (87+10)97 ASCII = a ... (87+15)102 ASCII = f
	
	-- 3. Trim the byte (two hex values) from the right (least significant) input Binary
	--    in preparation for further parsing
	SET @VarbinaryValue = SUBSTRING(@VarbinaryValue, 1, (@NumberOfBytes-1))

	-- 4. Recursively call this method on the remaining Binary data, concatenating the two 
	--    hexadecimal 'values' we just decoded as their ASCII character representation
	--    ie. we pass 88887777 66665555 44443333 back to this function, adding XY to the result string
	RETURN dbo.Tool_VarbinaryToVarcharHex(@VarbinaryValue) + CHAR(@HighByte) + CHAR(@LowByte)
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[LastNameCount]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[LastNameCount](@last nvarchar(20))
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @r INT
	
	SELECT @r = [count] FROM dbo._LastName WHERE LastName = @last
	RETURN @r

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[IsValidEmail]'
GO
CREATE FUNCTION [dbo].[IsValidEmail] (@addr [nvarchar] (4000))
RETURNS [bit]
WITH EXECUTE AS CALLER
EXTERNAL NAME [CmsDataSqlClr].[UserDefinedFunctions].[IsValidEmail]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[SundayForWeek]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SundayForWeek](@year INT, @week INT)
RETURNS datetime
AS
BEGIN

DECLARE @dt DATETIME 
SELECT @dt = DATEADD(MONTH,((@year-1900)*12),0) -- jan 1 for year
SELECT @dt = DATEADD(MONTH, 9, @dt) -- Oct 1 for year
SELECT @dt = DATEADD(d, -DATEPART(dw, @dt)+1, @dt) -- sunday of that week
IF DATEPART(MONTH, @dt) < 10 -- are we in september now?
	SELECT @dt = DATEADD(d, 7, @dt) -- next sunday (to get into october)
SELECT @dt = DATEADD(ww, @week - 1, @dt) -- sunday for week number

	-- Return the result of the function
	RETURN @dt

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StartsLower]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[StartsLower] (@s NVARCHAR) 
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ret bit

	SELECT @ret = 0
	-- Add the T-SQL statements to compute the return value here
	SELECT @ret = 1 WHERE @s COLLATE Latin1_General_BIN2 > 'Z'


	-- Return the result of the function
	RETURN @ret

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DollarRange]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DollarRange](@amt DECIMAL)
RETURNS int
AS
BEGIN
DECLARE @ret INT 
	SELECT @ret =
	CASE
		WHEN @amt IS NULL THEN 1
		WHEN @amt < 101 THEN 1
		WHEN @amt < 251 THEN 2
		WHEN @amt < 501 THEN 3
		WHEN @amt < 751 THEN 4
		WHEN @amt < 1001 THEN 5
		WHEN @amt < 2001 THEN 6
		WHEN @amt < 3001 THEN 7
		WHEN @amt < 4001 THEN 8
		WHEN @amt < 5001 THEN 9
		WHEN @amt < 10001 THEN 10
		WHEN @amt < 20001 THEN 11
		WHEN @amt < 30001 THEN 12
		WHEN @amt < 40001 THEN 13
		WHEN @amt < 50001 THEN 14
		WHEN @amt < 100001 THEN 15
		ELSE 16
	END 
	RETURN @ret
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DayAndTime]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DayAndTime] (@dt DATETIME)
RETURNS nvarchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @daytime nvarchar(20)

SELECT @daytime =
	CASE DATEPART(dw,@dt)
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
    END + ' ' + SUBSTRING(CONVERT(nvarchar,@dt,0),13,7)
    
	RETURN @daytime

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[FirstMondayOfMonth]'
GO
CREATE FUNCTION [dbo].[FirstMondayOfMonth] (@inputDate DATETIME)RETURNS DATETIME BEGIN     RETURN DATEADD(wk, DATEDIFF(wk, 0, dateadd(dd, 6 - datepart(day, @inputDate), @inputDate)), 0)  END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ComputeAge]'
GO
CREATE FUNCTION [dbo].[ComputeAge] (@m int, @d int, @y int )
RETURNS int
AS
	BEGIN
	
	  DECLARE
		@v_return int, 
		@v_end_date datetime,
		@p_deceased_date datetime,
		@p_drop_code_id int
		
         SET @v_return = NULL

         IF @y IS NOT NULL 
            BEGIN

               SET @v_return = datepart(YEAR, GETDATE()) - @y

               IF isnull(@m, 1) > datepart(MONTH, GETDATE())
                  SET @v_return = @v_return - 1
               ELSE 
                  IF isnull(@m, 1) = datepart(MONTH, GETDATE()) AND isnull(@d, 1) > datepart(DAY, GETDATE())
                     SET @v_return = @v_return - 1

            END

	RETURN @v_return
	END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[AddToOrgFromTagRun]'
GO
CREATE TABLE [dbo].[AddToOrgFromTagRun]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[orgid] [int] NULL,
[started] [datetime] NULL,
[count] [int] NULL,
[processed] [int] NULL,
[completed] [datetime] NULL,
[error] [nvarchar] (200) NULL,
[running] AS (case when [completed] IS NULL AND [error] IS NULL AND datediff(minute,[started],getdate())<(120) then (1) else (0) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_AddToOrgFromTagRun] on [dbo].[AddToOrgFromTagRun]'
GO
ALTER TABLE [dbo].[AddToOrgFromTagRun] ADD CONSTRAINT [PK_AddToOrgFromTagRun] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Address]'
GO
CREATE TABLE [dbo].[Address]
(
[Id] [int] NOT NULL,
[Address] [nvarchar] (50) NULL,
[Address2] [nvarchar] (50) NULL,
[City] [nvarchar] (50) NULL,
[State] [nvarchar] (50) NULL,
[Zip] [nvarchar] (50) NULL,
[BadAddress] [bit] NULL,
[FromDt] [datetime] NULL,
[ToDt] [datetime] NULL,
[Type] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Address] on [dbo].[Address]'
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[CheckedBatches]'
GO
CREATE TABLE [dbo].[CheckedBatches]
(
[BatchRef] [nvarchar] (50) NOT NULL,
[Checked] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_CheckedBatches] on [dbo].[CheckedBatches]'
GO
ALTER TABLE [dbo].[CheckedBatches] ADD CONSTRAINT [PK_CheckedBatches] PRIMARY KEY CLUSTERED  ([BatchRef])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ChurchAttReportIds]'
GO
CREATE TABLE [dbo].[ChurchAttReportIds]
(
[Name] [nvarchar] (40) NOT NULL,
[Id] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ChurchAttReportIds] on [dbo].[ChurchAttReportIds]'
GO
ALTER TABLE [dbo].[ChurchAttReportIds] ADD CONSTRAINT [PK_ChurchAttReportIds] PRIMARY KEY CLUSTERED  ([Name])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ContributionsRun]'
GO
CREATE TABLE [dbo].[ContributionsRun]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[started] [datetime] NULL,
[count] [int] NULL,
[processed] [int] NULL,
[completed] [datetime] NULL,
[error] [nvarchar] (200) NULL,
[LastSet] [int] NULL,
[CurrSet] [int] NULL,
[Sets] [nvarchar] (50) NULL,
[running] AS (case when [completed] IS NULL AND [error] IS NULL AND datediff(minute,[started],getdate())<(120) then (1) else (0) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContributionsRun] on [dbo].[ContributionsRun]'
GO
ALTER TABLE [dbo].[ContributionsRun] ADD CONSTRAINT [PK_ContributionsRun] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DuplicatesRun]'
GO
CREATE TABLE [dbo].[DuplicatesRun]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[started] [datetime] NULL,
[count] [int] NULL,
[processed] [int] NULL,
[found] [int] NULL,
[completed] [datetime] NULL,
[error] [nvarchar] (200) NULL,
[running] AS (case when [completed] IS NULL AND [error] IS NULL AND datediff(minute,[started],getdate())<(120) then (1) else (0) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_DuplicatesRun] on [dbo].[DuplicatesRun]'
GO
ALTER TABLE [dbo].[DuplicatesRun] ADD CONSTRAINT [PK_DuplicatesRun] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailLog]'
GO
CREATE TABLE [dbo].[EmailLog]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[fromaddr] [nvarchar] (50) NULL,
[toaddr] [nvarchar] (150) NULL,
[time] [datetime] NULL,
[subject] [nvarchar] (180) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailLog] on [dbo].[EmailLog]'
GO
ALTER TABLE [dbo].[EmailLog] ADD CONSTRAINT [PK_EmailLog] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[EmailQueueToFail]'
GO
CREATE TABLE [dbo].[EmailQueueToFail]
(
[Id] [int] NULL,
[PeopleId] [int] NULL,
[time] [datetime] NULL,
[event] [nvarchar] (20) NULL,
[reason] [nvarchar] (300) NULL,
[bouncetype] [nvarchar] (20) NULL,
[email] [nvarchar] (100) NULL,
[pkey] [int] NOT NULL IDENTITY(1, 1),
[timestamp] [bigint] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_EmailQueueToFail] on [dbo].[EmailQueueToFail]'
GO
ALTER TABLE [dbo].[EmailQueueToFail] ADD CONSTRAINT [PK_EmailQueueToFail] PRIMARY KEY CLUSTERED  ([pkey])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_EmailQueueToFail_1] on [dbo].[EmailQueueToFail]'
GO
CREATE NONCLUSTERED INDEX [IX_EmailQueueToFail_1] ON [dbo].[EmailQueueToFail] ([Id], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_EmailQueueToFail] on [dbo].[EmailQueueToFail]'
GO
CREATE NONCLUSTERED INDEX [IX_EmailQueueToFail] ON [dbo].[EmailQueueToFail] ([time])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_EmailQueueToFail_2] on [dbo].[EmailQueueToFail]'
GO
CREATE NONCLUSTERED INDEX [IX_EmailQueueToFail_2] ON [dbo].[EmailQueueToFail] ([timestamp])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[QueryStats]'
GO
CREATE TABLE [dbo].[QueryStats]
(
[RunId] [int] NOT NULL,
[StatId] [nvarchar] (5) NOT NULL,
[Runtime] [datetime] NOT NULL,
[Description] [nvarchar] (75) NOT NULL,
[Count] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_QueryStat] on [dbo].[QueryStats]'
GO
ALTER TABLE [dbo].[QueryStats] ADD CONSTRAINT [PK_QueryStat] PRIMARY KEY CLUSTERED  ([RunId], [StatId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_QueryStat] on [dbo].[QueryStats]'
GO
CREATE NONCLUSTERED INDEX [IX_QueryStat] ON [dbo].[QueryStats] ([Runtime])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[PrintJob]'
GO
CREATE TABLE [dbo].[PrintJob]
(
[Id] [nvarchar] (50) NOT NULL,
[Stamp] [datetime] NOT NULL,
[Data] [nvarchar] (max) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TempData] on [dbo].[PrintJob]'
GO
ALTER TABLE [dbo].[PrintJob] ADD CONSTRAINT [PK_TempData] PRIMARY KEY CLUSTERED  ([Id], [Stamp])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrgContent]'
GO
CREATE TABLE [dbo].[OrgContent]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[OrgId] [int] NULL,
[AllowInactive] [bit] NULL,
[PublicView] [bit] NULL,
[ImageId] [int] NULL,
[Landing] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrgContent] on [dbo].[OrgContent]'
GO
ALTER TABLE [dbo].[OrgContent] ADD CONSTRAINT [PK_OrgContent] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_OrgContent] on [dbo].[OrgContent]'
GO
CREATE NONCLUSTERED INDEX [IX_OrgContent] ON [dbo].[OrgContent] ([OrgId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[StreetTypes]'
GO
CREATE TABLE [dbo].[StreetTypes]
(
[Type] [nvarchar] (50) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_StreetTypes] on [dbo].[StreetTypes]'
GO
ALTER TABLE [dbo].[StreetTypes] ADD CONSTRAINT [PK_StreetTypes] PRIMARY KEY CLUSTERED  ([Type])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[UploadPeopleRun]'
GO
CREATE TABLE [dbo].[UploadPeopleRun]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[meetingid] [int] NULL,
[started] [datetime] NULL,
[count] [int] NULL,
[processed] [int] NULL,
[completed] [datetime] NULL,
[error] [nvarchar] (200) NULL,
[running] AS (case when [completed] IS NULL AND [error] IS NULL AND datediff(minute,[started],getdate())<(120) then (1) else (0) end)
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_UploadPeopleRun] on [dbo].[UploadPeopleRun]'
GO
ALTER TABLE [dbo].[UploadPeopleRun] ADD CONSTRAINT [PK_UploadPeopleRun] PRIMARY KEY CLUSTERED  ([id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[TagType]'
GO
CREATE TABLE [dbo].[TagType]
(
[Id] [int] NOT NULL,
[Name] [nvarchar] (50) NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_TagTypes] on [dbo].[TagType]'
GO
ALTER TABLE [dbo].[TagType] ADD CONSTRAINT [PK_TagTypes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[Country]'
GO
CREATE TABLE [lookup].[Country]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (10) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Country] on [lookup].[Country]'
GO
ALTER TABLE [lookup].[Country] ADD CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[FamilyMemberType]'
GO
CREATE TABLE [lookup].[FamilyMemberType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FamilyMemberType] on [lookup].[FamilyMemberType]'
GO
ALTER TABLE [lookup].[FamilyMemberType] ADD CONSTRAINT [PK_FamilyMemberType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[FamilyRelationship]'
GO
CREATE TABLE [lookup].[FamilyRelationship]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_FamilyRelationship] on [lookup].[FamilyRelationship]'
GO
ALTER TABLE [lookup].[FamilyRelationship] ADD CONSTRAINT [PK_FamilyRelationship] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[MeetingType]'
GO
CREATE TABLE [lookup].[MeetingType]
(
[Id] [int] NOT NULL,
[Code] [char] (1) NULL,
[Description] [nvarchar] (10) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MeetingType] on [lookup].[MeetingType]'
GO
ALTER TABLE [lookup].[MeetingType] ADD CONSTRAINT [PK_MeetingType] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[NameTitle]'
GO
CREATE TABLE [lookup].[NameTitle]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_NameTitle] on [lookup].[NameTitle]'
GO
ALTER TABLE [lookup].[NameTitle] ADD CONSTRAINT [PK_NameTitle] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ZipCodes]'
GO
CREATE TABLE [dbo].[ZipCodes]
(
[zip] [nvarchar] (10) NOT NULL,
[state] [char] (2) NULL,
[City] [nvarchar] (50) NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ZipCodes] on [dbo].[ZipCodes]'
GO
ALTER TABLE [dbo].[ZipCodes] ADD CONSTRAINT [PK_ZipCodes] PRIMARY KEY CLUSTERED  ([zip])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[PostalLookup]'
GO
CREATE TABLE [lookup].[PostalLookup]
(
[PostalCode] [nvarchar] (15) NOT NULL,
[CityName] [nvarchar] (20) NULL,
[StateCode] [nvarchar] (20) NULL,
[CountryName] [nvarchar] (30) NULL,
[ResCodeId] [int] NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_POSTAL_LOOKUP_TBL] on [lookup].[PostalLookup]'
GO
ALTER TABLE [lookup].[PostalLookup] ADD CONSTRAINT [PK_POSTAL_LOOKUP_TBL] PRIMARY KEY CLUSTERED  ([PostalCode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [POSTAL_LOOKUP_CODE_IX] on [lookup].[PostalLookup]'
GO
CREATE NONCLUSTERED INDEX [POSTAL_LOOKUP_CODE_IX] ON [lookup].[PostalLookup] ([PostalCode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ShirtSizes]'
GO
CREATE TABLE [lookup].[ShirtSizes]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (10) NULL,
[Description] [nvarchar] (50) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ShirtSizes] on [lookup].[ShirtSizes]'
GO
ALTER TABLE [lookup].[ShirtSizes] ADD CONSTRAINT [PK_ShirtSizes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[StateLookup]'
GO
CREATE TABLE [lookup].[StateLookup]
(
[StateCode] [nvarchar] (10) NOT NULL,
[StateName] [nvarchar] (30) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_STATE_LOOKUP_TBL] on [lookup].[StateLookup]'
GO
ALTER TABLE [lookup].[StateLookup] ADD CONSTRAINT [PK_STATE_LOOKUP_TBL] PRIMARY KEY CLUSTERED  ([StateCode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [STATE_LOOKUP_CODE_IX] on [lookup].[StateLookup]'
GO
CREATE NONCLUSTERED INDEX [STATE_LOOKUP_CODE_IX] ON [lookup].[StateLookup] ([StateCode])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[AddressType]'
GO
CREATE TABLE [lookup].[AddressType]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK__AddressType__148954CD] on [lookup].[AddressType]'
GO
ALTER TABLE [lookup].[AddressType] ADD CONSTRAINT [PK__AddressType__148954CD] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[BackgroundCheckLabels]'
GO
CREATE TABLE [lookup].[BackgroundCheckLabels]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BackgroundCheckLabels] on [lookup].[BackgroundCheckLabels]'
GO
ALTER TABLE [lookup].[BackgroundCheckLabels] ADD CONSTRAINT [PK_BackgroundCheckLabels] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[BuildingAccessTypes]'
GO
CREATE TABLE [lookup].[BuildingAccessTypes]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BuildingAccessTypes] on [lookup].[BuildingAccessTypes]'
GO
ALTER TABLE [lookup].[BuildingAccessTypes] ADD CONSTRAINT [PK_BuildingAccessTypes] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [lookup].[ContactPreference]'
GO
CREATE TABLE [lookup].[ContactPreference]
(
[Id] [int] NOT NULL,
[Code] [nvarchar] (20) NULL,
[Description] [nvarchar] (100) NULL,
[Hardwired] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_ContactPreference] on [lookup].[ContactPreference]'
GO
ALTER TABLE [lookup].[ContactPreference] ADD CONSTRAINT [PK_ContactPreference] PRIMARY KEY CLUSTERED  ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[RandNumber]'
GO
CREATE VIEW [dbo].[RandNumber]
AS
SELECT RAND() as RandNumber
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Sprocs]'
GO

CREATE VIEW [dbo].Sprocs
AS
SELECT ROUTINE_TYPE type, ROUTINE_NAME Name, ROUTINE_DEFINITION Code
    FROM INFORMATION_SCHEMA.ROUTINES 
    WHERE ROUTINE_TYPE IN ('FUNCTION','PROCEDURE')
    AND SPECIFIC_NAME NOT LIKE 'sp_%'
    AND SPECIFIC_NAME NOT LIKE 'fn_%'

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Triggers]'
GO

CREATE VIEW [dbo].[Triggers]
AS
SELECT TOP (100) PERCENT Tables.name AS TableName, Triggers.name AS TriggerName, Triggers.crdate AS TriggerCreatedDate, Comments.text AS Code
FROM  sys.sysobjects AS Triggers INNER JOIN
               sys.sysobjects AS Tables ON Triggers.parent_obj = Tables.id INNER JOIN
               sys.syscomments AS Comments ON Triggers.id = Comments.id
WHERE (Triggers.xtype = 'TR') AND (Tables.xtype = 'U')
ORDER BY TableName, TriggerName

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[sp_who3]'
GO
CREATE PROCEDURE [dbo].[sp_who3]
AS
BEGIN
DECLARE @sp_who2 TABLE 
( 
    SPID INT, 
    Status nvarchar(255) NULL, 
    Login SYSNAME NULL, 
    HostName SYSNAME NULL, 
    BlkBy SYSNAME NULL, 
    DBName SYSNAME NULL, 
    Command nvarchar(255) NULL, 
    CPUTime INT NULL, 
    DiskIO INT NULL, 
    LastBatch nvarchar(255) NULL, 
    ProgramName nvarchar(255) NULL, 
    SPID2 INT,
    REQUESTID INT
) 
 
INSERT @sp_who2 EXEC sp_who2 
 
SELECT * FROM @sp_who2
    WHERE DbName LIKE 'CMS_%' AND Status <> 'sleeping' AND Command <> 'CHECKPOINT'	AND ProgramName NOT LIKE 'Microsoft%'	
    RETURN
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DisableForeignKeys]'
GO
CREATE PROCEDURE [dbo].[DisableForeignKeys]
    @disable BIT = 1
AS
    DECLARE
        @sql nvarchar(500),
        @tableName nvarchar(128),
        @foreignKeyName nvarchar(128),
		@schema nvarchar(50)

    -- A list of all foreign keys and table names
    DECLARE foreignKeyCursor CURSOR
    FOR SELECT
        ref.constraint_name AS FK_Name,
        fk.table_name AS FK_Table,
		ref.Constraint_schema as FK_Schema
    FROM
        INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS ref
        INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS fk 
    ON ref.constraint_name = fk.constraint_name
    ORDER BY
        fk.table_name,
        ref.constraint_name 

    OPEN foreignKeyCursor

    FETCH NEXT FROM foreignKeyCursor 
    INTO @foreignKeyName, @tableName, @schema

    WHILE ( @@FETCH_STATUS = 0 )
        BEGIN
            IF @disable = 1
                SET @sql = 'ALTER TABLE ' + @schema + '.[' 
                    + @tableName + '] NOCHECK CONSTRAINT ['
                    + @foreignKeyName + ']'
            ELSE
                SET @sql = 'ALTER TABLE ' + @schema + '.[' 
                    + @tableName + '] CHECK CONSTRAINT ['
                    + @foreignKeyName + ']'

        PRINT 'Executing Statement - ' + @sql

        EXECUTE(@sql)
        FETCH NEXT FROM foreignKeyCursor 
        INTO @foreignKeyName, @tableName, @schema
    END

    CLOSE foreignKeyCursor
    DEALLOCATE foreignKeyCursor
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[ShowTableSizes]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShowTableSizes]
AS
BEGIN
CREATE TABLE #temp (
       table_name sysname ,
       row_count int,
       reserved_size nvarchar(50),
       data_size nvarchar(50),
       index_size nvarchar(50),
       unused_size nvarchar(50))
SET NOCOUNT ON
INSERT     #temp
EXEC       sp_msforeachtable 'sp_spaceused ''?'''
SELECT     b.table_schema as owner,
		   a.table_name,
           a.row_count,
           count(*) as col_count,
           a.data_size
FROM       #temp a
INNER JOIN information_schema.columns b
           ON a.table_name collate database_default
                = b.table_name collate database_default
GROUP BY   b.table_schema, a.table_name, a.row_count, a.data_size
ORDER BY   a.row_count desc
DROP TABLE #temp
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Attend]'
GO
ALTER TABLE [dbo].[Attend] WITH NOCHECK  ADD CONSTRAINT [FK_AttendWithAbsents_TBL_ORGANIZATIONS_TBL] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[Attend] WITH NOCHECK  ADD CONSTRAINT [FK_AttendWithAbsents_TBL_AttendType] FOREIGN KEY ([AttendanceTypeId]) REFERENCES [lookup].[AttendType] ([Id])
ALTER TABLE [dbo].[Attend] WITH NOCHECK  ADD CONSTRAINT [FK_Attend_MemberType] FOREIGN KEY ([MemberTypeId]) REFERENCES [lookup].[MemberType] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BundleDetail]'
GO
ALTER TABLE [dbo].[BundleDetail] WITH NOCHECK  ADD CONSTRAINT [BUNDLE_DETAIL_BUNDLE_FK] FOREIGN KEY ([BundleHeaderId]) REFERENCES [dbo].[BundleHeader] ([BundleHeaderId])
ALTER TABLE [dbo].[BundleDetail] WITH NOCHECK  ADD CONSTRAINT [BUNDLE_DETAIL_CONTR_FK] FOREIGN KEY ([ContributionId]) REFERENCES [dbo].[Contribution] ([ContributionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BundleHeader]'
GO
ALTER TABLE [dbo].[BundleHeader] WITH NOCHECK  ADD CONSTRAINT [FK_BUNDLE_HEADER_TBL_BundleStatusTypes] FOREIGN KEY ([BundleStatusId]) REFERENCES [lookup].[BundleStatusTypes] ([Id])
ALTER TABLE [dbo].[BundleHeader] WITH NOCHECK  ADD CONSTRAINT [FK_BUNDLE_HEADER_TBL_BundleHeaderTypes] FOREIGN KEY ([BundleHeaderTypeId]) REFERENCES [lookup].[BundleHeaderTypes] ([Id])
ALTER TABLE [dbo].[BundleHeader] WITH NOCHECK  ADD CONSTRAINT [BundleHeaders__Fund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[ContributionFund] ([FundId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ChangeDetails]'
GO
ALTER TABLE [dbo].[ChangeDetails] WITH NOCHECK  ADD CONSTRAINT [FK_ChangeDetails_ChangeLog] FOREIGN KEY ([Id]) REFERENCES [dbo].[ChangeLog] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Contact]'
GO
ALTER TABLE [dbo].[Contact] WITH NOCHECK  ADD CONSTRAINT [FK_Contacts_ContactTypes] FOREIGN KEY ([ContactTypeId]) REFERENCES [lookup].[ContactType] ([Id])
ALTER TABLE [dbo].[Contact] WITH NOCHECK  ADD CONSTRAINT [FK_NewContacts_ContactReasons] FOREIGN KEY ([ContactReasonId]) REFERENCES [lookup].[ContactReason] ([Id])
ALTER TABLE [dbo].[Contact] WITH NOCHECK  ADD CONSTRAINT [FK_Contacts_Ministries] FOREIGN KEY ([MinistryId]) REFERENCES [dbo].[Ministries] ([MinistryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ContentKeyWords]'
GO
ALTER TABLE [dbo].[ContentKeyWords] WITH NOCHECK  ADD CONSTRAINT [FK_ContentKeyWords_Content] FOREIGN KEY ([Id]) REFERENCES [dbo].[Content] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Contribution]'
GO
ALTER TABLE [dbo].[Contribution] WITH NOCHECK  ADD CONSTRAINT [FK_Contribution_ContributionFund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[ContributionFund] ([FundId])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK  ADD CONSTRAINT [FK_Contribution_ContributionType] FOREIGN KEY ([ContributionTypeId]) REFERENCES [lookup].[ContributionType] ([Id])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK  ADD CONSTRAINT [FK_Contribution_ContributionStatus] FOREIGN KEY ([ContributionStatusId]) REFERENCES [lookup].[ContributionStatus] ([Id])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK  ADD CONSTRAINT [FK_Contribution_ExtraData] FOREIGN KEY ([ExtraDataId]) REFERENCES [dbo].[ExtraData] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RecurringAmounts]'
GO
ALTER TABLE [dbo].[RecurringAmounts] WITH NOCHECK  ADD CONSTRAINT [FK_RecurringAmounts_ContributionFund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[ContributionFund] ([FundId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Coupons]'
GO
ALTER TABLE [dbo].[Coupons] WITH NOCHECK  ADD CONSTRAINT [FK_Coupons_Division] FOREIGN KEY ([DivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[Coupons] WITH NOCHECK  ADD CONSTRAINT [FK_Coupons_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Promotion]'
GO
ALTER TABLE [dbo].[Promotion] WITH NOCHECK  ADD CONSTRAINT [FromPromotions__FromDivision] FOREIGN KEY ([FromDivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[Promotion] WITH NOCHECK  ADD CONSTRAINT [ToPromotions__ToDivision] FOREIGN KEY ([ToDivId]) REFERENCES [dbo].[Division] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RelatedFamilies]'
GO
ALTER TABLE [dbo].[RelatedFamilies] WITH NOCHECK  ADD CONSTRAINT [RelatedFamilies1__RelatedFamily1] FOREIGN KEY ([FamilyId]) REFERENCES [dbo].[Families] ([FamilyId])
ALTER TABLE [dbo].[RelatedFamilies] WITH NOCHECK  ADD CONSTRAINT [RelatedFamilies2__RelatedFamily2] FOREIGN KEY ([RelatedFamilyId]) REFERENCES [dbo].[Families] ([FamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EnrollmentTransaction]'
GO
ALTER TABLE [dbo].[EnrollmentTransaction] WITH NOCHECK  ADD CONSTRAINT [ENROLLMENT_TRANSACTION_ORG_FK] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[EnrollmentTransaction] WITH NOCHECK  ADD CONSTRAINT [ENROLLMENT_TRANSACTION_PPL_FK] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[EnrollmentTransaction] WITH NOCHECK  ADD CONSTRAINT [FK_ENROLLMENT_TRANSACTION_TBL_MemberType] FOREIGN KEY ([MemberTypeId]) REFERENCES [lookup].[MemberType] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Meetings]'
GO
ALTER TABLE [dbo].[Meetings] WITH NOCHECK  ADD CONSTRAINT [FK_MEETINGS_TBL_ORGANIZATIONS_TBL] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[Meetings] WITH NOCHECK  ADD CONSTRAINT [FK_Meetings_AttendCredit] FOREIGN KEY ([AttendCreditId]) REFERENCES [lookup].[AttendCredit] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[MemberTags]'
GO
ALTER TABLE [dbo].[MemberTags] WITH NOCHECK  ADD CONSTRAINT [FK_MemberTags_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[OrganizationExtra]'
GO
ALTER TABLE [dbo].[OrganizationExtra] WITH NOCHECK  ADD CONSTRAINT [FK_OrganizationExtra_Organizations] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[OrganizationMembers]'
GO
ALTER TABLE [dbo].[OrganizationMembers] WITH NOCHECK  ADD CONSTRAINT [ORGANIZATION_MEMBERS_ORG_FK] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[OrganizationMembers] WITH NOCHECK  ADD CONSTRAINT [ORGANIZATION_MEMBERS_PPL_FK] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId]) ON DELETE CASCADE
ALTER TABLE [dbo].[OrganizationMembers] WITH NOCHECK  ADD CONSTRAINT [FK_ORGANIZATION_MEMBERS_TBL_MemberType] FOREIGN KEY ([MemberTypeId]) REFERENCES [lookup].[MemberType] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TagPerson]'
GO
ALTER TABLE [dbo].[TagPerson] WITH NOCHECK  ADD CONSTRAINT [Tags__Person] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[TagPerson] WITH NOCHECK  ADD CONSTRAINT [PersonTags__Tag] FOREIGN KEY ([Id]) REFERENCES [dbo].[Tag] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Organizations]'
GO
ALTER TABLE [dbo].[Organizations] WITH NOCHECK  ADD CONSTRAINT [ChildOrgs__ParentOrg] FOREIGN KEY ([ParentOrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[QueryBuilderClauses]'
GO
ALTER TABLE [dbo].[QueryBuilderClauses] WITH NOCHECK  ADD CONSTRAINT [Clauses__Parent] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[QueryBuilderClauses] ([QueryId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Volunteer]'
GO
ALTER TABLE [dbo].[Volunteer] WITH NOCHECK  ADD CONSTRAINT [FK_Volunteer_VolApplicationStatus] FOREIGN KEY ([StatusId]) REFERENCES [lookup].[VolApplicationStatus] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Task]'
GO
ALTER TABLE [dbo].[Task] WITH NOCHECK  ADD CONSTRAINT [Tasks__TaskList] FOREIGN KEY ([ListId]) REFERENCES [dbo].[TaskList] ([Id])
ALTER TABLE [dbo].[Task] WITH NOCHECK  ADD CONSTRAINT [CoTasks__CoTaskList] FOREIGN KEY ([CoListId]) REFERENCES [dbo].[TaskList] ([Id])
ALTER TABLE [dbo].[Task] WITH NOCHECK  ADD CONSTRAINT [FK_Task_TaskStatus] FOREIGN KEY ([StatusId]) REFERENCES [lookup].[TaskStatus] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[VoluteerApprovalIds]'
GO
ALTER TABLE [dbo].[VoluteerApprovalIds] WITH NOCHECK  ADD CONSTRAINT [FK_VoluteerApprovalIds_VolunteerCodes] FOREIGN KEY ([ApprovalId]) REFERENCES [lookup].[VolunteerCodes] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TaskListOwners]'
GO
ALTER TABLE [dbo].[TaskListOwners] WITH NOCHECK  ADD CONSTRAINT [FK_TaskListOwners_TaskList] FOREIGN KEY ([TaskListId]) REFERENCES [dbo].[TaskList] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Zips]'
GO
ALTER TABLE [dbo].[Zips] WITH NOCHECK  ADD CONSTRAINT [FK_Zips_ResidentCode] FOREIGN KEY ([MetroMarginalCode]) REFERENCES [lookup].[ResidentCode] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ActivityLog]'
GO
ALTER TABLE [dbo].[ActivityLog] ADD CONSTRAINT [FK_ActivityLog_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
ALTER TABLE [dbo].[ActivityLog] ADD CONSTRAINT [FK_ActivityLog_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[ActivityLog] ADD CONSTRAINT [FK_ActivityLog_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Attend]'
GO
ALTER TABLE [dbo].[Attend] ADD CONSTRAINT [FK_AttendWithAbsents_TBL_PEOPLE_TBL] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Attend] ADD CONSTRAINT [FK_AttendWithAbsents_TBL_MEETINGS_TBL] FOREIGN KEY ([MeetingId]) REFERENCES [dbo].[Meetings] ([MeetingId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[SubRequest]'
GO
ALTER TABLE [dbo].[SubRequest] ADD CONSTRAINT [SubRequests__Attend] FOREIGN KEY ([AttendId]) REFERENCES [dbo].[Attend] ([AttendId])
ALTER TABLE [dbo].[SubRequest] ADD CONSTRAINT [SubRequests__Requestor] FOREIGN KEY ([RequestorId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[SubRequest] ADD CONSTRAINT [SubResponses__Substitute] FOREIGN KEY ([SubstituteId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BackgroundChecks]'
GO
ALTER TABLE [dbo].[BackgroundChecks] ADD CONSTRAINT [People__User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[BackgroundChecks] ADD CONSTRAINT [FK_BackgroundChecks_People] FOREIGN KEY ([PeopleID]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[CardIdentifiers]'
GO
ALTER TABLE [dbo].[CardIdentifiers] ADD CONSTRAINT [FK_CardIdentifiers_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[CheckInActivity]'
GO
ALTER TABLE [dbo].[CheckInActivity] ADD CONSTRAINT [FK_CheckInActivity_CheckInTimes] FOREIGN KEY ([Id]) REFERENCES [dbo].[CheckInTimes] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[AuditValues]'
GO
ALTER TABLE [dbo].[AuditValues] ADD CONSTRAINT [FK_AuditValues_Audits] FOREIGN KEY ([AuditId]) REFERENCES [dbo].[Audits] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Contactees]'
GO
ALTER TABLE [dbo].[Contactees] ADD CONSTRAINT [contactees__contact] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Contact] ([ContactId])
ALTER TABLE [dbo].[Contactees] ADD CONSTRAINT [contactsHad__person] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Contactors]'
GO
ALTER TABLE [dbo].[Contactors] ADD CONSTRAINT [contactsMakers__contact] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Contact] ([ContactId])
ALTER TABLE [dbo].[Contactors] ADD CONSTRAINT [contactsMade__person] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Task]'
GO
ALTER TABLE [dbo].[Task] ADD CONSTRAINT [TasksAssigned__SourceContact] FOREIGN KEY ([SourceContactId]) REFERENCES [dbo].[Contact] ([ContactId])
ALTER TABLE [dbo].[Task] ADD CONSTRAINT [TasksCompleted__CompletedContact] FOREIGN KEY ([CompletedContactId]) REFERENCES [dbo].[Contact] ([ContactId])
ALTER TABLE [dbo].[Task] ADD CONSTRAINT [Tasks__Owner] FOREIGN KEY ([OwnerId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Task] ADD CONSTRAINT [TasksAboutPerson__AboutWho] FOREIGN KEY ([WhoId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Task] ADD CONSTRAINT [TasksCoOwned__CoOwner] FOREIGN KEY ([CoOwnerId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[CheckInTimes]'
GO
ALTER TABLE [dbo].[CheckInTimes] ADD CONSTRAINT [Guests__GuestOf] FOREIGN KEY ([GuestOfId]) REFERENCES [dbo].[CheckInTimes] ([Id])
ALTER TABLE [dbo].[CheckInTimes] ADD CONSTRAINT [FK_CheckInTimes_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Contribution]'
GO
ALTER TABLE [dbo].[Contribution] ADD CONSTRAINT [FK_Contribution_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[DivOrg]'
GO
ALTER TABLE [dbo].[DivOrg] ADD CONSTRAINT [FK_DivOrg_Division] FOREIGN KEY ([DivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[DivOrg] ADD CONSTRAINT [FK_DivOrg_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Organizations]'
GO
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_Division] FOREIGN KEY ([DivisionId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_ORGANIZATIONS_TBL_OrganizationStatus] FOREIGN KEY ([OrganizationStatusId]) REFERENCES [lookup].[OrganizationStatus] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_ORGANIZATIONS_TBL_EntryPoint] FOREIGN KEY ([EntryPointId]) REFERENCES [lookup].[EntryPoint] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_Campus] FOREIGN KEY ([CampusId]) REFERENCES [lookup].[Campus] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_Gender] FOREIGN KEY ([GenderId]) REFERENCES [lookup].[Gender] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_OrganizationType] FOREIGN KEY ([OrganizationTypeId]) REFERENCES [lookup].[OrganizationType] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ProgDiv]'
GO
ALTER TABLE [dbo].[ProgDiv] ADD CONSTRAINT [FK_ProgDiv_Division] FOREIGN KEY ([DivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[ProgDiv] ADD CONSTRAINT [FK_ProgDiv_Program] FOREIGN KEY ([ProgId]) REFERENCES [dbo].[Program] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Division]'
GO
ALTER TABLE [dbo].[Division] ADD CONSTRAINT [FK_Division_Program] FOREIGN KEY ([ProgId]) REFERENCES [dbo].[Program] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EmailLinks]'
GO
ALTER TABLE [dbo].[EmailLinks] ADD CONSTRAINT [FK_EmailLinks_EmailQueue] FOREIGN KEY ([EmailID]) REFERENCES [dbo].[EmailQueue] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Coupons]'
GO
ALTER TABLE [dbo].[Coupons] ADD CONSTRAINT [FK_Coupons_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Coupons] ADD CONSTRAINT [FK_Coupons_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EmailOptOut]'
GO
ALTER TABLE [dbo].[EmailOptOut] ADD CONSTRAINT [FK_EmailOptOut_People] FOREIGN KEY ([ToPeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EmailQueueTo]'
GO
ALTER TABLE [dbo].[EmailQueueTo] ADD CONSTRAINT [FK_EmailQueueTo_EmailQueue] FOREIGN KEY ([Id]) REFERENCES [dbo].[EmailQueue] ([Id])
ALTER TABLE [dbo].[EmailQueueTo] ADD CONSTRAINT [FK_EmailQueueTo_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EmailResponses]'
GO
ALTER TABLE [dbo].[EmailResponses] ADD CONSTRAINT [FK_EmailResponses_EmailQueue] FOREIGN KEY ([EmailQueueId]) REFERENCES [dbo].[EmailQueue] ([Id])
ALTER TABLE [dbo].[EmailResponses] ADD CONSTRAINT [FK_EmailResponses_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EmailQueue]'
GO
ALTER TABLE [dbo].[EmailQueue] ADD CONSTRAINT [FK_EmailQueue_People] FOREIGN KEY ([QueuedBy]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[FamilyCheckinLock]'
GO
ALTER TABLE [dbo].[FamilyCheckinLock] ADD CONSTRAINT [FK_FamilyCheckinLock_FamilyCheckinLock1] FOREIGN KEY ([FamilyId]) REFERENCES [dbo].[Families] ([FamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[FamilyExtra]'
GO
ALTER TABLE [dbo].[FamilyExtra] ADD CONSTRAINT [FK_FamilyExtra_Family] FOREIGN KEY ([FamilyId]) REFERENCES [dbo].[Families] ([FamilyId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[People]'
GO
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Families] FOREIGN KEY ([FamilyId]) REFERENCES [dbo].[Families] ([FamilyId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_DropType] FOREIGN KEY ([DropCodeId]) REFERENCES [lookup].[DropType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Gender] FOREIGN KEY ([GenderId]) REFERENCES [lookup].[Gender] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_MaritalStatus] FOREIGN KEY ([MaritalStatusId]) REFERENCES [lookup].[MaritalStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_FamilyPosition] FOREIGN KEY ([PositionInFamilyId]) REFERENCES [lookup].[FamilyPosition] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_MemberStatus] FOREIGN KEY ([MemberStatusId]) REFERENCES [lookup].[MemberStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Origin] FOREIGN KEY ([OriginId]) REFERENCES [lookup].[Origin] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_EntryPoint] FOREIGN KEY ([EntryPointId]) REFERENCES [lookup].[EntryPoint] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_InterestPoint] FOREIGN KEY ([InterestPointId]) REFERENCES [lookup].[InterestPoint] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_BaptismType] FOREIGN KEY ([BaptismTypeId]) REFERENCES [lookup].[BaptismType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_BaptismStatus] FOREIGN KEY ([BaptismStatusId]) REFERENCES [lookup].[BaptismStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_DecisionType] FOREIGN KEY ([DecisionTypeId]) REFERENCES [lookup].[DecisionType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_DiscoveryClassStatus] FOREIGN KEY ([NewMemberClassStatusId]) REFERENCES [lookup].[NewMemberClassStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_MemberLetterStatus] FOREIGN KEY ([LetterStatusId]) REFERENCES [lookup].[MemberLetterStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_JoinType] FOREIGN KEY ([JoinCodeId]) REFERENCES [lookup].[JoinType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [EnvPeople__EnvelopeOption] FOREIGN KEY ([EnvelopeOptionsId]) REFERENCES [lookup].[EnvelopeOption] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [ResCodePeople__ResidentCode] FOREIGN KEY ([ResCodeId]) REFERENCES [lookup].[ResidentCode] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_PEOPLE_TBL_Picture] FOREIGN KEY ([PictureId]) REFERENCES [dbo].[Picture] ([PictureId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [StmtPeople__ContributionStatementOption] FOREIGN KEY ([ContributionOptionsId]) REFERENCES [lookup].[EnvelopeOption] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [BFMembers__BFClass] FOREIGN KEY ([BibleFellowshipClassId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Campus] FOREIGN KEY ([CampusId]) REFERENCES [lookup].[Campus] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Families]'
GO
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [ResCodeFamilies__ResidentCode] FOREIGN KEY ([ResCodeId]) REFERENCES [lookup].[ResidentCode] ([Id])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FamiliesHeaded__HeadOfHousehold] FOREIGN KEY ([HeadOfHouseholdId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FamiliesHeaded2__HeadOfHouseholdSpouse] FOREIGN KEY ([HeadOfHouseholdSpouseId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FK_Families_Picture] FOREIGN KEY ([PictureId]) REFERENCES [dbo].[Picture] ([PictureId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[ManagedGiving]'
GO
ALTER TABLE [dbo].[ManagedGiving] ADD CONSTRAINT [FK_ManagedGiving_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[EnrollmentTransaction]'
GO
ALTER TABLE [dbo].[EnrollmentTransaction] ADD CONSTRAINT [DescTransactions__FirstTransaction] FOREIGN KEY ([EnrollmentTransactionId]) REFERENCES [dbo].[EnrollmentTransaction] ([TransactionId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[MeetingExtra]'
GO
ALTER TABLE [dbo].[MeetingExtra] ADD CONSTRAINT [FK_MeetingExtra_Meetings] FOREIGN KEY ([MeetingId]) REFERENCES [dbo].[Meetings] ([MeetingId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[MemberDocForm]'
GO
ALTER TABLE [dbo].[MemberDocForm] ADD CONSTRAINT [FK_MemberDocForm_PEOPLE_TBL] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[VolRequest]'
GO
ALTER TABLE [dbo].[VolRequest] ADD CONSTRAINT [VolRequests__Meeting] FOREIGN KEY ([MeetingId]) REFERENCES [dbo].[Meetings] ([MeetingId])
ALTER TABLE [dbo].[VolRequest] ADD CONSTRAINT [VolRequests__Requestor] FOREIGN KEY ([RequestorId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[VolRequest] ADD CONSTRAINT [VolResponses__Volunteer] FOREIGN KEY ([VolunteerId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[OrgMemMemTags]'
GO
ALTER TABLE [dbo].[OrgMemMemTags] ADD CONSTRAINT [FK_OrgMemMemTags_MemberTags] FOREIGN KEY ([MemberTagId]) REFERENCES [dbo].[MemberTags] ([Id])
ALTER TABLE [dbo].[OrgMemMemTags] ADD CONSTRAINT [FK_OrgMemMemTags_OrganizationMembers] FOREIGN KEY ([OrgId], [PeopleId]) REFERENCES [dbo].[OrganizationMembers] ([OrganizationId], [PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[OrganizationMembers]'
GO
ALTER TABLE [dbo].[OrganizationMembers] ADD CONSTRAINT [FK_OrganizationMembers_Transaction] FOREIGN KEY ([TranId]) REFERENCES [dbo].[Transaction] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PaymentInfo]'
GO
ALTER TABLE [dbo].[PaymentInfo] ADD CONSTRAINT [FK_PaymentInfo_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PeopleExtra]'
GO
ALTER TABLE [dbo].[PeopleExtra] ADD CONSTRAINT [FK_PeopleExtra_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RecReg]'
GO
ALTER TABLE [dbo].[RecReg] ADD CONSTRAINT [FK_RecReg_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[RecurringAmounts]'
GO
ALTER TABLE [dbo].[RecurringAmounts] ADD CONSTRAINT [FK_RecurringAmounts_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[SMSItems]'
GO
ALTER TABLE [dbo].[SMSItems] ADD CONSTRAINT [FK_SMSItems_People] FOREIGN KEY ([PeopleID]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[SMSItems] ADD CONSTRAINT [FK_SMSItems_SMSList] FOREIGN KEY ([ListID]) REFERENCES [dbo].[SMSList] ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[SMSList]'
GO
ALTER TABLE [dbo].[SMSList] ADD CONSTRAINT [FK_SMSList_People] FOREIGN KEY ([SenderID]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[SMSList] ADD CONSTRAINT [FK_SMSList_SMSGroups] FOREIGN KEY ([SendGroupID]) REFERENCES [dbo].[SMSGroups] ([ID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TagShare]'
GO
ALTER TABLE [dbo].[TagShare] ADD CONSTRAINT [FK_TagShare_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[TagShare] ADD CONSTRAINT [FK_TagShare_Tag] FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tag] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TaskListOwners]'
GO
ALTER TABLE [dbo].[TaskListOwners] ADD CONSTRAINT [FK_TaskListOwners_PEOPLE_TBL] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Transaction]'
GO
ALTER TABLE [dbo].[Transaction] ADD CONSTRAINT [FK_Transaction_People] FOREIGN KEY ([LoginPeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Transaction] ADD CONSTRAINT [Transactions__OriginalTransaction] FOREIGN KEY ([OriginalId]) REFERENCES [dbo].[Transaction] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[TransactionPeople]'
GO
ALTER TABLE [dbo].[TransactionPeople] ADD CONSTRAINT [FK_TransactionPeople_Person] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[TransactionPeople] ADD CONSTRAINT [FK_TransactionPeople_Transaction] FOREIGN KEY ([Id]) REFERENCES [dbo].[Transaction] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Users]'
GO
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_Users_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[VolInterestInterestCodes]'
GO
ALTER TABLE [dbo].[VolInterestInterestCodes] ADD CONSTRAINT [FK_VolInterestInterestCodes_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[VolInterestInterestCodes] ADD CONSTRAINT [FK_VolInterestInterestCodes_VolInterestCodes] FOREIGN KEY ([InterestCodeId]) REFERENCES [dbo].[VolInterestCodes] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Volunteer]'
GO
ALTER TABLE [dbo].[Volunteer] ADD CONSTRAINT [FK_Volunteer_PEOPLE_TBL] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[VolunteerForm]'
GO
ALTER TABLE [dbo].[VolunteerForm] ADD CONSTRAINT [FK_VolunteerForm_PEOPLE_TBL] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[VolunteerForm] ADD CONSTRAINT [VolunteerFormsUploaded__Uploader] FOREIGN KEY ([UploaderId]) REFERENCES [dbo].[Users] ([UserId])
ALTER TABLE [dbo].[VolunteerForm] ADD CONSTRAINT [FK_VolunteerForm_Volunteer1] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[Volunteer] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[VoluteerApprovalIds]'
GO
ALTER TABLE [dbo].[VoluteerApprovalIds] ADD CONSTRAINT [FK_VoluteerApprovalIds_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[VoluteerApprovalIds] ADD CONSTRAINT [FK_VoluteerApprovalIds_Volunteer] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[Volunteer] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[PeopleCanEmailFor]'
GO
ALTER TABLE [dbo].[PeopleCanEmailFor] ADD CONSTRAINT [OnBehalfOfPeople__PersonCanEmail] FOREIGN KEY ([CanEmail]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[PeopleCanEmailFor] ADD CONSTRAINT [PersonsCanEmail__OnBehalfOfPerson] FOREIGN KEY ([OnBehalfOf]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Tag]'
GO
ALTER TABLE [dbo].[Tag] ADD CONSTRAINT [TagsOwned__PersonOwner] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[OrgSchedule]'
GO
ALTER TABLE [dbo].[OrgSchedule] ADD CONSTRAINT [FK_OrgSchedule_Organizations] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Preferences]'
GO
ALTER TABLE [dbo].[Preferences] ADD CONSTRAINT [FK_UserPreferences_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[SMSGroupMembers]'
GO
ALTER TABLE [dbo].[SMSGroupMembers] ADD CONSTRAINT [FK_SMSGroupMembers_SMSGroups] FOREIGN KEY ([GroupID]) REFERENCES [dbo].[SMSGroups] ([ID])
ALTER TABLE [dbo].[SMSGroupMembers] ADD CONSTRAINT [FK_SMSGroupMembers_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[UserRole]'
GO
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [FK_UserRole_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [lookup].[MemberType]'
GO
ALTER TABLE [lookup].[MemberType] ADD CONSTRAINT [FK_MemberType_AttendType] FOREIGN KEY ([AttendanceTypeId]) REFERENCES [lookup].[AttendType] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating message types'
GO
CREATE MESSAGE TYPE [UpdateAttendStrMessage]
AUTHORIZATION [dbo]
VALIDATION=NONE
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating contracts'
GO
CREATE CONTRACT [UpdateAttendStrContract]
AUTHORIZATION [dbo] ( 
[UpdateAttendStrMessage] SENT BY INITIATOR
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating queues'
GO
CREATE QUEUE [dbo].[UpdateAttendStrQueue] 
WITH STATUS=ON, 
RETENTION=OFF, 
ACTIVATION (
STATUS=ON, 
PROCEDURE_NAME=[dbo].[UpdateAttendStrProc], 
MAX_QUEUE_READERS=3, 
EXECUTE AS OWNER
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating services'
GO
CREATE SERVICE [UpdateAttendStrService]
AUTHORIZATION [dbo]
ON QUEUE [dbo].[UpdateAttendStrQueue]
(
[UpdateAttendStrContract]
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating extended properties'
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Triggers"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 149
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tables"
            Begin Extent = 
               Top = 7
               Left = 294
               Bottom = 149
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Comments"
            Begin Extent = 
               Top = 7
               Left = 540
               Bottom = 149
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Triggers', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'Triggers', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'ReturnType', N'TopGiver', 'SCHEMA', N'dbo', 'PROCEDURE', N'TopPledgers', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'ReturnType', N'TopGiver', 'SCHEMA', N'dbo', 'PROCEDURE', N'TopGivers', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_addextendedproperty N'ReturnType', N'SecurityCode', 'SCHEMA', N'dbo', 'PROCEDURE', N'NextSecurityCode', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_Users_People]
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Roles]
ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_UserRole_Users]
ALTER TABLE [dbo].[RecReg] DROP CONSTRAINT [FK_RecReg_People]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_BaptismStatus]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_BaptismType]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [BFMembers__BFClass]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_Campus]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [StmtPeople__ContributionStatementOption]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_DecisionType]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_DropType]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_EntryPoint]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [EnvPeople__EnvelopeOption]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_Families]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_Gender]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_InterestPoint]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_JoinType]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_MemberLetterStatus]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_MaritalStatus]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_MemberStatus]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_DiscoveryClassStatus]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_Origin]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_PEOPLE_TBL_Picture]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [FK_People_FamilyPosition]
ALTER TABLE [dbo].[People] DROP CONSTRAINT [ResCodePeople__ResidentCode]
ALTER TABLE [dbo].[Families] DROP CONSTRAINT [FamiliesHeaded__HeadOfHousehold]
ALTER TABLE [dbo].[Families] DROP CONSTRAINT [FamiliesHeaded2__HeadOfHouseholdSpouse]
ALTER TABLE [dbo].[Families] DROP CONSTRAINT [FK_Families_Picture]
ALTER TABLE [dbo].[Families] DROP CONSTRAINT [ResCodeFamilies__ResidentCode]
ALTER TABLE [dbo].[OrgSchedule] DROP CONSTRAINT [FK_OrgSchedule_Organizations]
ALTER TABLE [dbo].[DivOrg] DROP CONSTRAINT [FK_DivOrg_Division]
ALTER TABLE [dbo].[DivOrg] DROP CONSTRAINT [FK_DivOrg_Organizations]
ALTER TABLE [dbo].[ProgDiv] DROP CONSTRAINT [FK_ProgDiv_Division]
ALTER TABLE [dbo].[ProgDiv] DROP CONSTRAINT [FK_ProgDiv_Program]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_Organizations_Campus]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_Organizations_Division]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_ORGANIZATIONS_TBL_EntryPoint]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_Organizations_Gender]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_ORGANIZATIONS_TBL_OrganizationStatus]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [FK_Organizations_OrganizationType]
ALTER TABLE [dbo].[Organizations] DROP CONSTRAINT [ChildOrgs__ParentOrg]
ALTER TABLE [dbo].[ActivityLog] DROP CONSTRAINT [FK_ActivityLog_Organizations]
ALTER TABLE [dbo].[Attend] DROP CONSTRAINT [FK_AttendWithAbsents_TBL_ORGANIZATIONS_TBL]
ALTER TABLE [dbo].[Coupons] DROP CONSTRAINT [FK_Coupons_Organizations]
ALTER TABLE [dbo].[EnrollmentTransaction] DROP CONSTRAINT [ENROLLMENT_TRANSACTION_ORG_FK]
ALTER TABLE [dbo].[Meetings] DROP CONSTRAINT [FK_MEETINGS_TBL_ORGANIZATIONS_TBL]
ALTER TABLE [dbo].[MemberTags] DROP CONSTRAINT [FK_MemberTags_Organizations]
ALTER TABLE [dbo].[OrganizationExtra] DROP CONSTRAINT [FK_OrganizationExtra_Organizations]
ALTER TABLE [dbo].[OrganizationMembers] DROP CONSTRAINT [ORGANIZATION_MEMBERS_ORG_FK]
ALTER TABLE [lookup].[MemberType] DROP CONSTRAINT [FK_MemberType_AttendType]
ALTER TABLE [dbo].[Attend] DROP CONSTRAINT [FK_Attend_MemberType]
ALTER TABLE [dbo].[EnrollmentTransaction] DROP CONSTRAINT [FK_ENROLLMENT_TRANSACTION_TBL_MemberType]
ALTER TABLE [dbo].[OrganizationMembers] DROP CONSTRAINT [FK_ORGANIZATION_MEMBERS_TBL_MemberType]
ALTER TABLE [dbo].[Division] DROP CONSTRAINT [FK_Division_Program]
ALTER TABLE [dbo].[Coupons] DROP CONSTRAINT [FK_Coupons_Division]
ALTER TABLE [dbo].[Promotion] DROP CONSTRAINT [FromPromotions__FromDivision]
ALTER TABLE [dbo].[Promotion] DROP CONSTRAINT [ToPromotions__ToDivision]
ALTER TABLE [dbo].[VoluteerApprovalIds] DROP CONSTRAINT [FK_VoluteerApprovalIds_VolunteerCodes]
ALTER TABLE [dbo].[Volunteer] DROP CONSTRAINT [FK_Volunteer_VolApplicationStatus]
ALTER TABLE [dbo].[Task] DROP CONSTRAINT [FK_Task_TaskStatus]
ALTER TABLE [dbo].[Zips] DROP CONSTRAINT [FK_Zips_ResidentCode]
ALTER TABLE [dbo].[Contribution] DROP CONSTRAINT [FK_Contribution_ContributionType]
ALTER TABLE [dbo].[Contribution] DROP CONSTRAINT [FK_Contribution_ContributionStatus]
ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contacts_ContactTypes]
ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_NewContacts_ContactReasons]
ALTER TABLE [dbo].[BundleHeader] DROP CONSTRAINT [FK_BUNDLE_HEADER_TBL_BundleStatusTypes]
ALTER TABLE [dbo].[BundleHeader] DROP CONSTRAINT [FK_BUNDLE_HEADER_TBL_BundleHeaderTypes]
ALTER TABLE [dbo].[Attend] DROP CONSTRAINT [FK_AttendWithAbsents_TBL_AttendType]
ALTER TABLE [dbo].[Meetings] DROP CONSTRAINT [FK_Meetings_AttendCredit]
ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Contacts_Ministries]
ALTER TABLE [dbo].[Contribution] DROP CONSTRAINT [FK_Contribution_ExtraData]
ALTER TABLE [dbo].[BundleHeader] DROP CONSTRAINT [BundleHeaders__Fund]
ALTER TABLE [dbo].[Contribution] DROP CONSTRAINT [FK_Contribution_ContributionFund]
ALTER TABLE [dbo].[RecurringAmounts] DROP CONSTRAINT [FK_RecurringAmounts_ContributionFund]
ALTER TABLE [dbo].[ContentKeyWords] DROP CONSTRAINT [FK_ContentKeyWords_Content]
SET IDENTITY_INSERT [dbo].[BackgroundCheckMVRCodes] ON
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (2, N'AL', N'Alabama', N'AL')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (3, N'AK', N'Alaska', N'AK')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (7, N'AZ39M', N'Arizona (39 month)', N'AZ')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (8, N'ARD', N'Arkansas (Driver Check)', N'AR')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (9, N'CA', N'California', N'CA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (11, N'CO', N'Colorado', N'CO')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (12, N'CT', N'Connecticut', N'CT')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (13, N'DE', N'Delaware', N'DE')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (14, N'DC', N'District of Columbia', N'DC')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (15, N'FL3', N'Florida (3 Year)', N'FL')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (17, N'GA3Y', N'Georgia (3 Year)', N'GA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (18, N'HI', N'Hawaii', N'HI')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (19, N'ID', N'Idaho', N'ID')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (20, N'IL', N'Illinois', N'IL')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (21, N'IN', N'Indiana', N'IN')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (22, N'IA', N'Iowa', N'IA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (23, N'KS', N'Kansas', N'KS')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (24, N'KY', N'Kentucky', N'KY')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (25, N'LA', N'Louisiana', N'LA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (26, N'ME', N'Maine', N'ME')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (27, N'MD', N'Maryland', N'MD')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (29, N'MA', N'Massachusetts', N'MA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (30, N'MI', N'Michigan', N'MI')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (31, N'MNC', N'Minnesota (Complete)', N'MN')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (32, N'MS', N'Mississippi', N'MS')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (33, N'MOC', N'Missouri (Complete)', N'MO')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (34, N'MT', N'Montana', N'MT')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (35, N'NE', N'Nebraska', N'NE')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (36, N'NV', N'Nevada', N'NV')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (37, N'NH', N'New Hampshire', N'NH')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (38, N'NJ', N'New Jersey', N'NJ')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (39, N'NM', N'New Mexico', N'NM')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (40, N'NY', N'New York', N'NY')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (41, N'NC3Y', N'North Carolina (3 Year)', N'NC')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (42, N'ND', N'North Dakota', N'ND')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (43, N'OH', N'Ohio', N'OH')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (45, N'OK', N'Oklahoma', N'OK')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (46, N'OR', N'Oregon', N'OR')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (47, N'PA3Y', N'Pennsylvania (3 Year Insurance)', N'PA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (48, N'RI', N'Rhode Island', N'RI')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (50, N'SC3Y', N'South Carolina (3 Year)', N'SC')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (51, N'SD', N'South Dakota', N'SD')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (52, N'TN3Y', N'Tennessee (3 Year)', N'TN')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (53, N'TX3', N'Texas (3 Year)', N'TX')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (54, N'UT', N'Utah', N'UT')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (55, N'VT', N'Vermont', N'VT')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (56, N'VA', N'Virginia', N'VA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (57, N'WA', N'Washington', N'WA')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (58, N'WV', N'West Virginia', N'WV')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (59, N'WI', N'Wisconsin', N'WI')
INSERT INTO [dbo].[BackgroundCheckMVRCodes] ([ID], [Code], [Description], [StateAbbr]) VALUES (60, N'WY', N'Wyoming', N'WY')
SET IDENTITY_INSERT [dbo].[BackgroundCheckMVRCodes] OFF
SET IDENTITY_INSERT [dbo].[Content] ON
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (1, N'Header', N'Header', N'<h1>
	{churchname}</h1>
<h2>
	<em>{byline}</em></h2>
', '2009-04-17 20:42:09.213', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (2, N'ShellDefault', N'Default Online Reg Shell', N'<html>
<head>
	<title>Online Registration</title>
<!--Do not delete the following comment-->
    <!--FORM CSS-->
</head>
<body>
<!--Do not delete the following comment-->
<!--FORM START-->
<p>Form goes here</p>
<!--Do not delete the following comment-->
<!--FORM END-->
</body>
</html>
', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (3, N'ShellIFrame', N'Plain Online Reg Shell for iFrame use', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html> 
<head> 
<title>Online Registration</title> 
 
<meta http-equiv=''Content-Type'' content=''text/html; charset=iso-8859-1'' /> 
<link href=''/Content/Site2.css?v=4'' rel=''stylesheet'' type=''text/css'' /> 
 
</head> 
<body> 
<!--FORM START-->
    <h2>Registration Form</h2> 
    
    <form class="DisplayEdit" action="/OnlineReg/CompleteRegistration/" method="post"> 
    <input id="m_divid" name="m.divid" type="hidden" value="" /> 
<input id="m_orgid" name="m.orgid" type="hidden" value="114" /> 
<input id="m_testing" name="m.testing" type="hidden" value="" /> 
<table cellpadding="0" cellspacing="2" width="100%"> 
 
<tr><td class="alt0"> 
<input id="m_List_index" name="m.List.index" type="hidden" value="0" /> 
<input name="m.List[0].orgid" type="hidden" value="114"></input> 
<input name="m.List[0].divid" type="hidden" value=""></input> 
<input name="m.List[0].ShowAddress" type="hidden" value="False"></input> 
 
<table cellspacing="6"> 
 
    <tr> 
        <td><label for="first">First Name</label></td> 
        <td><input type="text" name="m.List[0].first" value="" /> 
        </td> 
        <td> </td> 
    </tr> 
    <tr> 
        <td><label for="last">Last Name</label></td> 
        <td><input type="text" name="m.List[0].last" value="" /></td> 
        <td>suffix:<input type="text" name="m.List[0].suffix" class="short" value="" /> 
        </td> 
    </tr> 
     <tr> 
        <td><label for="dob">Date of Birth</label></td> 
        <td><input type="text" name="m.List[0].dob" value="" class="dob" title="m/d/y, mmddyy, mmddyyyy" /></td> 
        <td><span id="age">2009</span> (m/d/y) </td> 
    </tr> 
    <tr> 
        <td><label for="phone">Phone</label></td> 
        <td><input type="text" name="m.List[0].phone" value="" /></td> 
        <td><input type="radio" name="m.List[0].homecell" value="h"  /> Home<br /> 
        <input type="radio" name="m.List[0].homecell" value="c"  /> Cell
        </td> 
    </tr> 
    <tr> 
        <td><label for="email">Contact Email</label></td> 
        <td><input type="text" name="m.List[0].email" value="" /></td> 
        <td></td> 
    </tr> 
    
    <tr><td></td> 
        <td> 
        
            <a href="/OnlineReg/PersonFind/0" class="submitbutton">Find Record</a> 
        
        </td> 
    </tr> 
    
</table> 
 
</td></tr> 
 
</table> 
    </form> 
<!--FORM END-->
 
</body> 
</html>', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (4, N'StatementHeader', N'Contribution Statement Header', N'<h1>Sample Church</h1>
<h2>105 Highway 151 | Ventura, TN 34773 | 615.232.3432</h2>', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (5, N'StatementNotice', N'Contribution Statement Notice', N'<p><i>NOTE: No goods or services were provided to you by the church in connection with any contribution; any value received consisted entirely of intangible religious benefits.&nbsp;</i></p>

<p><i>Thank you for your faithfulness in the giving of your time, talents, and resources. Together we can share the love of Jesus with our city </i></p>
', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (6, N'TermsOfUse', N'Terms Of Use', N'
<div style="width: 300px">
<p><span style="font-size: medium">Access to this site is given by special pemission only.</span></p>
<p>This web site has a starter database.</p>
<p>The source code is licensed under the GPL (see <a href="http://bvcms.codeplex.com/license">license</a>)</p>
</div>
', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
EXEC(N'INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (11, N''MemberProfileAutomation'', N''MemberProfileAutomation'', N'' 
# this is an IronPython script for MembershipAutomation in BVCMS
# the variable p has been passed in and is the person that we are saving Member Profile information for

#import useful constants (defined in constants.py)
from constants import *


# define all functions first, codes starts running below functions

# do not allow empty join date
def SetJoinDate(p, name, dt):
    if dt == None:
        p.errorReturn = "need a " + name + " date"
    p.JoinDate = dt

# this controls the membership status, makes them a member if they have completed the two requirements
def CheckJoinStatus(p):

    if p.DecisionTypeId == DecisionCode.ProfessionForMembership:
        if p.DiscClassStatusCompletedCodes.Contains(p.NewMemberClassStatusId) and         p.BaptismStatusId == BaptismStatusCode.Completed:
            if p.NewMemberClassDate != None and p.BaptismDate != None:
                if p.NewMemberClassDate > p.BaptismDate:
                    SetJoinDate(p, "NewMemberClass", p.NewMemberClassDate)
                else:
                    SetJoinDate(p, "Baptism", p.BaptismDate)
            p.MemberStatusId = MemberStatusCode.Member
            if p.BaptismTypeId == BaptismTypeCode.Biological:
                p.JoinCodeId = JoinTypeCode.BaptismBIO
            else:
                p.JoinCodeId = JoinTypeCode.BaptismPOF

    elif p.DecisionTypeId == DecisionCode.Letter:
        if p.NewMemberClassStatusIdChanged:
            if p.DiscClassStatusCompletedCodes.Contains(p.NewMemberClassStatusId)             or p.NewMemberClassStatusId == NewMemberClassStatusCode.AdminApproval:
                p.MemberStatusId = MemberStatusCode.Member
                p.JoinCodeId = JoinTypeCode.Letter
                if p.NewMemberClassDate != None:
                    SetJoinDate(p, "NewMember", p.NewMemberClassDate)
                else:
                    SetJoinDate(p, "Decision", p.DecisionDate)

    elif p.DecisionTypeId == DecisionCode.Statement:
        if p.NewMemberClassStatusIdChanged:
            if p.DiscClassStatusCompletedCodes.Contains(p.NewMemberClassStatusId):
                p.MemberStatusId = MemberStatusCode.Member
                p.JoinCodeId = JoinTypeCode.Statement
                if p.NewMemberClassDate != None:
                    SetJoinDate(p, "NewMember", p.NewMemberClassDate)
                else:
                    SetJoinDate(p, "Decision", p.DecisionDate)

    elif p.DecisionTypeId == DecisionCode.StatementReqBaptism:
        if p.DiscClassStatusCompletedCodes.Contains(p.NewMemberClassStatusId)         and p.BaptismStatusId == BaptismStatusCode.Completed:
            p.MemberStatusId = MemberStatusCode.Member
            p.JoinCodeId = JoinTypeCode.BaptismSRB
            if p.NewMemberClassDate != None:
                 if p.NewMemberClassDate > p.BaptismDate:
                    SetJoinDate(p, "NewMember", p.NewMemberClassDate)
                 else: 
                    SetJoinDate(p, "Baptism", p.BaptismDate)
            else:
                 SetJoinDate(p, "Baptism", p.BaptismDate)

# this moves the membership process along, setting various codes based on decision
def CheckDecisionStatus(p):

    if p.DecisionTypeId == DecisionCode.ProfessionForMembership:
        p.MemberStatusId = MemberStatusCode.Pending
        if p.NewMemberClassStatusId != NewMemberClassStatusCode.Attended:
            p.NewMemberClassStatusId = NewMemberClassStatusCode.Pending
        if p.Age <= 12 and p.FamilyHasPrimaryMemberForMoreThanDays(365):
            p.BaptismTypeId = BaptismTypeCode.Biological
        else:
            p.BaptismTypeId = BaptismTypeCode.Original
        BaptismStatusId = BaptismStatusCode.NotScheduled

    elif p.DecisionTypeId == DecisionCode.ProfessionNotForMembership:
        p.MemberStatusId = MemberStatusCode.NotMember
        if p.NewMemberClassStatusId != NewMemberClassStatusCode.Attended:
            NewMemberClassStatusId = New'', ''2013-09-09 23:32:14.270'', 1, 1, 0, 0, 0, NULL, NULL, NULL, NULL)')
EXEC(N'UPDATE [dbo].[Content] SET [Body].WRITE(N''MemberClassStatusCode.NotSpecified
        if p.BaptismStatusId != BaptismStatusCode.Completed:
            p.BaptismTypeId = BaptismTypeCode.NonMember
            p.BaptismStatusId = BaptismStatusCode.NotScheduled

    elif p.DecisionTypeId == DecisionCode.Letter:
        p.MemberStatusId = MemberStatusCode.Pending
        if p.NewMemberClassStatusId != NewMemberClassStatusCode.Attended:
            p.NewMemberClassStatusId = NewMemberClassStatusCode.Pending
            if p.BaptismStatusId != BaptismStatusCode.Completed:
                p.BaptismTypeId = BaptismTypeCode.NotSpecified
                p.BaptismStatusId = BaptismStatusCode.NotSpecified

    elif p.DecisionTypeId == DecisionCode.Statement:
        p.MemberStatusId = MemberStatusCode.Pending
        if p.NewMemberClassStatusId != NewMemberClassStatusCode.Attended:
            p.NewMemberClassStatusId = NewMemberClassStatusCode.Pending
            if p.BaptismStatusId != BaptismStatusCode.Completed:
                p.BaptismTypeId = BaptismTypeCode.NotSpecified
                p.BaptismStatusId = BaptismStatusCode.NotSpecified

    elif p.DecisionTypeId == DecisionCode.StatementReqBaptism:
        p.MemberStatusId = MemberStatusCode.Pending
        if p.NewMemberClassStatusId != NewMemberClassStatusCode.Attended:
            p.NewMemberClassStatusId = NewMemberClassStatusCode.Pending
        if p.BaptismStatusId != BaptismStatusCode.Completed:
            p.BaptismTypeId = BaptismTypeCode.Required
            p.BaptismStatusId = BaptismStatusCode.NotScheduled

    elif p.DecisionTypeId == DecisionCode.Cancelled:
        p.MemberStatusId = MemberStatusCode.NotMember
        if p.NewMemberClassStatusId != NewMemberClassStatusCode.Attended:
            NewMemberClassStatusId = NewMemberClassStatusCode.NotSpecified
        if p.BaptismStatusId != BaptismStatusCode.Completed:
            if p.BaptismStatusId != BaptismStatusCode.Completed:
                p.BaptismTypeId = BaptismTypeCode.NotSpecified
                p.BaptismStatusId = BaptismStatusCode.Canceled
        p.EnvelopeOptionsId = EnvelopeOptionCode.NoEnvelope

# cleanup for deceased and for dropped memberships
def DropMembership(p, Db):

    if p.MemberStatusId == MemberStatusCode.Member:
        if p.Deceased:
            p.DropCodeId = DropTypeCode.Deceased
        p.MemberStatusId = MemberStatusCode.Previous
        p.DropDate = p.Now().Date

    if p.Deceased:
        p.EmailAddress = None
        p.DoNotCallFlag = True
        p.DoNotMailFlag = True
        p.DoNotVisitFlag = True

    if p.SpouseId != None:
        spouse = Db.LoadPersonById(p.SpouseId)

        if p.Deceased:
            spouse.MaritalStatusId = MaritalStatusCode.Widowed
            if spouse.EnvelopeOptionsId != None: # not null
                if spouse.EnvelopeOptionsId != EnvelopeOptionCode.NoEnvelope:
                    spouse.EnvelopeOptionsId = EnvelopeOptionCode.Individual
            spouse.ContributionOptionsId = EnvelopeOptionCode.Individual

        if spouse.MemberStatusId == MemberStatusCode.Member:
            if spouse.EnvelopeOptionsId == EnvelopeOptionCode.Joint:
                spouse.EnvelopeOptionsId = EnvelopeOptionCode.Individual

    p.EnvelopeOptionsId = EnvelopeOptionCode.NoEnvelope
    p.DropAllMemberships(Db)

#-------------------------------------
# Main Function
class MembershipAutomation(object):
    def __init__(self):
        pass
    def Run(self, Db, p):
        p.errorReturn = "ok"
        if p.DecisionTypeIdChanged:
            CheckDecisionStatus(p)

        if (p.NewMemberClassStatusId == NewMemberClassStatusCode.AdminApproval         or p.NewMemberClassStatusId == NewMemberClassStatusCode.Attended         or p.NewMemberClassStatusId == NewMemberClassStatusCode.GrandFathered         or p.NewMemberClassStatusId == NewMemberClassStatusCode.ExemptedChild)         and p.NewMemberClassDate == None:
            p.errorR'',NULL,NULL) WHERE [Id]=11
UPDATE [dbo].[Content] SET [Body].WRITE(N''eturn = "need a NewMemberClass date"

        if (p.DecisionTypeId == DecisionCode.Letter         or p.DecisionTypeId == DecisionCode.Statement         or p.DecisionTypeId == DecisionCode.ProfessionForMembership         or p.DecisionTypeId == DecisionCode.ProfessionNotForMembership         or p.DecisionTypeId == DecisionCode.StatementReqBaptism)         and p.DecisionDate == None:
            p.errorReturn = "need a Decision date"

        if p.NewMemberClassStatusIdChanged or p.BaptismStatusIdChanged:
            CheckJoinStatus(p)

        if p.DeceasedDateChanged:
            if p.DeceasedDate != None:
                DropMembership(p, Db)

        # when people leave the church, lots of cleanup to do
        if p.DropCodeIdChanged:
            if p.DropCodesThatDrop.Contains(p.DropCodeId):
                DropMembership(p, Db)

        # this does new member class completed
        if p.NewMemberClassStatusIdChanged         and p.NewMemberClassStatusId == NewMemberClassStatusCode.Attended:
            om = Db.LoadOrgMember(p.PeopleId, "Step 1", False)
            if om != None:
                om.Drop(True) # drops and records drop in history
'',NULL,NULL) WHERE [Id]=11
')
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (58, N'VitalStats', N'Vital Stats Iron Python Script', N'import System
import System.Text
from System import *
from System.Text import *

class VitalStats(object):
    def Run(self, m):
        days = 7
        fmt = ''<tr><td align="right">{0}:</td><td align="right">{1:n0}</td></tr>\r\n''
        fmt0 = ''<tr><td colspan="2">{0}\r\n''
        #fmt = ''{0,28}:{1,10:n0}\r\n''
        #fmt0 = ''{0}\r\n''
        sb = StringBuilder()

        sb.AppendLine(''<table cellspacing="5" class="grid">'')
        sb.AppendFormat(fmt0, String.Format("Counts for past {0} days", days))
        sb.AppendFormat(fmt, "Members", m.QueryCount("Stats:Members"))
        sb.AppendFormat(fmt, "Decisions", m.QueryCount("Stats:Decisions"))
        sb.AppendFormat(fmt, "Meetings", m.MeetingCount(days, 0, 0, 0))
        sb.AppendFormat(fmt, "Sum of Present in Meetings", m.NumPresent(days, 0, 0, 0))
        sb.AppendFormat(fmt, "Unique Attends", m.QueryCount("Stats:Attends"))
        sb.AppendFormat(fmt, "New Attends", m.QueryCount("Stats:New Attends"))
        sb.AppendFormat(fmt, "Contacts", m.QueryCount("Stats:Contacts"))
        sb.AppendFormat(fmt, "Registrations", m.RegistrationCount(days, 0, 0, 0))
        sb.AppendFormat(fmt0, "Contributions")
        sb.AppendFormat(fmt, "Amount Previous 7 days", m.ContributionTotals(7*2, 7, 0))
        sb.AppendFormat(fmt, "Count Previous 7 days", m.ContributionCount(7*2, 7, 0))
        tcount = m.ContributionCount(53*7, 7, 0)
        if tcount > 0:
            sb.AppendFormat(fmt, "Average per Capita Year", \\

                m.ContributionTotals(53*7, 7, 0) / m.ContributionCount(53*7, 7, 0))
        sb.AppendFormat(fmt, "Weekly 4 week average", m.ContributionTotals(7*5, 7, 0) / 4)
        sb.AppendFormat(fmt, "Weekly average past 52wks", m.ContributionTotals(53*7, 7, 0) / 52)
        sb.AppendFormat(fmt, "Weekly average prev 52wks", \\

            m.ContributionTotals(53*7*2, 53*7+7, 0) / 52)
        sb.AppendLine(''</table>'')
        return sb.ToString()
', '2013-09-09 23:32:14.270', 1, 1, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (63, N'OneTimeConfirmation', N'OneTimeConfirmation', N'Hi {name},
<p>Here is your <a href="{url}">link</a> to manage your subscriptions. 
(note: it will only work once for security reasons)</p>', '2011-10-18 20:12:42.000', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (64, N'OneTimeConfirmationPledge', N'OneTimeConfirmationPledge', N'Hi {name},
<p>Here is your <a href="{url}">link</a> to manage your pledge. 
(note: it will only work once for security reasons)</p>', '2011-10-18 20:12:42.000', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (65, N'DiffEmailMessage', N'Different Email Message', N'<title></title>
<p>Hi {name},</p>

<p>You registered for {org} using a different email address than the one we have on record. It is important that you call the church <strong>{phone}</strong> to update our records so that you will receive future important notices regarding this registration.</p>
', '2011-10-18 20:12:42.000', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (66, N'NoEmailMessage', N'NoEmailMessage', N'<p>
	Hi {name},</p>
<p>
	You registered for {org}, and we found your record, but there was no email address on your existing record in our database. If you would like for us to update your record with this email address or another, Please contact the church at <strong>{phone}</strong> to let us know. It is important that we have your email address so that you will receive future important notices regarding this registration. But we won&#39;t add that to your record without your permission. Thank you</p>
', '2011-10-18 20:12:42.000', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (67, N'NewUserWelcome', N'New User Welcome', N'<html>
	<head>
		<title></title>
	</head>
	<body>
		<p>
			Hi {name},</p>
		<p>
			You now have a new user account on our church&#39;s Church Management System (BVCMS).</p>
		<p>
			Your username is {username}</p>
		<p>
			Click this link to create your password: {link}</p>
		<p>
			NOTE: If these do not appear as links, copy and paste them into your browser.</p>
		<p>
			You can access the site anytime using this link: {cmshost}</p>
		<p>
			Welcome,</p>
		<p>
			The BVCMS Team<br />
			<a href="mailto:support@bvcms.com">support@bvcms.com</a><br />
			&nbsp;</p>
	</body>
</html>
', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (68, N'StandardExtraValues.xml', N'StandardExtraValues.xml', N'<Fields>
	<Field name="InterviewStatus" location="MemberProfile" type="Code">
		<Codes>
			<string>NotScheduled</string>
			<string>Scheduled</string>
			<string>Completed</string>
		</Codes>
	</Field>
	<Field name="InterviewDate" location="MemberProfile" type="Date" />
	<Field name="InterviewComments" location="MemberProfile" type="Data" VisibilityRoles="Elder,Membership" />
	<Field name="CorrespondenceMethod" type="Code">
		<Codes>
			<string>Email</string>
			<string>Mail</string>
			<string>Both</string>
			<string>Neither</string>
		</Codes>
	</Field>
	<Field name="EELevel" type="Int" />
	<Field name="CounselingNotes" type="Data" location="MemberProfile" VisibilityRoles="Counselor" />
	<Field name="Spiritual Gifts" type="Bits" location="MemberProfile">
		<Codes>
			<string>SG:exhortation</string>
			<string>SG:giving</string>
			<string>SG:leadership</string>
			<string>SG:mercy</string>
			<string>SG:teaching</string>
			<string>SG:administration</string>
			<string>SG:discernment</string>
			<string>SG:faith</string>
			<string>SG:healing</string>
			<string>SG:helps</string>
			<string>SG:knowledge</string>
			<string>SG:miracles</string>
			<string>SG:tongues</string>
			<string>SG:wisdom</string>
			<string>SG:evangelism</string>
			<string>SG:prophecy</string>
			<string>SG:hospitality</string>
		</Codes>
	</Field>
</Fields>
', '2012-02-29 21:47:04.463', 1, 1, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (69, N'Empty Template', N'Empty Template', N'<html>
<body>
<div bvedit style="max-width:600px;">Click here to edit content</div>
</body>
</html>', '2012-06-14 19:18:11.000', 1, 2, 0, 0, 0, NULL, NULL, NULL, NULL)
EXEC(N'INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (70, N''Basic Newsletter Template'', N''Basic Newsletter Template'', N''<html>
	<head>
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
		<title>Our Newsletter</title>
		<style type="text/css">
#outlook a{padding:0;}
			body{width:100% !important;}
			body{-webkit-text-size-adjust:none;}
			body{margin:0; padding:0;}
			img{border:none; font-size:14px; font-weight:bold; height:auto; line-height:100%; outline:none; text-decoration:none; text-transform:capitalize;}
			#backgroundTable{height:100% !important; margin:0; padding:0; width:100% !important;}
			body, #backgroundTable{
				background-color:#FAFAFA;
			}
			h1, .h1{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:34px;
				font-weight:bold;
				line-height:100%;
				margin-top:0 !important;
				margin-right:0 !important;
				margin-bottom:10px !important;
				margin-left:0 !important;
				text-align:left;
			}
			h2, .h2{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:30px;
				font-weight:bold;
				line-height:100%;
				margin-top:0 !important;
				margin-right:0 !important;
				margin-bottom:10px !important;
				margin-left:0 !important;
				text-align:left;
			}
			h3, .h3{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:26px;
				font-weight:bold;
				line-height:100%;
				margin-top:0 !important;
				margin-right:0 !important;
				margin-bottom:10px !important;
				margin-left:0 !important;
				text-align:left;
			}
			h4, .h4{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:22px;
				font-weight:bold;
				line-height:100%;
				margin-top:0 !important;
				margin-right:0 !important;
				margin-bottom:10px !important;
				margin-left:0 !important;
				text-align:left;
			}
			#templatePreheader{
				background-color:#FAFAFA;
			}
			.preheaderContent div{
				color:#505050;
				font-family:Arial;
				font-size:10px;
				line-height:100%;
				text-align:left;
			}
			.preheaderContent div a:link, .preheaderContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			#templateHeader{
				background-color:#D8E2EA;
				border-bottom:0;
			}
			.headerContent{
				color:#202020;
				font-family:Arial;
				font-size:34px;
				font-weight:bold;
				line-height:100%;
				padding:0;
				text-align:center;
				vertical-align:middle;
			}

			.headerContent a:link, .headerContent a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}

			#headerImage{
				height:auto;
				max-width:600px !important;
			}
			#templateContainer, .bodyContent{
				background-color:#FDFDFD;
			}
			.bodyContent div{
				color:#505050;
				font-family:Arial;
				font-size:14px;
				line-height:150%;
				text-align:left;
			}
			.bodyContent div a:link, .bodyContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			.bodyContent img, .fullWidthBandContent img{
				display:inline;
				height:auto;
			}
			#templateSidebar{
				background-color:#FFFFFF;
			}
			.sidebarContent div{
				color:#505050;
				font-family:Arial;
				font-size:12px;
				line-height:150%;
				text-align:left;
			}
			.sidebarContent div a:link, .sidebarContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			.sidebarContent img{
				display:inline;
				height:auto;
			}
			.leftColumnContent{
				background-color:#FFFFFF;
			}
			.leftColumnContent div{
				color:#505050;
				font-family:Arial;
				font-size:14px;
				line-height:150%;
				text-align:left;
			}
			.leftColumnContent div a:link, .leftColumnContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			.leftColumnContent img{
				display:inline;
				height:auto;
			}
			.rightColumnContent{
				background-color:#FFFFFF;
			}
			'', ''2013-09-09 23:32:14.270'', NULL, 2, 14, 20, 0, NULL, NULL, NULL, NULL)')
EXEC(N'UPDATE [dbo].[Content] SET [Body].WRITE(N''.rightColumnContent div{
				color:#505050;
				font-family:Arial;
				font-size:14px;
				line-height:150%;
				text-align:left;
			}
			.rightColumnContent div a:link, .rightColumnContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			.rightColumnContent img{
				display:inline;
				height:auto;
			}
			#templateFooter{
				background-color:#FDFDFD;
				border-top:0;
			}
			.footerContent div{
				color:#707070;
				font-family:Arial;
				font-size:12px;
				line-height:125%;
				text-align:left;
			}
			.footerContent div a:link, .footerContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			.footerContent img{
				display:inline;
			}
			#social{
				background-color:#FAFAFA;
				border:0;
			}
			#social div{
				text-align:center;
			}
			#utility{
				background-color:#FDFDFD;
				border:0;
			}
			#utility div{
				text-align:center;
			}		</style>
	</head>
	<body leftmargin="0" marginheight="0" marginwidth="0" offset="0" topmargin="0">
		<center>
			<table border="0" cellpadding="0" cellspacing="0" height="100%" id="backgroundTable" width="100%">
				<tbody>
					<tr>
						<td align="center" valign="top">
							<table border="0" cellpadding="10" cellspacing="0" id="templatePreheader" width="600">
								<tbody>
									<tr>
										<td class="preheaderContent" valign="top">
											<table border="0" cellpadding="10" cellspacing="0" width="100%">
												<tbody>
													<tr>
														<td valign="top">
															<div bvedit="">
																Use this area to offer a short teaser of your email&#39;&#39;s content. Text here will show in the preview area of some email clients and in Facebook news feed posts.</div>
														</td>
														<td valign="top" width="190">
															<div>
																Is this email not displaying correctly?<br />
																<a href="{emailhref}" target="_blank">View it in your browser</a>.</div>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
							<table border="0" cellpadding="0" cellspacing="0" id="templateContainer" width="600">
								<tbody>
									<tr>
										<td align="center" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" id="templateHeader" width="600">
												<tbody>
													<tr>
														<td class="headerContent">
															<img src="http://www.bvcms.com/content/images/placeholder_600.gif" style="max-width:160px;" /></td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td align="center" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" id="templateBody" width="600">
												<tbody>
													<tr>
														<td id="templateSidebar" valign="top" width="200">
															<table border="0" cellpadding="0" cellspacing="0" width="200">
																<tbody>
																	<tr>
																		<td class="sidebarContent" valign="top">
																			<table border="0" cellpadding="0" cellspacing="0" style="padding-top:10px; padding-left:20px;" width="100%">
																				<tbody>
																					<tr>
																						<td valign="top">
																							<table border="0" cellpadding="0" cellspacing="4">
																								<tbody>
																									<tr>
																										<td align="left" valign="middle" width="16">
																											<img src="http://www.bvcms.com/content/images/sfs_icon_facebook.png" /></td>
																										<td align="left" valign="top">
																											<div>
																												<a href="http://facebook.com/yourpage">Friend on Facebook</a></div>
																										</td'',NULL,NULL) WHERE [Id]=70
UPDATE [dbo].[Content] SET [Body].WRITE(N''>
																									</tr>
																									<tr>
																										<td align="left" valign="middle" width="16">
																											<img src="http://www.bvcms.com/content/images/sfs_icon_twitter.png" style="margin:0 !important;" /></td>
																										<td align="left" valign="top">
																											<div>
																												<a href="http://www.twitter.com/yourname">Follow on Twitter</a></div>
																										</td>
																									</tr>
																								</tbody>
																							</table>
																						</td>
																					</tr>
																				</tbody>
																			</table>
																			<table border="0" cellpadding="20" cellspacing="0" width="100%">
																				<tbody>
																					<tr bvrepeat="">
																						<td valign="top">
																							<img src="http://www.bvcms.com/content/images/placeholder_160.gif" style="max-width:160px;" />
																							<div bvedit="">
																								<h4>
																									Heading 4</h4>
																								Sections in the side bar are shown here.</div>
																						</td>
																					</tr>
																				</tbody>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
														<td valign="top" width="400">
															<table border="0" cellpadding="0" cellspacing="0" width="400">
																<tbody>
																	<tr>
																		<td valign="top">
																			<table border="0" cellpadding="0" cellspacing="0" width="400">
																				<tbody>
																					<tr>
																						<td class="bodyContent" valign="top">
																							<table border="0" cellpadding="20" cellspacing="0" width="100%">
																								<tbody>
																									<tr>
																										<td valign="top">
																											<div bvedit="">
																												<h1>
																													Heading 1</h1>
																												<h2>
																													Heading 2</h2>
																												<h3>
																													Heading 3</h3>
																												<h4>
																													Heading 4</h4>
																												<strong>Getting started:</strong> Customize your template by clicking on the style editor tabs up above. Set your fonts, colors, and styles. After setting your styling is all done you can click here in this area, delete the text, and start adding your own awesome content!<br />
																												<br />
																												After you enter your content, highlight the text you want to style and select the options you set in the style editor in the &quot;styles&quot; drop down box.</div>
																										</td>
																									</tr>
																								</tbody>
																							</table>
																						</td>
																					</tr>
																				</tbody>
																			</table>
																		</td>
																	</tr>
																	<tr>
																		<td valign="top">
																			<table border="0" cellpadding="0" cellspacing="0" width="400">
																				<tbody>
																					<tr>
																						<td class="leftColumnContent" valign="top" width="180">
																							<table border="0" cellpadding="20" cellspacing="0" width="100%">
																								<tbody>
																									<tr bvrepeat="">
																										<td valign="top">
																											<img src="http://www.bvcms.com/content/images/placeholder_160.gif" style="max-width:160px;" />
																											<div bvedit="">
																												<h4>
																													Heading 4</h4>
																					'',NULL,NULL) WHERE [Id]=70
UPDATE [dbo].[Content] SET [Body].WRITE(N''							<strong>Content blocks:</strong> Put all the great things you want to say here and format it like you want it.</div>
																										</td>
																									</tr>
																								</tbody>
																							</table>
																						</td>
																						<td class="rightColumnContent" valign="top" width="180">
																							<table border="0" cellpadding="20" cellspacing="0" width="100%">
																								<tbody>
																									<tr bvrepeat="">
																										<td valign="top">
																											<img src="http://www.bvcms.com/content/images/placeholder_160.gif" style="max-width:160px;" />
																											<div bvedit="">
																												<h4>
																													Heading 4</h4>
																												<strong>Content blocks:</strong> Put all the great things you want to say here and format it like you want it.</div>
																										</td>
																									</tr>
																								</tbody>
																							</table>
																						</td>
																					</tr>
																				</tbody>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td align="center" valign="top">
											<table border="0" cellpadding="10" cellspacing="0" id="templateFooter" width="600">
												<tbody>
													<tr>
														<td class="footerContent" valign="top">
															<table border="0" cellpadding="10" cellspacing="0" width="100%">
																<tbody>
																	<tr>
																		<td colspan="2" id="social" valign="middle">
																			<div>
																				&nbsp;<a href="http://www.twitter.com/yourname">follow on Twitter</a> | <a href="http://www.facebook.com/yourname">friend on Facebook</a></div>
																		</td>
																	</tr>
																	<tr>
																		<td valign="top" width="350">
																			<br />
																			<div>
																				<strong>Our mailing address is:</strong><br />
																				2000 Appling Rd.<br />
																				Cordova, TN 38018</div>
																		</td>
																		<td valign="top" width="190">
																			<br />
																			<div bvedit="">
																				say some final words here</div>
																		</td>
																	</tr>
																	<tr>
																		<td colspan="2" id="utility" valign="middle">
																			<div mc:edit="std_utility">
																				&nbsp;{unsubscribe} | <a href="{emailhref}" target="_blank">view email in browser</a></div>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
							{track}</td>
					</tr>
				</tbody>
			</table>
		</center>
		<p>
			&nbsp;</p>
	</body>
</html>
'',NULL,NULL) WHERE [Id]=70
')
EXEC(N'INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (71, N''Basic Template'', N''Basic Template With Header'', N''<html>
	<head>
		<title></title>
		<style type="text/css">
body{margin:0; padding:0;}
			img{border:none; font-size:14px; font-weight:bold; height:auto; line-height:100%; outline:none; text-decoration:none; text-transform:capitalize;}
			#backgroundTable{height:100% !important; margin:0; padding:0; width:100% !important;}
			body, #backgroundTable{
				background-color:#FAFAFA;
			}
			#templateContainer{
				border: 1px solid #DDDDDD;
			}
			h1, .h1{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:34px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}
			h2, .h2{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:30px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}
			h3, .h3{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:26px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}
			h4, .h4{
				color:#202020;
				display:block;
				font-family:Arial;
				font-size:22px;
				font-weight:bold;
				line-height:100%;
				margin-top:0;
				margin-right:0;
				margin-bottom:10px;
				margin-left:0;
				text-align:left;
			}
			#templatePreheader{
				background-color:#FAFAFA;
			}
			.preheaderContent div{
				color:#505050;
				font-family:Arial;
				font-size:10px;
				line-height:100%;
				text-align:left;
			}
			.preheaderContent div a:link, .preheaderContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			#templateHeader{
				background-color:#D8E2EA;
				border-bottom:0;
			}
			.headerContent{
				color:#202020;
				font-family:Arial;
				font-size:34px;
				font-weight:bold;
				line-height:100%;
				padding:0;
				text-align:center;
				vertical-align:middle;
			}
			.headerContent a:link, .headerContent a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			#headerImage{
				height:auto;
				max-width:600px !important;
			}
			#templateContainer, .bodyContent{
				background-color:#FDFDFD;
			}
			.bodyContent div{
				color:#505050;
				font-family:Arial;
				font-size:14px;
				line-height:150%;
				text-align:left;
			}
			.bodyContent div a:link, .bodyContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}
			.bodyContent img{
				display:inline;
				height:auto;
			}
			#templateFooter{
				background-color:#FDFDFD;
				border-top:0;
			}
			.footerContent div{
				color:#707070;
				font-family:Arial;
				font-size:12px;
				line-height:125%;
				text-align:left;
			}
			.footerContent div a:link, .footerContent div a:visited{
				color:#336699;
				font-weight:normal;
				text-decoration:underline;
			}

			.footerContent img{
				display:inline;
			}

			#social{
				background-color:#FAFAFA;
				border:0;
			}
			#social div{
				text-align:center;
			}

			#utility{
				background-color:#FDFDFD;
				border:0;
			}
			#utility div{
				text-align:center;
			}		</style>
	</head>
	<body leftmargin="0" marginheight="0" marginwidth="0" offset="0" topmargin="0">
		<center>
			<table border="0" cellpadding="0" cellspacing="0" height="100%" id="backgroundTable" width="100%">
				<tbody>
					<tr>
						<td align="center" valign="top">
							<table border="0" cellpadding="10" cellspacing="0" id="templatePreheader" width="600">
								<tbody>
									<tr>
										<td class="preheaderContent" valign="top">
											<table border="0" cellpadding="10" cellspacing="0" width="100%">
												<tbody>
													<tr>
														<td val'', ''2013-09-09 23:32:14.270'', NULL, 2, 13, 0, 0, NULL, NULL, NULL, NULL)')
UPDATE [dbo].[Content] SET [Body].WRITE(N'ign="top">
															<div bvedit="">
																Use this area to offer a short teaser of your email&#39;&#39;s content. Text here will show in the preview area of some email clients.</div>
														</td>
														<td align="right" valign="top" width="190">
															<div bvedit="">
																put a date here if you want</div>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
							<table border="0" cellpadding="0" cellspacing="0" id="templateContainer" width="600">
								<tbody>
									<tr>
										<td align="center" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" id="templateHeader" width="600">
												<tbody>
													<tr>
														<td class="headerContent">
															<div bvedit="">
																<img id="headerImage" src="http://www.bvcms.com/content/images/placeholder_600.gif" style="max-width:600px;" /></div>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td align="center" valign="top">
											<table border="0" cellpadding="0" cellspacing="0" id="templateBody" width="600">
												<tbody>
													<tr>
														<td class="bodyContent" valign="top">
															<table border="0" cellpadding="20" cellspacing="0" width="100%">
																<tbody>
																	<tr>
																		<td valign="top">
																			<div bvedit="">
																				<h3>
																					Heading 3</h3>
																				<h4>
																					Heading 4</h4>
																				<strong>Getting started:</strong> Customize your &nbsp;template by clicking on the style editor tabs up above. Set your fonts, colors, and styles. After setting your styling is all done you can click here in this area, delete the text, and start adding your own awesome content!<br />
																				<br />
																				After you enter your content, highlight the text you want to style and select the options you set in the style editor in the &quot;styles&quot; drop down box.</div>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td align="center" valign="top">
											<table border="0" cellpadding="10" cellspacing="0" id="templateFooter" width="600">
												<tbody>
													<tr>
														<td class="footerContent" valign="top">
															<table border="0" cellpadding="10" cellspacing="0" width="100%">
																<tbody>
																	<tr>
																		<td id="utility" valign="middle">
																			<div>
																				&nbsp;Click {unsubscribe}&nbsp;{track}</div>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</center>
		<p>
			&nbsp;</p>
	</body>
</html>
',NULL,NULL) WHERE [Id]=71
INSERT INTO [dbo].[Content] ([Id], [Name], [Title], [Body], [DateCreated], [TextOnly], [TypeID], [ThumbID], [RoleID], [OwnerID], [CreatedBy], [Archived], [ArchivedFromId], [UseTimes]) VALUES (74, N'ForgotPasswordReset2', N'ForgotPasswordReset2', N'<p>Someone recently requested a new password for {email}.
To set your password, click your username below:</p>
<blockquote>{resetlink}</blockquote>
<p>If this is a mistake, please disregard this message, your password will not be changed.</p>
<p>Thanks,<br />
The BVCMS Team</p>
', '2013-09-09 23:32:14.270', NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Content] OFF
INSERT INTO [dbo].[ContributionFund] ([FundId], [CreatedBy], [CreatedDate], [FundName], [FundDescription], [FundStatusId], [FundTypeId], [FundPledgeFlag], [FundAccountCode], [FundIncomeDept], [FundIncomeAccount], [FundIncomeFund], [FundCashDept], [FundCashAccount], [FundCashFund], [OnlineSort], [NonTaxDeductible], [QBIncomeAccount], [QBAssetAccount]) VALUES (1, 1, '2010-10-30 15:36:12.533', N'General Operation', N'General Operation', 1, 1, 0, NULL, N'0', N'0', N'0', N'0', N'0', N'0', 1, NULL, 0, 0)
INSERT INTO [dbo].[ContributionFund] ([FundId], [CreatedBy], [CreatedDate], [FundName], [FundDescription], [FundStatusId], [FundTypeId], [FundPledgeFlag], [FundAccountCode], [FundIncomeDept], [FundIncomeAccount], [FundIncomeFund], [FundCashDept], [FundCashAccount], [FundCashFund], [OnlineSort], [NonTaxDeductible], [QBIncomeAccount], [QBAssetAccount]) VALUES (2, 3, '2011-09-27 15:37:43.453', N'Pledge', N'Pledge', 1, 1, 1, NULL, N'0', N'0', N'0', N'0', N'0', N'0', 2, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[ContributionsRun] ON
INSERT INTO [dbo].[ContributionsRun] ([id], [started], [count], [processed], [completed], [error], [LastSet], [CurrSet], [Sets]) VALUES (1, '2012-02-13 15:50:01.000', 0, 0, '2012-02-13 15:50:01.000', N'', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ContributionsRun] OFF
SET IDENTITY_INSERT [dbo].[ExtraData] ON
EXEC(N'INSERT INTO [dbo].[ExtraData] ([Id], [Data], [Stamp], [completed]) VALUES (1, N''<OnlineRegModel xmlns="http://schemas.datacontract.org/2004/07/CmsWeb.Models" xmlns:i="http://www.w3.org/2001/XMLSchema-instance"><_Classid i:nil="true"/><_Nologin>true</_Nologin><_Password i:nil="true"/><_TranId>1</_TranId><_UserPeopleId i:nil="true"/><_Username i:nil="true"/><_donation i:nil="true"/><_donor i:nil="true"/><_meeting i:nil="true" xmlns:a="http://schemas.datacontract.org/2004/07/CmsData"/><_x003C_URL_x003E_k__BackingField>https://starterdb.bvcms.com:443/onlinereg/Index/30?testing=true</_x003C_URL_x003E_k__BackingField><_x003C_divid_x003E_k__BackingField i:nil="true"/><_x003C_orgid_x003E_k__BackingField>30</_x003C_orgid_x003E_k__BackingField><_x003C_testing_x003E_k__BackingField>true</_x003C_testing_x003E_k__BackingField><list><OnlineRegPersonModel><CannotCreateAccount>false</CannotCreateAccount><CreatedAccount>false</CreatedAccount><NotFoundText i:nil="true"/><SawExistingAccount>false</SawExistingAccount><_Checkbox i:nil="true" xmlns:a="http://schemas.microsoft.com/2003/10/Serialization/Arrays"/><_ExtraQuestion xmlns:a="http://schemas.microsoft.com/2003/10/Serialization/Arrays"/><_Homephone i:nil="true"/><_IsFamily>false</_IsFamily><_LoggedIn>false</_LoggedIn><_MenuItem xmlns:a="http://schemas.microsoft.com/2003/10/Serialization/Arrays"/><_Middle i:nil="true"/><_Option2 i:nil="true"/><_Whatfamily i:nil="true"/><_YesNoQuestion xmlns:a="http://schemas.microsoft.com/2003/10/Serialization/Arrays"/><_notreq i:nil="true"/><_x003C_CreatingAccount_x003E_k__BackingField i:nil="true"/><_x003C_Found_x003E_k__BackingField>true</_x003C_Found_x003E_k__BackingField><_x003C_IsFilled_x003E_k__BackingField>false</_x003C_IsFilled_x003E_k__BackingField><_x003C_IsNew_x003E_k__BackingField>false</_x003C_IsNew_x003E_k__BackingField><_x003C_IsValidForContinue_x003E_k__BackingField>false</_x003C_IsValidForContinue_x003E_k__BackingField><_x003C_IsValidForExisting_x003E_k__BackingField>true</_x003C_IsValidForExisting_x003E_k__BackingField><_x003C_IsValidForNew_x003E_k__BackingField>false</_x003C_IsValidForNew_x003E_k__BackingField><_x003C_LastItem_x003E_k__BackingField>false</_x003C_LastItem_x003E_k__BackingField><_x003C_OtherOK_x003E_k__BackingField>true</_x003C_OtherOK_x003E_k__BackingField><_x003C_PeopleId_x003E_k__BackingField>64</_x003C_PeopleId_x003E_k__BackingField><_x003C_ShowAddress_x003E_k__BackingField>false</_x003C_ShowAddress_x003E_k__BackingField><_x003C_address_x003E_k__BackingField>9486 Mountain Spring Way</_x003C_address_x003E_k__BackingField><_x003C_advil_x003E_k__BackingField>true</_x003C_advil_x003E_k__BackingField><_x003C_city_x003E_k__BackingField>Germantown</_x003C_city_x003E_k__BackingField><_x003C_classid_x003E_k__BackingField i:nil="true"/><_x003C_coaching_x003E_k__BackingField i:nil="true"/><_x003C_divid_x003E_k__BackingField i:nil="true"/><_x003C_dob_x003E_k__BackingField>10/20/00</_x003C_dob_x003E_k__BackingField><_x003C_docphone_x003E_k__BackingField>901-555-6688</_x003C_docphone_x003E_k__BackingField><_x003C_doctor_x003E_k__BackingField>Dr. Smith</_x003C_doctor_x003E_k__BackingField><_x003C_email_x003E_k__BackingField>karen@bvcms.com</_x003C_email_x003E_k__BackingField><_x003C_emcontact_x003E_k__BackingField>Karen Worrell</_x003C_emcontact_x003E_k__BackingField><_x003C_emphone_x003E_k__BackingField>901-555-7799</_x003C_emphone_x003E_k__BackingField><_x003C_first_x003E_k__BackingField>Sharon </_x003C_first_x003E_k__BackingField><_x003C_fname_x003E_k__BackingField>George Eaton</_x003C_fname_x003E_k__BackingField><_x003C_gender_x003E_k__BackingField>2</_x003C_gender_x003E_k__BackingField><_x003C_grade_x003E_k__BackingField i:nil="true"/><_x003C_gradeoption_x003E_k__BackingField>4</_x003C_gradeoption_x003E_k__BackingField><_x003C_index_x003E_k__BackingField>0</_x003C_index_x003E_k__BackingField><_x003C_insurance_x003E_k__BackingField>Blue Cross</_x003C_insurance_x003E_k__BackingField><_x003C_last_x003E_k__BackingField>Eaton</_x003C_last_x003E_k__BackingField><_x003C_maalox_x003E_k__BackingField>true</_x003C_maal'', ''2011-05-29 20:19:35.977'', NULL)')
UPDATE [dbo].[ExtraData] SET [Data].WRITE(N'ox_x003E_k__BackingField><_x003C_married_x003E_k__BackingField>1</_x003C_married_x003E_k__BackingField><_x003C_medical_x003E_k__BackingField>peanuts</_x003C_medical_x003E_k__BackingField><_x003C_memberus_x003E_k__BackingField>false</_x003C_memberus_x003E_k__BackingField><_x003C_mname_x003E_k__BackingField>Cheryl Eaton</_x003C_mname_x003E_k__BackingField><_x003C_ntickets_x003E_k__BackingField i:nil="true"/><_x003C_option_x003E_k__BackingField i:nil="true"/><_x003C_orgid_x003E_k__BackingField>30</_x003C_orgid_x003E_k__BackingField><_x003C_otherchurch_x003E_k__BackingField>true</_x003C_otherchurch_x003E_k__BackingField><_x003C_paydeposit_x003E_k__BackingField>true</_x003C_paydeposit_x003E_k__BackingField><_x003C_phone_x003E_k__BackingField>9017565372</_x003C_phone_x003E_k__BackingField><_x003C_policy_x003E_k__BackingField>123</_x003C_policy_x003E_k__BackingField><_x003C_request_x003E_k__BackingField>Betsy Williams, Joan Ralston</_x003C_request_x003E_k__BackingField><_x003C_robitussin_x003E_k__BackingField>true</_x003C_robitussin_x003E_k__BackingField><_x003C_shirtsize_x003E_k__BackingField>Y M</_x003C_shirtsize_x003E_k__BackingField><_x003C_state_x003E_k__BackingField>TN</_x003C_state_x003E_k__BackingField><_x003C_suffix_x003E_k__BackingField i:nil="true"/><_x003C_tylenol_x003E_k__BackingField>true</_x003C_tylenol_x003E_k__BackingField><_x003C_zip_x003E_k__BackingField>38139</_x003C_zip_x003E_k__BackingField><count>1</count></OnlineRegPersonModel></list></OnlineRegModel>',NULL,NULL) WHERE [Id]=1
SET IDENTITY_INSERT [dbo].[ExtraData] OFF
SET IDENTITY_INSERT [dbo].[LabelFormats] ON
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (1, N'Security', 100, '1,1,0,Arial,32,securitycode,0.25,0.45,2,2~1,1,0,Arial,32,securitycode,0.75,0.45,2,2~1,1,0,Arial,16,date,0.25,0.70,2,2~1,1,0,Arial,16,date,0.75,0.70,2,2~2,1,0,4,0.5,0.1,0.5,0.9')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (2, N'Security', 200, '1,1,0,Arial,32,securitycode,0.25,0.45,2,2~1,1,0,Arial,32,securitycode,0.75,0.45,2,2~1,1,0,Arial,16,date,0.25,0.60,2,2~1,1,0,Arial,16,date,0.75,0.60,2,2~2,1,0,4,0.5,0.1,0.5,0.9')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (7, N'Main', 200, '1,1,0,Arial,20,first,0.01,0.01,1,1~1,1,0,Arial,16,last,0.016,0.14,1,1~1,1,0,Arial,10,info,0.98,0.3075,3,1~4,1,0,Arial,10,WEAR THIS LABEL,0.0375,0.3075,1,1~2,1,0,1,0.035,0.31,0.035,0.38~2,1,0,1,0.47,0.31,0.47,0.38~2,1,0,1,0.035,0.31,0.47,0.31~2,1,0,1,0.035,0.38,0.47,0.38~1,3,-0.19,Arial,12,location,0.026,0.91,1,3~1,3,-0.19,Arial,12,time,0.43,0.91,1,3~1,3,-0.19,Arial,10,org,0.056,0.99,1,3~1,3,-0.19,Arial,12,date,0.98,0.91,3,3~1,1,0,Arial,16,securitycode,0.98,0.14,3,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (8, N'Guest', 200, '1,1,0,Arial,20,first,0.010,0.015,1,1~1,1,0,Arial,16,last,0.016,0.145,1,1~1,1,0,Arial,12,guest,0.021,0.295,1,1~1,1,0,Arial,12,allergies,0.98,0.295,3,1~1,1,0,Arial,16,securitycode,0.98,0.145,3,1~1,1,0,Arial,12,location,0.026,0.425,1,1~1,1,0,Arial,12,time,0.43,0.425,1,1~1,1,0,Arial,12,date,0.98,0.425,3,1~1,1,0,Arial,10,org,0.11,0.515,1,1~3,1,0,pid,0.5,0.96,200,25,2,3')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (9, N'Main', 100, '1,1,0,Arial,20,first,0.004,0.02,1,1~1,1,0,Arial,16,last,0.010,0.28,1,1~1,1,0,Arial,10,info,0.97,0.505,3,1~4,1,0,Arial,10,WEAR THIS LABEL,0.032,0.505,1,1~2,1,0,1,0.03,0.51,0.03,0.65~2,1,0,1,0.465,0.51,0.465,0.65~2,1,0,1,0.03,0.51,0.465,0.51~2,1,0,1,0.03,0.65,0.465,0.65~1,1,0,Arial,10,location,0.026,0.82,1,3~1,1,0,Arial,10,time,0.43,0.82,1,3~1,1,0,Arial,10,date,0.97,0.82,3,3~1,1,0,Arial,10,org,0.05,0.97,1,3~1,1,0,Arial,16,securitycode,0.97,0.28,3,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (10, N'Guest', 100, '1,1,0,Arial,20,first,0.004,0.02,1,1~1,1,0,Arial,16,last,0.010,0.28,1,1~1,1,0,Arial,10,guest,0.015,0.5,1,1~1,1,0,Arial,10,allergies,0.97,0.5,3,1~1,1,0,Arial,10,location,0.026,0.82,1,3~1,1,0,Arial,10,time,0.43,0.82,1,3~1,1,0,Arial,10,date,0.97,0.82,3,3~1,1,0,Arial,10,org,0.05,0.97,1,3~1,1,0,Arial,16,securitycode,0.97,0.28,3,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (11, N'Location', 100, '1,2,0.47,Arial,14,first,0.01,0.02,1,1~1,2,0.47,Arial,10,location,0.02,0.22,1,1~1,2,0.47,Arial,10,time,0.45,0.22,1,1~1,2,0.47,Arial,10,org,0.05,0.36,1,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (12, N'Location', 200, '1,4,0.24,Arial,16,first,0.01,0.01,1,1~1,4,0.24,Arial,10,location,0.026,0.11,1,1~1,4,0.24,Arial,10,time,0.45,0.11,1,1~1,4,0.24,Arial,10,org,0.056,0.175,1,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (13, N'NameTag', 100, '1,1,0,Arial,32,first,0.50,0.56,2,3~1,1,0,Arial,24,last,0.50,0.54,2,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (14, N'NameTag', 200, '1,1,0,Arial,32,first,0.5,0.52,2,3~1,1,0,Arial,24,last,0.5,0.52,2,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (15, N'Extra', 100, '1,1,0,Arial,20,first,0.004,0.02,1,1~1,1,0,Arial,16,last,0.010,0.28,1,1~1,1,0,Arial,10,extra,0.015,0.5,1,1~1,1,0,Arial,10,allergies,0.97,0.5,3,1~1,1,0,Arial,10,location,0.026,0.82,1,3~1,1,0,Arial,10,time,0.43,0.82,1,3~1,1,0,Arial,10,date,0.97,0.82,3,3~1,1,0,Arial,10,org,0.05,0.97,1,3~1,1,0,Arial,16,securitycode,0.97,0.28,3,1')
INSERT INTO [dbo].[LabelFormats] ([Id], [Name], [Size], [Format]) VALUES (16, N'Extra', 200, '1,1,0,Arial,20,first,0.010,0.01,1,1~1,1,0,Arial,16,last,0.016,0.14,1,1~1,1,0,Arial,12,extra,0.021,0.29,1,1~1,1,0,Arial,12,allergies,0.98,0.29,3,1~1,1,0,Arial,16,securitycode,0.98,0.14,3,1~1,1,0,Arial,12,location,0.026,0.42,1,1~1,1,0,Arial,12,time,0.43,0.42,1,1~1,1,0,Arial,12,date,0.98,0.42,3,1~1,1,0,Arial,10,org,0.056,.51,1,1~3,1,0,pid,0.5,0.96,200,25,2,3')
SET IDENTITY_INSERT [dbo].[LabelFormats] OFF
SET IDENTITY_INSERT [dbo].[Ministries] ON
INSERT INTO [dbo].[Ministries] ([MinistryId], [MinistryName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RecordStatus], [DepartmentId], [MinistryDescription], [MinistryContactId], [ChurchId]) VALUES (333, N'Outreach', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Ministries] ([MinistryId], [MinistryName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RecordStatus], [DepartmentId], [MinistryDescription], [MinistryContactId], [ChurchId]) VALUES (334, N'Homebound', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Ministries] ([MinistryId], [MinistryName], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [RecordStatus], [DepartmentId], [MinistryDescription], [MinistryContactId], [ChurchId]) VALUES (335, N'Life Groups', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Ministries] OFF
SET IDENTITY_INSERT [dbo].[Picture] ON
INSERT INTO [dbo].[Picture] ([PictureId], [CreatedDate], [CreatedBy], [LargeId], [MediumId], [SmallId], [ThumbId]) VALUES (1, '2012-01-20 15:08:45.873', N'karenw', 12, 11, 10, NULL)
SET IDENTITY_INSERT [dbo].[Picture] OFF
SET IDENTITY_INSERT [dbo].[Program] ON
INSERT INTO [dbo].[Program] ([Id], [Name], [RptGroup], [StartHoursOffset], [EndHoursOffset]) VALUES (1, N'First Program', N'1', 1, 24)
SET IDENTITY_INSERT [dbo].[Program] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (1, N'Admin', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (2, N'Access', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (3, N'Attendance', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (4, N'Edit', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (5, N'Membership', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (6, N'OrgTagger', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (8, N'Finance', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (9, N'Developer', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (11, N'ApplicationReview', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (12, N'Coupon', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (13, N'Manager', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (14, N'OrgLeadersOnly', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (15, N'ManageEmails', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (17, N'Manager2', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (18, N'Checkin', NULL)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (19, N'ManageTransactions', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (20, N'ScheduleEmails', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (22, N'Coupon2', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (23, N'ContentEdit', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (24, N'Design', 1)
INSERT INTO [dbo].[Roles] ([RoleId], [RoleName], [hardwired]) VALUES (25, N'ManageGroups', 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'AdminCoupon', N'YourPasswordGoesHere')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'AdminMail', N'david@bvcms.com')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'BlogAppUrl', N'http://blog.bvcms.com')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'BlogFeedUrl', N'http://feeds.feedburner.com/BvcmsBlog')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'DbConvertedDate', N'5/5/2009')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'DefaultHost', N'https://StarterDb.bvcms.com')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'M_ID', NULL)
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'M_Key', NULL)
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'MaxExcelRows', N'10000')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'MinContributionAmount', N'25')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'NewPeopleManagerIds', N'3')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'StartAddress', NULL)
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'StatusFlags', N'F04,F01,F02,F03')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'TransactionGateway', NULL)
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'TZOffset', N'0')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'UseEmailTemplates', N'true')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'UseMemberProfileAutomation', N'true')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'UseNewSupport', N'true')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'UseOldCheckin', N'false')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'UseStandardExtraValues', N'true')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'UseStatusFlags', N'true')
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'x_login', NULL)
INSERT INTO [dbo].[Setting] ([Id], [Setting]) VALUES (N'x_tran_key', NULL)
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ALLEE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ALLEY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ALLY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ALY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ANEX')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ANNEX')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ANNX')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ANX')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ARC')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ARCADE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AVE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AVEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AVENU')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AVENUE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AVN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'AVNUE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BAYOO')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BCH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BEACH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BEND')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BLF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BLFS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BLUF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BLUFF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BLUFFS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BLVD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BND')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BOT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BOTTM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BOTTOM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BOUL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BOULEVARD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BOULV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRANCH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRDGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRIDGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BRNCH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BROOK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BROOKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BTM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BURG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BURGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BYP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BYPA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BYPAS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BYPASS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BYPS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'BYU')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CAMP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CANYN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CANYON')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CAPE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CAUSEWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CAUSWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CENT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CENTER')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CENTERS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CENTR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CENTRE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CIR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CIRC')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CIRCL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CIRCLE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CIRCLES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CIRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CLB')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CLF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CLFS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CLIFF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CLIFFS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CLUB')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CMN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CMP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CNTER')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CNTR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CNYN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COMMON')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CORNER')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CORNERS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CORS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COURSE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COURT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COURTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COVE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'COVES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CPE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRCL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRCLE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRECENT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CREEK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRESCENT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRESENT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CREST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CROSSING')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CROSSROAD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRSCNT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRSE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRSENT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRSNT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRSSING')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRSSNG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CRT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CSWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CTR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CTRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CURV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CURVE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CVS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'CYN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DALE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DAM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DIV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DIVIDE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DRIV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DRIVE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DRIVES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DRV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'DVD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ESTATE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ESTATES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ESTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXPR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXPRESS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXPRESSWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXPW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXPY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXTENSION')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXTENSIONS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXTN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXTNSN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'EXTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FALL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FALLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FERRY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FIELD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FIELDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLAT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLATS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FLTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FOREST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORESTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORGES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FORT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FREEWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FREEWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRRY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FRY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'FWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GARDEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GARDENS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GARDN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GATEWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GATEWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GDN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GDNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GLEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GLENS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GLN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GLNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRDEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRDN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRDNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GREEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GREENS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GROV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GROVE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GROVES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GRVS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GTWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'GTWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HARB')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HARBOR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HARBORS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HARBR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HAVEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HAVN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HBR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HBRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HEIGHT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HEIGHTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HGTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HIGHWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HIGHWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HILL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HILLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HIWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HIWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HLLW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HOLLOW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HOLLOWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HOLW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HOLWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HRBOR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HVN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'HWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'INLET')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'INLT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'IS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISLAND')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISLANDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISLE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISLES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISLND')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISLNDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ISS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JCT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JCTION')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JCTN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JCTNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JCTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JUNCTION')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JUNCTIONS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JUNCTN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'JUNCTON')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KEY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KEYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KNL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KNLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KNOL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KNOLL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KNOLLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'KYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LAKE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LAKES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LAND')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LANDING')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LANE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LANES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LCK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LCKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LDG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LDGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LGT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LGTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LIGHT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LIGHTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LNDG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LNDNG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LOAF')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LOCK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LOCKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LODG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LODGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LOOP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'LOOPS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MALL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MANOR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MANORS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MDW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MDWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MEADOW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MEADOWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MEDOWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MEWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MILL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MILLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MISSION')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MISSN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ML')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MNR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MNRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MNT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MNTAIN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MNTN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MNTNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MOTORWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MOUNT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MOUNTAIN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MOUNTAINS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MOUNTIN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MSN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MSSN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MTIN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MTN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MTNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'MTWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'NCK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'NECK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'OPAS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ORCH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ORCHARD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ORCHRD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'OVAL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'OVERPASS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'OVL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PARK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PARKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PARKWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PARKWAYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PARKWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PASS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PASSAGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PATH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PATHS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PIKE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PIKES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PINE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PINES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PKWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PKWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PKWYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PKY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLACE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLAIN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLAINES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLAINS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLAZA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLZ')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PLZA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PNE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PNES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'POINT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'POINTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PORT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PORTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PRAIRIE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PRARIE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PRK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PRR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PRT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PRTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PSGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'PTS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RAD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RADIAL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RADIEL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RADL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RAMP')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RANCH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RANCHES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RAPID')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RAPIDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RDG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RDGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RDGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'REST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RIDGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RIDGES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RIV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RIVER')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RIVR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RNCH')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RNCHS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ROAD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ROADS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ROUTE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ROW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RPD')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RPDS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RTE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RUN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'RVR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHOAL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHOALS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHOAR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHOARS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHORE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHORES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SHRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SKWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SKYWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SMT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPNG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPNGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPRING')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPRINGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPRNG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPRNGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPUR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SPURS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQ')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQRE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQRS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQU')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQUARE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SQUARES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'ST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STATION')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STATN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRAV')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRAVE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRAVEN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRAVENUE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRAVN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STREAM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STREET')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STREETS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STREME')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRM')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRVN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STRVNUE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'STS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SUMIT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'SUMITT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TER')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TERR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TERRACE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'THROUGHWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TPK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TPKE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TR')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRACE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRACES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRACK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRACKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRAFFICWAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRAIL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRAILS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRAK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRCE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRFY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRNPK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRPK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TRWY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TUNEL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TUNL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TUNLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TUNNEL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TUNNELS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TUNNL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TURNPIKE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'TURNPK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'UN')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'UNDERPASS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'UNION')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'UNIONS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'UNS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'UPAS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VALLEY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VALLEYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VALLY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VDCT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIADCT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIADUCT')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIEW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIEWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILLAG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILLAGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILLAGES')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILLE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILLG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VILLIAGE')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VIST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VISTA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VLG')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VLGS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VLLY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VLY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VLYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VST')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VSTA')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VW')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'VWS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WALK')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WALKS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WALL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WAY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WAYS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WELL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WELLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WL')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WLS')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'WY')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'XING')
INSERT INTO [dbo].[StreetTypes] ([Type]) VALUES (N'XRD')
INSERT INTO [dbo].[TagType] ([Id], [Name]) VALUES (1, N'Personal')
INSERT INTO [dbo].[TagType] ([Id], [Name]) VALUES (3, N'CouplesHelper')
INSERT INTO [dbo].[TagType] ([Id], [Name]) VALUES (4, N'AddSelected')
INSERT INTO [dbo].[TagType] ([Id], [Name]) VALUES (5, N'OrgMembersOnly')
INSERT INTO [dbo].[TagType] ([Id], [Name]) VALUES (6, N'OrgLeadersOnly')
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ability', 1)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'able', 2)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'aboard', 3)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'about', 4)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'above', 5)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'accept', 6)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'accident', 7)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'according', 8)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'account', 9)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'accurate', 10)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'acres', 11)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'across', 12)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'act', 13)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'action', 14)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'active', 15)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'activity', 16)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'actual', 17)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'actually', 18)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'add', 19)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'addition', 20)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'additional', 21)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'adjective', 22)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'adult', 23)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'adventure', 24)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'advice', 25)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'affect', 26)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'afraid', 27)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'after', 28)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'afternoon', 29)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'again', 30)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'against', 31)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'age', 32)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ago', 33)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'agree', 34)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ahead', 35)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'aid', 36)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'air', 37)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'airplane', 38)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Alice', 39)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'alike', 40)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'alive', 41)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'all', 42)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'allow', 43)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'almost', 44)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'alone', 45)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'along', 46)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'aloud', 47)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'alphabet', 48)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'already', 49)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'also', 50)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'although', 51)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'among', 52)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'amount', 53)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'an', 54)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ancient', 55)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'and', 56)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'angle', 57)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'angry', 58)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'animal', 59)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'announced', 60)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'another', 61)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'answer', 62)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ants', 63)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'any', 64)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'anybody', 65)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'anyone', 66)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'anything', 67)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'anyway', 68)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'anywhere', 69)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'apart', 70)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'apartment', 71)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'appearance', 72)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'apple', 73)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'applied', 74)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'appropriate', 75)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'are', 76)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'area', 77)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'arm', 78)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'army', 79)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'around', 80)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'arrange', 81)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'arrangement', 82)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'arrive', 83)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'arrow', 84)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'art', 85)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'article', 86)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'as', 87)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Asia', 88)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'aside', 89)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ask', 90)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'asleep', 91)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'at', 92)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ate', 93)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'atmosphere', 94)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'atom', 95)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'atomic', 96)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'attached', 97)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'attack', 98)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'attempt', 99)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'attention', 100)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'audience', 101)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'author', 102)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'automobile', 103)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'available', 104)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'average', 105)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'avoid', 106)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'aware', 107)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'away', 108)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'baby', 109)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'back', 110)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bad', 111)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'badly', 112)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bag', 113)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'balance', 114)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ball', 115)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'balloon', 116)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'band', 117)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bank', 118)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bar', 119)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bare', 120)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bark', 121)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'barn', 122)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'base', 123)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'baseball', 124)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'basic', 125)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'basis', 126)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'basket', 127)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bat', 128)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'battle', 129)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Bay', 130)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'be', 131)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bean', 132)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bear', 133)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beat', 134)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beautiful', 135)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beauty', 136)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'became', 137)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'because', 138)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'become', 139)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'becoming', 140)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bee', 141)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'been', 142)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'before', 143)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'began', 144)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beginning', 145)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'begun', 146)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'behavior', 147)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'behind', 148)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'being', 149)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'believed', 150)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bell', 151)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'belong', 152)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'below', 153)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'belt', 154)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bend', 155)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beneath', 156)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bent', 157)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beside', 158)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'best', 159)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bet', 160)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Betsy', 161)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'better', 162)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'between', 163)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'beyond', 164)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bicycle', 165)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bigger', 166)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'biggest', 167)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bill', 168)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'birds', 169)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'birth', 170)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'birthday', 171)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bit', 172)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bite', 173)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'black', 174)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blank', 175)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blanket', 176)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blew', 177)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blind', 178)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'block', 179)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blood', 180)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blow', 181)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'blue', 182)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'board', 183)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'boat', 184)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'body', 185)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bone', 186)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'book', 187)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'border', 188)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'born', 189)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'both', 190)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bottle', 191)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bottom', 192)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bound', 193)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bow', 194)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bowl', 195)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'box', 196)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'boy', 197)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brain', 198)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'branch', 199)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brass', 200)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brave', 201)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bread', 202)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'break', 203)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'breakfast', 204)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'breath', 205)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'breathe', 206)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'breathing', 207)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'breeze', 208)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brick', 209)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bridge', 210)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brief', 211)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bright', 212)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bring', 213)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'broad', 214)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'broke', 215)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'broken', 216)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brother', 217)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brought', 218)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brown', 219)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'brush', 220)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'buffalo', 221)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'build', 222)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'building', 223)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'built', 224)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'buried', 225)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'burn', 226)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'burst', 227)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bus', 228)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'bush', 229)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'business', 230)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'busy', 231)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'but', 232)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'butter', 233)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'buy', 234)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'by', 235)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cabin', 236)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cage', 237)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cake', 238)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'call', 239)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'calm', 240)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'came', 241)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'camera', 242)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'camp', 243)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'can', 244)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Canada', 245)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'canal', 246)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cannot', 247)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cap', 248)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'capital', 249)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'captain', 250)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'captured', 251)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'car', 252)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'carbon', 253)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'card', 254)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'care', 255)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'careful', 256)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'carefully', 257)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'carried', 258)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'carry', 259)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'case', 260)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Casey', 261)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cast', 262)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'castle', 263)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cat', 264)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'catch', 265)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cattle', 266)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'caught', 267)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cause', 268)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cave', 269)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cell', 270)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cent', 271)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'center', 272)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'central', 273)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'century', 274)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'certain', 275)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'certainly', 276)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chain', 277)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chair', 278)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chamber', 279)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chance', 280)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'change', 281)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'changing', 282)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chapter', 283)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'character', 284)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'characteristic', 285)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'charge', 286)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chart', 287)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'check', 288)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cheese', 289)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chemical', 290)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chest', 291)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Chicago', 292)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chicken', 293)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chief', 294)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'child', 295)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'children', 296)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'choice', 297)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'choose', 298)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chose', 299)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'chosen', 300)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Christmas', 301)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'church', 302)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'circle', 303)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'circus', 304)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'citizen', 305)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'city', 306)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'class', 307)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'classroom', 308)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'claws', 309)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clay', 310)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clean', 311)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clear', 312)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clearly', 313)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'climate', 314)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'climb', 315)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clock', 316)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'close', 317)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'closely', 318)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'closer', 319)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cloth', 320)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clothes', 321)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'clothing', 322)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cloud', 323)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'club', 324)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'coach', 325)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'coal', 326)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'coast', 327)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'coat', 328)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'coffee', 329)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cold', 330)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'collect', 331)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'college', 332)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'colony', 333)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'color', 334)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'column', 335)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'combination', 336)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'combine', 337)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'come', 338)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'comfortable', 339)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'coming', 340)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'command', 341)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'common', 342)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'community', 343)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'company', 344)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'compare', 345)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'compass', 346)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'complete', 347)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'completely', 348)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'complex', 349)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'composed', 350)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'composition', 351)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'compound', 352)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'concerned', 353)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'condition', 354)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'congress', 355)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'connected', 356)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'consider', 357)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'consist', 358)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'consonant', 359)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'constantly', 360)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'construction', 361)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'contain', 362)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'continent', 363)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'continued', 364)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'contrast', 365)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'control', 366)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'conversation', 367)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cook', 368)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cookies', 369)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cool', 370)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'copper', 371)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'copy', 372)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'corn', 373)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'corner', 374)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'correct', 375)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'correctly', 376)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cost', 377)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cotton', 378)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'could', 379)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'count', 380)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'country', 381)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'couple', 382)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'courage', 383)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'course', 384)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'court', 385)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cover', 386)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cow', 387)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cowboy', 388)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'crack', 389)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cream', 390)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'create', 391)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'creature', 392)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'crew', 393)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'crop', 394)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cross', 395)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'crowd', 396)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cry', 397)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cup', 398)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'curious', 399)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'current', 400)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'curve', 401)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'customs', 402)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cut', 403)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'cutting', 404)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'daily', 405)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'damage', 406)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dance', 407)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'danger', 408)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dangerous', 409)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dark', 410)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'darkness', 411)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'date', 412)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'daughter', 413)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dawn', 414)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'day', 415)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dead', 416)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'deal', 417)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dear', 418)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'death', 419)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'decide', 420)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'declared', 421)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'deep', 422)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'deeply', 423)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'deer', 424)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'definition', 425)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'degree', 426)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'depend', 427)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'depth', 428)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'describe', 429)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'desert', 430)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'design', 431)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'desk', 432)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'detail', 433)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'determine', 434)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'develop', 435)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'development', 436)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'diagram', 437)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'diameter', 438)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'did', 439)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'die', 440)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'differ', 441)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'difference', 442)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'different', 443)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'difficult', 444)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'difficulty', 445)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dig', 446)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dinner', 447)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'direct', 448)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'direction', 449)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'directly', 450)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dirt', 451)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dirty', 452)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'disappear', 453)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'discover', 454)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'discovery', 455)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'discuss', 456)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'discussion', 457)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'disease', 458)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dish', 459)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'distance', 460)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'distant', 461)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'divide', 462)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'division', 463)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'do', 464)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'doctor', 465)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'does', 466)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dog', 467)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'doing', 468)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'doll', 469)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dollar', 470)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'done', 471)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'donkey', 472)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'door', 473)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dot', 474)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'double', 475)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'doubt', 476)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'down', 477)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dozen', 478)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'draw', 479)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'drawn', 480)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dream', 481)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dress', 482)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'drew', 483)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dried', 484)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'drink', 485)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'drive', 486)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'driven', 487)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'driver', 488)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'driving', 489)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'drop', 490)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dropped', 491)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'drove', 492)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dry', 493)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'duck', 494)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'due', 495)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dug', 496)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dull', 497)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'during', 498)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'dust', 499)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'duty', 500)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'each', 501)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eager', 502)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ear', 503)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'earlier', 504)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'early', 505)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'earn', 506)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'earth', 507)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'easier', 508)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'easily', 509)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'east', 510)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'easy', 511)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eat', 512)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eaten', 513)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eddy', 514)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'edge', 515)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'education', 516)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'effect', 517)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'effort', 518)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'egg', 519)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eight', 520)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'either', 521)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'electric', 522)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'electricity', 523)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'element', 524)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'elephant', 525)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eleven', 526)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'else', 527)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'empty', 528)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'end', 529)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'enemy', 530)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'energy', 531)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'engine', 532)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'engineer', 533)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'enjoy', 534)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'enough', 535)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'enter', 536)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'entire', 537)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'entirely', 538)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'environment', 539)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'equal', 540)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'equally', 541)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'equator', 542)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'equipment', 543)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'escape', 544)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'especially', 545)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'essential', 546)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'establish', 547)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'even', 548)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'evening', 549)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'event', 550)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eventually', 551)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ever', 552)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'every', 553)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'everybody', 554)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'everyone', 555)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'everything', 556)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'everywhere', 557)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'evidence', 558)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exact', 559)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exactly', 560)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'examine', 561)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'example', 562)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'excellent', 563)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'except', 564)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exchange', 565)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'excited', 566)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'excitement', 567)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exciting', 568)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exclaimed', 569)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exercise', 570)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'exist', 571)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'expect', 572)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'experience', 573)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'experiment', 574)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'explain', 575)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'explanation', 576)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'explore', 577)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'express', 578)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'expression', 579)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'extra', 580)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'eye', 581)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'face', 582)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'facing', 583)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fact', 584)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'factor', 585)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'factory', 586)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'failed', 587)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fair', 588)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fairly', 589)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fall', 590)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fallen', 591)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'familiar', 592)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'family', 593)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'famous', 594)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'far', 595)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'farm', 596)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'farmer', 597)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'farther', 598)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fast', 599)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fastened', 600)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'faster', 601)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fat', 602)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'father', 603)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'favorite', 604)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fear', 605)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'feathers', 606)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'feature', 607)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fed', 608)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'feed', 609)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'feel', 610)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'feet', 611)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fell', 612)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fellow', 613)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'felt', 614)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fence', 615)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'few', 616)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fewer', 617)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'field', 618)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fierce', 619)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fifteen', 620)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fifth', 621)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fifty', 622)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fight', 623)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fighting', 624)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'figure', 625)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fill', 626)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'film', 627)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'final', 628)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'finally', 629)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'find', 630)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fine', 631)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'finest', 632)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'finger', 633)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'finish', 634)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fire', 635)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fireplace', 636)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'firm', 637)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'first', 638)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fish', 639)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'five', 640)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fix', 641)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flag', 642)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flame', 643)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flat', 644)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flew', 645)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flies', 646)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flight', 647)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'floating', 648)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'floor', 649)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flow', 650)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'flower', 651)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fly', 652)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fog', 653)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'folks', 654)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'follow', 655)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'food', 656)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'foot', 657)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'football', 658)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'for', 659)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'force', 660)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'foreign', 661)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forest', 662)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forget', 663)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forgot', 664)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forgotten', 665)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'form', 666)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'former', 667)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fort', 668)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forth', 669)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forty', 670)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'forward', 671)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fought', 672)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'found', 673)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'four', 674)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fourth', 675)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fox', 676)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'frame', 677)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'free', 678)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'freedom', 679)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'frequently', 680)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fresh', 681)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'friend', 682)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'friendly', 683)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'frighten', 684)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'frog', 685)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'from', 686)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'front', 687)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'frozen', 688)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fruit', 689)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fuel', 690)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'full', 691)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fully', 692)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fun', 693)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'function', 694)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'funny', 695)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'fur', 696)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'furniture', 697)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'further', 698)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'future', 699)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gain', 700)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'game', 701)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'garage', 702)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'garden', 703)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gas', 704)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gasoline', 705)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gate', 706)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gather', 707)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gave', 708)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'general', 709)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'generally', 710)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gentle', 711)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gently', 712)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'get', 713)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'getting', 714)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'giant', 715)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gift', 716)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'girl', 717)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'give', 718)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'given', 719)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'giving', 720)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'glad', 721)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'glass', 722)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'globe', 723)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'go', 724)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'goes', 725)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gold', 726)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'golden', 727)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gone', 728)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'good', 729)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'goose', 730)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'got', 731)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'government', 732)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grabbed', 733)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grade', 734)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gradually', 735)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grain', 736)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grandfather', 737)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grandmother', 738)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'graph', 739)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grass', 740)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gravity', 741)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gray', 742)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'great', 743)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'greater', 744)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'greatest', 745)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'greatly', 746)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'green', 747)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grew', 748)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ground', 749)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'group', 750)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grow', 751)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'grown', 752)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'growth', 753)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'guard', 754)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'guess', 755)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'guide', 756)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gulf', 757)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'gun', 758)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'habit', 759)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'had', 760)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hair', 761)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'half', 762)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'halfway', 763)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hall', 764)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hand', 765)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'handle', 766)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'handsome', 767)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hang', 768)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'happen', 769)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'happened', 770)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'happily', 771)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'happy', 772)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'harbor', 773)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hard', 774)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'harder', 775)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hardly', 776)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'has', 777)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hat', 778)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'have', 779)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'having', 780)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hay', 781)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'he', 782)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'headed', 783)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'heading', 784)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'health', 785)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'heard', 786)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hearing', 787)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'heart', 788)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'heat', 789)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'heavy', 790)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'height', 791)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'held', 792)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hello', 793)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'help', 794)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'helpful', 795)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'her', 796)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'herd', 797)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'here', 798)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'herself', 799)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hidden', 800)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hide', 801)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'high', 802)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'higher', 803)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'highest', 804)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'highway', 805)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hill', 806)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'him', 807)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'himself', 808)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'his', 809)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'history', 810)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hit', 811)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hold', 812)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hole', 813)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hollow', 814)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'home', 815)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'honor', 816)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hope', 817)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'horn', 818)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'horse', 819)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hospital', 820)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hot', 821)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hour', 822)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'house', 823)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'how', 824)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'however', 825)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'huge', 826)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'human', 827)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hundred', 828)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hung', 829)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hungry', 830)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hunt', 831)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hunter', 832)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hurried', 833)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hurry', 834)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'hurt', 835)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'husband', 836)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ice', 837)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'idea', 838)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'identity', 839)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ill', 840)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'image', 841)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'imagine', 842)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'immediately', 843)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'importance', 844)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'important', 845)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'impossible', 846)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'improve', 847)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'in', 848)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'inch', 849)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'include', 850)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'including', 851)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'income', 852)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'increase', 853)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'indeed', 854)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'independent', 855)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'indicate', 856)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'individual', 857)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'industrial', 858)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'industry', 859)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'influence', 860)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'information', 861)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'inside', 862)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'instance', 863)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'instant', 864)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'instead', 865)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'instrument', 866)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'interest', 867)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'interior', 868)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'into', 869)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'introduced', 870)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'invented', 871)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'involved', 872)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'iron', 873)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'is', 874)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'island', 875)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'it', 876)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'itself', 877)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'jack', 878)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'jar', 879)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'jet', 880)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'job', 881)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'join', 882)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'joined', 883)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'journey', 884)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'joy', 885)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'judge', 886)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'jump', 887)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'jungle', 888)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'just', 889)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'keep', 890)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'kept', 891)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'key', 892)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'kids', 893)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'kill', 894)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'kind', 895)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'kitchen', 896)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'knew', 897)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'knife', 898)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'know', 899)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'knowledge', 900)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'known', 901)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'label', 902)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'labor', 903)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lack', 904)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lady', 905)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'laid', 906)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lake', 907)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lamp', 908)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'land', 909)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'language', 910)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'large', 911)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'larger', 912)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'largest', 913)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'last', 914)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'late', 915)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'later', 916)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'laugh', 917)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'law', 918)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lay', 919)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'layers', 920)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lead', 921)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'leader', 922)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'leaf', 923)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'learn', 924)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'least', 925)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'leather', 926)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'leave', 927)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'leaving', 928)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'led', 929)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'left', 930)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'leg', 931)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'length', 932)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lesson', 933)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'let', 934)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'letter', 935)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'level', 936)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'library', 937)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lie', 938)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'life', 939)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lift', 940)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'light', 941)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'like', 942)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'likely', 943)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'limited', 944)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'line', 945)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lion', 946)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lips', 947)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'liquid', 948)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'list', 949)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'listen', 950)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'little', 951)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'live', 952)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'living', 953)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'load', 954)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'local', 955)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'locate', 956)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'location', 957)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'log', 958)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lonely', 959)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'long', 960)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'longer', 961)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'look', 962)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'loose', 963)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lose', 964)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'loss', 965)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lost', 966)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lot', 967)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'loud', 968)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Louis', 969)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'love', 970)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lovely', 971)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'low', 972)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lower', 973)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'luck', 974)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lucky', 975)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lunch', 976)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lungs', 977)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'lying', 978)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'machine', 979)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'machinery', 980)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mad', 981)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'made', 982)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'magic', 983)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'magnet', 984)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mail', 985)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'main', 986)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mainly', 987)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'major', 988)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'make', 989)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'making', 990)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'man', 991)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'managed', 992)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'manner', 993)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'manufacturing', 994)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'many', 995)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'map', 996)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mark', 997)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'market', 998)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'married', 999)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mass', 1000)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'massage', 1001)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'master', 1002)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'material', 1003)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mathematics', 1004)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'matter', 1005)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'may', 1006)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'maybe', 1007)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'me', 1008)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'meal', 1009)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mean', 1010)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'means', 1011)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'meant', 1012)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'measure', 1013)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'meat', 1014)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'medicine', 1015)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'meet', 1016)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'melted', 1017)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'member', 1018)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'memory', 1019)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'men', 1020)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mental', 1021)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'merely', 1022)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'met', 1023)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'metal', 1024)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'method', 1025)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mice', 1026)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'middle', 1027)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'might', 1028)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mighty', 1029)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mile', 1030)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'military', 1031)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'milk', 1032)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mill', 1033)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mind', 1034)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mine', 1035)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'minerals', 1036)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'minute', 1037)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mirror', 1038)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'missing', 1039)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mission', 1040)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mistake', 1041)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mix', 1042)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mixture', 1043)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'model', 1044)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'modern', 1045)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'molecular', 1046)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'moment', 1047)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'money', 1048)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'monkey', 1049)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'month', 1050)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mood', 1051)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'moon', 1052)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'more', 1053)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'morning', 1054)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'most', 1055)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mostly', 1056)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mother', 1057)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'motion', 1058)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'motor', 1059)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mountain', 1060)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mouse', 1061)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mouth', 1062)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'move', 1063)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'movement', 1064)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'movie', 1065)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'moving', 1066)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mud', 1067)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'muscle', 1068)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'music', 1069)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'musical', 1070)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'must', 1071)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'my', 1072)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'myself', 1073)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'mysterious', 1074)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nails', 1075)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'name', 1076)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nation', 1077)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'national', 1078)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'native', 1079)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'natural', 1080)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'naturally', 1081)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nature', 1082)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'near', 1083)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nearby', 1084)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nearer', 1085)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nearest', 1086)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nearly', 1087)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'necessary', 1088)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'neck', 1089)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'needed', 1090)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'needle', 1091)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'needs', 1092)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'negative', 1093)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'neighbor', 1094)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'neighborhood', 1095)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nervous', 1096)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nest', 1097)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'never', 1098)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'new', 1099)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'news', 1100)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'newspaper', 1101)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'next', 1102)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nice', 1103)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'night', 1104)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nine', 1105)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'no', 1106)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nobody', 1107)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nodded', 1108)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'noise', 1109)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'none', 1110)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'noon', 1111)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nor', 1112)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'north', 1113)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nose', 1114)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'not', 1115)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'note', 1116)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'noted', 1117)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nothing', 1118)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'notice', 1119)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'noun', 1120)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'now', 1121)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'number', 1122)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'numeral', 1123)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'nuts', 1124)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'object', 1125)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'observe', 1126)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'obtain', 1127)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'occasionally', 1128)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'occur', 1129)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ocean', 1130)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'of', 1131)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'off', 1132)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'offer', 1133)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'office', 1134)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'officer', 1135)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'official', 1136)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Ohio', 1137)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'oil', 1138)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'old', 1139)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'older', 1140)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'oldest', 1141)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'on', 1142)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'once', 1143)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'one', 1144)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'only', 1145)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'onto', 1146)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'open', 1147)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'operation', 1148)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'opinion', 1149)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'opportunity', 1150)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'opposite', 1151)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'or', 1152)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'orange', 1153)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'orbit', 1154)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'order', 1155)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ordinary', 1156)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'organization', 1157)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'organized', 1158)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'origin', 1159)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'original', 1160)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'other', 1161)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ought', 1162)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'our', 1163)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ourselves', 1164)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'out', 1165)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'outer', 1166)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'outline', 1167)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'outside', 1168)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'over', 1169)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'own', 1170)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'owner', 1171)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'oxygen', 1172)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pack', 1173)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'package', 1174)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'page', 1175)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'paid', 1176)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pain', 1177)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'paint', 1178)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pair', 1179)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'palace', 1180)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pale', 1181)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pan', 1182)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'paper', 1183)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'paragraph', 1184)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'parallel', 1185)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'parent', 1186)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'Paris', 1187)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'park', 1188)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'part', 1189)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'particles', 1190)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'particular', 1191)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'particularly', 1192)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'partly', 1193)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'parts', 1194)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'party', 1195)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pass', 1196)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'passage', 1197)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'past', 1198)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'path', 1199)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pattern', 1200)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pay', 1201)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'peace', 1202)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pen', 1203)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pencil', 1204)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'people', 1205)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'per', 1206)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'percent', 1207)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'perfect', 1208)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'perfectly', 1209)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'perhaps', 1210)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'period', 1211)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'person', 1212)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'personal', 1213)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pet', 1214)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'phrase', 1215)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'physical', 1216)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'piano', 1217)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pick', 1218)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'picture', 1219)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pictured', 1220)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pie', 1221)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'piece', 1222)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pig', 1223)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pile', 1224)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pilot', 1225)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pine', 1226)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pink', 1227)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pipe', 1228)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pitch', 1229)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'place', 1230)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plain', 1231)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plan', 1232)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plane', 1233)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'planet', 1234)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'planned', 1235)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'planning', 1236)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plant', 1237)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plastic', 1238)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plate', 1239)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plates', 1240)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'play', 1241)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pleasant', 1242)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'please', 1243)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pleasure', 1244)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plenty', 1245)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plural', 1246)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'plus', 1247)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pocket', 1248)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'poem', 1249)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'poet', 1250)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'poetry', 1251)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'point', 1252)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pole', 1253)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'police', 1254)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'policeman', 1255)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'political', 1256)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pond', 1257)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pony', 1258)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pool', 1259)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'poor', 1260)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'popular', 1261)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'population', 1262)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'porch', 1263)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'port', 1264)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'position', 1265)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'positive', 1266)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'possible', 1267)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'possibly', 1268)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'post', 1269)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pot', 1270)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'potatoes', 1271)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pound', 1272)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pour', 1273)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'powder', 1274)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'power', 1275)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'powerful', 1276)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'practical', 1277)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'practice', 1278)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'prepare', 1279)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'present', 1280)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'president', 1281)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'press', 1282)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pressure', 1283)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pretty', 1284)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'prevent', 1285)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'previous', 1286)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'price', 1287)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pride', 1288)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'primitive', 1289)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'principal', 1290)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'principle', 1291)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'printed', 1292)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'private', 1293)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'prize', 1294)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'probably', 1295)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'problem', 1296)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'process', 1297)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'produce', 1298)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'product', 1299)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'production', 1300)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'program', 1301)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'progress', 1302)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'promised', 1303)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'proper', 1304)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'properly', 1305)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'property', 1306)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'protection', 1307)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'proud', 1308)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'prove', 1309)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'provide', 1310)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'public', 1311)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pull', 1312)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pupil', 1313)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'pure', 1314)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'purple', 1315)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'purpose', 1316)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'push', 1317)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'put', 1318)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'putting', 1319)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'quarter', 1320)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'queen', 1321)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'question', 1322)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'quick', 1323)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'quickly', 1324)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'quiet', 1325)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'quietly', 1326)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'quite', 1327)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rabbit', 1328)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'race', 1329)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'radio', 1330)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'railroad', 1331)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rain', 1332)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'raise', 1333)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ran', 1334)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ranch', 1335)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'range', 1336)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rapidly', 1337)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rate', 1338)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rather', 1339)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'raw', 1340)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rays', 1341)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'reach', 1342)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'read', 1343)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'reader', 1344)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ready', 1345)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'real', 1346)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'realize', 1347)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rear', 1348)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'reason', 1349)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'recall', 1350)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'receive', 1351)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'recent', 1352)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'recently', 1353)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'recognize', 1354)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'record', 1355)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'red', 1356)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'refer', 1357)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'refused', 1358)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'region', 1359)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'regular', 1360)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'related', 1361)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'relationship', 1362)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'religious', 1363)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'remain', 1364)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'remarkable', 1365)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'remember', 1366)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'remove', 1367)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'repeat', 1368)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'replace', 1369)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'replied', 1370)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'report', 1371)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'represent', 1372)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'require', 1373)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'research', 1374)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'respect', 1375)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rest', 1376)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'result', 1377)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'return', 1378)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'review', 1379)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rhyme', 1380)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rhythm', 1381)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rice', 1382)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rich', 1383)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ride', 1384)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'riding', 1385)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'right', 1386)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ring', 1387)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rise', 1388)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rising', 1389)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'river', 1390)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'road', 1391)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'roar', 1392)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rock', 1393)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rocket', 1394)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rocky', 1395)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rod', 1396)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'roll', 1397)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'roof', 1398)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'room', 1399)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'root', 1400)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rope', 1401)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rose', 1402)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rough', 1403)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'round', 1404)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'route', 1405)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'row', 1406)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rubbed', 1407)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rubber', 1408)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rule', 1409)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ruler', 1410)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'run', 1411)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'running', 1412)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'rush', 1413)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sad', 1414)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'saddle', 1415)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'safe', 1416)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'safety', 1417)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'said', 1418)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sail', 1419)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sale', 1420)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'salmon', 1421)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'salt', 1422)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'same', 1423)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sand', 1424)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sang', 1425)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sat', 1426)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'satellites', 1427)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'satisfied', 1428)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'save', 1429)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'saved', 1430)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'saw', 1431)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'say', 1432)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'scale', 1433)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'scared', 1434)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'scene', 1435)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'school', 1436)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'science', 1437)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'scientific', 1438)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'scientist', 1439)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'score', 1440)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'screen', 1441)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sea', 1442)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'search', 1443)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'season', 1444)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seat', 1445)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'second', 1446)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'secret', 1447)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'section', 1448)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'see', 1449)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seed', 1450)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seeing', 1451)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seems', 1452)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seen', 1453)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seldom', 1454)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'select', 1455)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'selection', 1456)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sell', 1457)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'send', 1458)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sense', 1459)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sent', 1460)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sentence', 1461)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'separate', 1462)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'series', 1463)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'serious', 1464)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'serve', 1465)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'service', 1466)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sets', 1467)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'setting', 1468)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'settle', 1469)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'settlers', 1470)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'seven', 1471)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'several', 1472)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shade', 1473)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shadow', 1474)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shake', 1475)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shaking', 1476)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shall', 1477)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shallow', 1478)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shape', 1479)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'share', 1480)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sharp', 1481)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'she', 1482)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sheep', 1483)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sheet', 1484)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shelf', 1485)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shells', 1486)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shelter', 1487)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shine', 1488)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shinning', 1489)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ship', 1490)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shirt', 1491)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shoe', 1492)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shoot', 1493)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shop', 1494)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shore', 1495)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'short', 1496)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shorter', 1497)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shot', 1498)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'should', 1499)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shoulder', 1500)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shout', 1501)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'show', 1502)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shown', 1503)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'shut', 1504)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sick', 1505)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sides', 1506)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sight', 1507)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sign', 1508)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'signal', 1509)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'silence', 1510)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'silent', 1511)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'silk', 1512)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'silly', 1513)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'silver', 1514)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'similar', 1515)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'simple', 1516)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'simplest', 1517)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'simply', 1518)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'since', 1519)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sing', 1520)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'single', 1521)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sink', 1522)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sister', 1523)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sit', 1524)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sitting', 1525)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'situation', 1526)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'six', 1527)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'size', 1528)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'skill', 1529)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'skin', 1530)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sky', 1531)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slabs', 1532)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slave', 1533)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sleep', 1534)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slept', 1535)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slide', 1536)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slight', 1537)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slightly', 1538)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slip', 1539)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slipped', 1540)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slope', 1541)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slow', 1542)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'slowly', 1543)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'small', 1544)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'smaller', 1545)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'smallest', 1546)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'smell', 1547)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'smile', 1548)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'smoke', 1549)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'smooth', 1550)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'snake', 1551)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'snow', 1552)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'so', 1553)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'soap', 1554)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'social', 1555)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'society', 1556)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'soft', 1557)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'softly', 1558)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'soil', 1559)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'solar', 1560)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sold', 1561)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'soldier', 1562)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'solid', 1563)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'solution', 1564)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'solve', 1565)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'some', 1566)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'somebody', 1567)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'somehow', 1568)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'someone', 1569)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'something', 1570)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sometime', 1571)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'somewhere', 1572)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'son', 1573)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'song', 1574)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'soon', 1575)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sort', 1576)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sound', 1577)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'source', 1578)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'south', 1579)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'southern', 1580)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'space', 1581)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'speak', 1582)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'special', 1583)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'species', 1584)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'specific', 1585)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'speech', 1586)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'speed', 1587)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spell', 1588)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spend', 1589)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spent', 1590)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spider', 1591)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spin', 1592)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spirit', 1593)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spite', 1594)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'split', 1595)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spoken', 1596)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sport', 1597)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spread', 1598)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'spring', 1599)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'square', 1600)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stage', 1601)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stairs', 1602)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stand', 1603)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'standard', 1604)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'star', 1605)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stared', 1606)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'start', 1607)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'state', 1608)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'statement', 1609)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'States', 1610)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'station', 1611)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stay', 1612)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'steady', 1613)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'steam', 1614)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'steel', 1615)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'steep', 1616)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stems', 1617)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'step', 1618)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stepped', 1619)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stick', 1620)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stiff', 1621)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'still', 1622)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stock', 1623)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stomach', 1624)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stone', 1625)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stood', 1626)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stop', 1627)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stopped', 1628)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'store', 1629)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'storm', 1630)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'story', 1631)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stove', 1632)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'straight', 1633)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'strange', 1634)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stranger', 1635)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'straw', 1636)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stream', 1637)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'street', 1638)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'strength', 1639)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stretch', 1640)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'strike', 1641)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'string', 1642)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'strip', 1643)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'strong', 1644)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stronger', 1645)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'struck', 1646)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'structure', 1647)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'struggle', 1648)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'stuck', 1649)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'student', 1650)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'studied', 1651)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'studying', 1652)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'subject', 1653)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'substance', 1654)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'success', 1655)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'successful', 1656)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'such', 1657)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sudden', 1658)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'suddenly', 1659)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sugar', 1660)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'suggest', 1661)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'suit', 1662)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sum', 1663)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'summer', 1664)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sun', 1665)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sunlight', 1666)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'supper', 1667)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'supply', 1668)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'support', 1669)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'suppose', 1670)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sure', 1671)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'surface', 1672)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'surprise', 1673)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'surrounded', 1674)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'swam', 1675)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'sweet', 1676)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'swept', 1677)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'swim', 1678)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'swimming', 1679)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'swing', 1680)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'swung', 1681)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'syllable', 1682)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'symbol', 1683)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'system', 1684)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'table', 1685)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tail', 1686)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'take', 1687)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'taken', 1688)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tales', 1689)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'talk', 1690)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tall', 1691)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tank', 1692)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tape', 1693)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'task', 1694)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'taste', 1695)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'taught', 1696)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tax', 1697)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tea', 1698)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'teach', 1699)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'teacher', 1700)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'team', 1701)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tears', 1702)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'teeth', 1703)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'telephone', 1704)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'television', 1705)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tell', 1706)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'temperature', 1707)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'ten', 1708)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tent', 1709)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'term', 1710)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'terrible', 1711)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'test', 1712)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'than', 1713)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thank', 1714)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'that', 1715)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'the', 1716)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'them', 1717)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'themselves', 1718)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'then', 1719)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'theory', 1720)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'there', 1721)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'therefore', 1722)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'these', 1723)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'they', 1724)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thick', 1725)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thin', 1726)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thing', 1727)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'think', 1728)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'third', 1729)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thirty', 1730)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'this', 1731)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'those', 1732)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thou', 1733)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'though', 1734)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thought', 1735)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thousand', 1736)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thread', 1737)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'three', 1738)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'threw', 1739)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'throat', 1740)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'through', 1741)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'throughout', 1742)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'throw', 1743)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thrown', 1744)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thumb', 1745)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thus', 1746)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'thy', 1747)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tide', 1748)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tie', 1749)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tight', 1750)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tightly', 1751)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'till', 1752)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'time', 1753)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tin', 1754)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tiny', 1755)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tip', 1756)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tired', 1757)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'title', 1758)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'to', 1759)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tobacco', 1760)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'today', 1761)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'together', 1762)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'told', 1763)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tomorrow', 1764)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tone', 1765)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tongue', 1766)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tonight', 1767)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'too', 1768)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'took', 1769)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tool', 1770)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'top', 1771)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'topic', 1772)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'torn', 1773)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'total', 1774)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'touch', 1775)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'toward', 1776)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tower', 1777)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'town', 1778)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'toy', 1779)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trace', 1780)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'track', 1781)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trade', 1782)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'traffic', 1783)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trail', 1784)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'train', 1785)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'transportation', 1786)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trap', 1787)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'travel', 1788)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'treated', 1789)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tree', 1790)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'triangle', 1791)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tribe', 1792)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trick', 1793)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tried', 1794)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trip', 1795)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'troops', 1796)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tropical', 1797)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trouble', 1798)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'truck', 1799)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'trunk', 1800)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'truth', 1801)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'try', 1802)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tube', 1803)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'tune', 1804)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'turn', 1805)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'twelve', 1806)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'twenty', 1807)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'twice', 1808)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'two', 1809)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'type', 1810)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'typical', 1811)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'uncle', 1812)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'under', 1813)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'underline', 1814)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'understanding', 1815)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'unhappy', 1816)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'union', 1817)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'unit', 1818)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'universe', 1819)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'unknown', 1820)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'unless', 1821)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'until', 1822)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'unusual', 1823)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'up', 1824)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'upon', 1825)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'upper', 1826)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'upward', 1827)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'us', 1828)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'use', 1829)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'useful', 1830)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'using', 1831)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'usual', 1832)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'usually', 1833)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'valley', 1834)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'valuable', 1835)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'value', 1836)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vapor', 1837)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'variety', 1838)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'various', 1839)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vast', 1840)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vegetable', 1841)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'verb', 1842)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vertical', 1843)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'very', 1844)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vessels', 1845)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'victory', 1846)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'view', 1847)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'village', 1848)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'visit', 1849)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'visitor', 1850)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'voice', 1851)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'volume', 1852)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vote', 1853)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'vowel', 1854)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'voyage', 1855)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wagon', 1856)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wait', 1857)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'walk', 1858)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wall', 1859)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'want', 1860)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'war', 1861)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'warm', 1862)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'warn', 1863)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'was', 1864)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wash', 1865)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'waste', 1866)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'watch', 1867)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'water', 1868)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wave', 1869)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'way', 1870)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'we', 1871)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'weak', 1872)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wealth', 1873)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wear', 1874)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'weather', 1875)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'week', 1876)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'weigh', 1877)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'weight', 1878)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'welcome', 1879)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'well', 1880)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'went', 1881)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'were', 1882)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'west', 1883)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'western', 1884)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wet', 1885)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whale', 1886)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'what', 1887)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whatever', 1888)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wheat', 1889)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wheel', 1890)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'when', 1891)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whenever', 1892)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'where', 1893)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wherever', 1894)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whether', 1895)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'which', 1896)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'while', 1897)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whispered', 1898)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whistle', 1899)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'white', 1900)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'who', 1901)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whole', 1902)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whom', 1903)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'whose', 1904)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'why', 1905)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wide', 1906)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'widely', 1907)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wife', 1908)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wild', 1909)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'will', 1910)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'willing', 1911)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'win', 1912)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wind', 1913)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'window', 1914)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wing', 1915)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'winter', 1916)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wire', 1917)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wise', 1918)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wish', 1919)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'with', 1920)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'within', 1921)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'without', 1922)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wolf', 1923)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'women', 1924)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'won', 1925)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wonder', 1926)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wonderful', 1927)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wood', 1928)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wooden', 1929)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wool', 1930)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wore', 1932)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'work', 1933)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'worker', 1934)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'world', 1935)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'worried', 1936)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'worry', 1937)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'worse', 1938)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'worth', 1939)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'would', 1940)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wrapped', 1941)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'write', 1942)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'writer', 1943)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'writing', 1944)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'written', 1945)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wrong', 1946)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'wrote', 1947)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'yard', 1948)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'year', 1949)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'yellow', 1950)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'yes', 1951)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'yesterday', 1952)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'yet', 1953)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'you', 1954)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'young', 1955)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'younger', 1956)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'your', 1957)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'yourself', 1958)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'youth', 1959)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'zero', 1960)
INSERT INTO [dbo].[words] ([word], [n]) VALUES (N'zoo', 1961)
INSERT INTO [lookup].[AddressType] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'F1', N'Family', 1)
INSERT INTO [lookup].[AddressType] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'P1', N'Personal', 1)
INSERT INTO [lookup].[AttendCredit] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'E', N'Every Meeting', 1)
INSERT INTO [lookup].[AttendCredit] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'W', N'Once Per Week Group 1', 1)
INSERT INTO [lookup].[AttendCredit] ([Id], [Code], [Description], [Hardwired]) VALUES (3, N'W', N'Once Per Week Group 2', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'L', N'Leader', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'VO', N'Volunteer', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'M', N'Member', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'VM', N'Visiting Member', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'RG', N'Recent Guest', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'NG', N'New Guest', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (70, N'ISM', N'In-Service', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (80, N'OFS', N'Offsite', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (90, N'GRP', N'Group', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (100, N'HMB', N'Homebound', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (110, N'OC', N'Other Class', 1)
INSERT INTO [lookup].[AttendType] ([Id], [Code], [Description], [Hardwired]) VALUES (190, N'PR', N'Prospect', 1)
INSERT INTO [lookup].[BaptismStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'(not specified)', 1)
INSERT INTO [lookup].[BaptismStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'SCH', N'Scheduled', 1)
INSERT INTO [lookup].[BaptismStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'NSC', N'Not Scheduled', 1)
INSERT INTO [lookup].[BaptismStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'CMP', N'Completed', 1)
INSERT INTO [lookup].[BaptismStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'CAN', N'Cancelled', 1)
INSERT INTO [lookup].[BaptismType] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'(not specified)', 1)
INSERT INTO [lookup].[BaptismType] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'ORI', N'Original', 1)
INSERT INTO [lookup].[BaptismType] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'SUB', N'Subsequent', 1)
INSERT INTO [lookup].[BaptismType] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'BIO', N'Biological', 1)
INSERT INTO [lookup].[BaptismType] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'NON', N'Non-Member', 1)
INSERT INTO [lookup].[BaptismType] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'RFM', N'Required', 1)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'G', N'Generic Envelopes', NULL)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'LC', N'Loose Checks and Cash', 1)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (3, N'PE', N'Preprinted Envelopes', 1)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (4, N'OL', N'Online', 1)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (5, N'OLP', N'Online Pledge', 1)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (6, N'PL', N'Pledge', 1)
INSERT INTO [lookup].[BundleHeaderTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'GK', N'Gifts in Kind', 1)
INSERT INTO [lookup].[BundleStatusTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'C', N'Closed', 1)
INSERT INTO [lookup].[BundleStatusTypes] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'O', N'Open', 1)
INSERT INTO [lookup].[ContactPreference] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NO', N'Do Not Contact', NULL)
INSERT INTO [lookup].[ContactPreference] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'PST', N'Mail', NULL)
INSERT INTO [lookup].[ContactPreference] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'PHN', N'Phone', NULL)
INSERT INTO [lookup].[ContactPreference] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'EML', N'Email', NULL)
INSERT INTO [lookup].[ContactPreference] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'VST', N'Visit', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (99, N'U', N'Unknown', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (100, N'B', N'Bereavement', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (110, N'H', N'Health', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (120, N'P', N'Personal', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (130, N'OR', N'Out-Reach', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (140, N'IR', N'In-Reach', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (150, N'I', N'Information', NULL)
INSERT INTO [lookup].[ContactReason] ([Id], [Code], [Description], [Hardwired]) VALUES (160, N'O', N'Other', 1)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'PV', N'Personal Visit', NULL)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'PC', N'Phone Call', NULL)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (3, N'L', N'Letter Sent', NULL)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (4, N'C', N'Card Sent', NULL)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (5, N'E', N'EMail Sent', NULL)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (6, N'I', N'Info Pack Sent', NULL)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (7, N'O', N'Other', 1)
INSERT INTO [lookup].[ContactType] ([Id], [Code], [Description], [Hardwired]) VALUES (99, N'U', N'Unknown', NULL)
INSERT INTO [lookup].[ContributionStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'C', N'Recorded', 1)
INSERT INTO [lookup].[ContributionStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'V', N'Reversed', 1)
INSERT INTO [lookup].[ContributionStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'R', N'Returned', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'CC', N'Check/Cash', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (5, N'OL', N'Online', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (6, N'RC', N'Returned Check', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (7, N'RV', N'Reversed', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (8, N'PL', N'Pledge', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (9, N'NT', N'Non Tax-Deductible', 1)
INSERT INTO [lookup].[ContributionType] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'GK', N'Gift in Kind', 1)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'US', N'United States', 1)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'NA', N'USA, Not Validated', 1)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (3, N'AF', N'Afghanistan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (4, N'AX', N'Aland Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (5, N'AL', N'Albania', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (6, N'DZ', N'Algeria', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (7, N'AS', N'American Samoa', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (8, N'AD', N'Andorra', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (9, N'AO', N'Angola', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'AI', N'Anguilla', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (11, N'AQ', N'Antarctica', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (12, N'AG', N'Antigua and Barbuda', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (13, N'AR', N'Argentina', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (14, N'AM', N'Armenia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (15, N'AW', N'Aruba', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (16, N'AU', N'Australia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (17, N'AT', N'Austria', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (18, N'AZ', N'Azerbaijan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (19, N'BS', N'Bahamas, The', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'BH', N'Bahrain', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (21, N'BD', N'Bangladesh', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (22, N'BB', N'Barbados', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (23, N'BY', N'Belarus', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (24, N'BE', N'Belgium', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (25, N'BZ', N'Belize', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (26, N'BJ', N'Benin', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (27, N'BM', N'Bermuda', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (28, N'BT', N'Bhutan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (29, N'BO', N'Bolivia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'BQ', N'Bonaire, Saint Eustatius and Saba', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (31, N'BA', N'Bosnia and Herzegovina', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (32, N'BW', N'Botswana', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (33, N'BV', N'Bouvet Island', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (34, N'BR', N'Brazil', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (35, N'IO', N'British Indian Ocean Territory', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (36, N'BN', N'Brunei Darussalam', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (37, N'BG', N'Bulgaria', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (38, N'BF', N'Burkina Faso', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (39, N'BI', N'Burundi', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'KH', N'Cambodia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (41, N'CM', N'Cameroon', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (42, N'CA', N'Canada', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (43, N'CV', N'Cape Verde', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (44, N'KY', N'Cayman Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (45, N'CF', N'Central African Republic', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (46, N'TD', N'Chad', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (47, N'CL', N'Chile', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (48, N'CN', N'China', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (49, N'CX', N'Christmas Island', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'CC', N'Cocos (Keeling) Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (51, N'CO', N'Colombia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (52, N'KM', N'Comoros', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (53, N'CG', N'Congo', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (54, N'CD', N'Congo, The Democratic Republic Of The', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (55, N'CK', N'Cook Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (56, N'CR', N'Costa Rica', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (57, N'CI', N'Cote D''ivoire', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (58, N'HR', N'Croatia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (59, N'CW', N'CuraÃ§ao', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'CY', N'Cyprus', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (61, N'CZ', N'Czech Republic', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (62, N'DK', N'Denmark', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (63, N'DJ', N'Djibouti', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (64, N'DM', N'Dominica', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (65, N'DO', N'Dominican Republic', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (66, N'EC', N'Ecuador', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (67, N'EG', N'Egypt', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (68, N'SV', N'El Salvador', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (69, N'GQ', N'Equatorial Guinea', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (70, N'ER', N'Eritrea', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (71, N'EE', N'Estonia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (72, N'ET', N'Ethiopia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (73, N'FK', N'Falkland Islands (Malvinas)', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (74, N'FO', N'Faroe Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (75, N'FJ', N'Fiji', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (76, N'FI', N'Finland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (77, N'FR', N'France', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (78, N'GF', N'French Guiana', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (79, N'PF', N'French Polynesia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (80, N'TF', N'French Southern Territories', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (81, N'GA', N'Gabon', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (82, N'GM', N'Gambia, The', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (83, N'GE', N'Georgia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (84, N'DE', N'Germany', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (85, N'GH', N'Ghana', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (86, N'GI', N'Gibraltar', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (87, N'GR', N'Greece', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (88, N'GL', N'Greenland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (89, N'GD', N'Grenada', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (90, N'GP', N'Guadeloupe', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (91, N'GU', N'Guam', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (92, N'GT', N'Guatemala', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (93, N'GG', N'Guernsey', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (94, N'GN', N'Guinea', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (95, N'GW', N'Guinea-Bissau', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (96, N'GY', N'Guyana', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (97, N'HT', N'Haiti', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (98, N'HM', N'Heard Island and the McDonald Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (99, N'VA', N'Holy See', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (100, N'HN', N'Honduras', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (101, N'HK', N'Hong Kong', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (102, N'HU', N'Hungary', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (103, N'IS', N'Iceland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (104, N'IN', N'India', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (105, N'ID', N'Indonesia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (106, N'IQ', N'Iraq', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (107, N'IE', N'Ireland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (108, N'IM', N'Isle Of Man', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (109, N'IL', N'Israel', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (110, N'IT', N'Italy', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (111, N'JM', N'Jamaica', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (112, N'JP', N'Japan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (113, N'JE', N'Jersey', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (114, N'JO', N'Jordan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (115, N'KZ', N'Kazakhstan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (116, N'KE', N'Kenya', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (117, N'KI', N'Kiribati', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (118, N'KR', N'Korea, Republic Of', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (119, N'KW', N'Kuwait', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (120, N'KG', N'Kyrgyzstan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (121, N'LA', N'Lao People''s Democratic Republic', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (122, N'LV', N'Latvia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (123, N'LB', N'Lebanon', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (124, N'LS', N'Lesotho', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (125, N'LR', N'Liberia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (126, N'LY', N'Libya', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (127, N'LI', N'Liechtenstein', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (128, N'LT', N'Lithuania', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (129, N'LU', N'Luxembourg', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (130, N'MO', N'Macao', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (131, N'MK', N'Macedonia, The Former Yugoslav Republic Of', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (132, N'MG', N'Madagascar', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (133, N'MW', N'Malawi', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (134, N'MY', N'Malaysia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (135, N'MV', N'Maldives', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (136, N'ML', N'Mali', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (137, N'MT', N'Malta', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (138, N'MH', N'Marshall Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (139, N'MQ', N'Martinique', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (140, N'MR', N'Mauritania', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (141, N'MU', N'Mauritius', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (142, N'YT', N'Mayotte', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (143, N'MX', N'Mexico', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (144, N'FM', N'Micronesia, Federated States Of', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (145, N'MD', N'Moldova, Republic Of', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (146, N'MC', N'Monaco', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (147, N'MN', N'Mongolia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (148, N'ME', N'Montenegro', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (149, N'MS', N'Montserrat', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (150, N'MA', N'Morocco', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (151, N'MZ', N'Mozambique', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (152, N'MM', N'Myanmar', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (153, N'NA', N'Namibia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (154, N'NR', N'Nauru', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (155, N'NP', N'Nepal', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (156, N'NL', N'Netherlands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (157, N'AN', N'Netherlands Antilles', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (158, N'NC', N'New Caledonia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (159, N'NZ', N'New Zealand', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (160, N'NI', N'Nicaragua', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (161, N'NE', N'Niger', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (162, N'NG', N'Nigeria', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (163, N'NU', N'Niue', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (164, N'NF', N'Norfolk Island', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (165, N'MP', N'Northern Mariana Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (166, N'NO', N'Norway', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (167, N'OM', N'Oman', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (168, N'PK', N'Pakistan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (169, N'PW', N'Palau', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (170, N'PS', N'Palestinian Territories', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (171, N'PA', N'Panama', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (172, N'PG', N'Papua New Guinea', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (173, N'PY', N'Paraguay', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (174, N'PE', N'Peru', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (175, N'PH', N'Philippines', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (176, N'PN', N'Pitcairn', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (177, N'PL', N'Poland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (178, N'PT', N'Portugal', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (179, N'PR', N'Puerto Rico', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (180, N'QA', N'Qatar', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (181, N'RE', N'Reunion', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (182, N'RO', N'Romania', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (183, N'RU', N'Russian Federation', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (184, N'RW', N'Rwanda', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (185, N'BL', N'Saint Barthelemy', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (186, N'SH', N'Saint Helena', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (187, N'KN', N'Saint Kitts and Nevis', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (188, N'LC', N'Saint Lucia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (189, N'MF', N'Saint Martin', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (190, N'PM', N'Saint Pierre and Miquelon', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (191, N'VC', N'Saint Vincent and The Grenadines', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (192, N'WS', N'Samoa', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (193, N'SM', N'San Marino', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (194, N'ST', N'Sao Tome and Principe', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (195, N'SA', N'Saudi Arabia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (196, N'SN', N'Senegal', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (197, N'RS', N'Serbia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (198, N'SC', N'Seychelles', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (199, N'SL', N'Sierra Leone', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (200, N'SG', N'Singapore', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (201, N'SX', N'Sint Maarten', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (202, N'SK', N'Slovakia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (203, N'SI', N'Slovenia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (204, N'SB', N'Solomon Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (205, N'SO', N'Somalia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (206, N'ZA', N'South Africa', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (207, N'GS', N'South Georgia and the South Sandwich Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (208, N'ES', N'Spain', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (209, N'LK', N'Sri Lanka', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (210, N'SR', N'Suriname', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (211, N'SJ', N'Svalbard and Jan Mayen', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (212, N'SZ', N'Swaziland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (213, N'SE', N'Sweden', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (214, N'CH', N'Switzerland', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (215, N'TW', N'Taiwan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (216, N'TJ', N'Tajikistan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (217, N'TZ', N'Tanzania, United Republic Of', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (218, N'TH', N'Thailand', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (219, N'TL', N'Timor-leste', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (220, N'TG', N'Togo', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (221, N'TK', N'Tokelau', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (222, N'TO', N'Tonga', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (223, N'TT', N'Trinidad and Tobago', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (224, N'TN', N'Tunisia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (225, N'TR', N'Turkey', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (226, N'TM', N'Turkmenistan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (227, N'TC', N'Turks and Caicos Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (228, N'TV', N'Tuvalu', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (229, N'UG', N'Uganda', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (230, N'UA', N'Ukraine', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (231, N'AE', N'United Arab Emirates', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (232, N'GB', N'United Kingdom', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (234, N'UM', N'United States Minor Outlying Islands', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (235, N'UY', N'Uruguay', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (236, N'UZ', N'Uzbekistan', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (237, N'VU', N'Vanuatu', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (238, N'VE', N'Venezuela', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (239, N'VN', N'Vietnam', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (240, N'VG', N'Virgin Islands, British', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (241, N'VI', N'Virgin Islands, U.S.', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (242, N'WF', N'Wallis and Futuna', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (243, N'EH', N'Western Sahara', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (244, N'YE', N'Yemen', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (245, N'ZM', N'Zambia', NULL)
INSERT INTO [lookup].[Country] ([Id], [Code], [Description], [Hardwired]) VALUES (246, N'ZW', N'Zimbabwe', NULL)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'UNK', N'Unknown', 1)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'POF-MEM', N'POF for Membership', 1)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'POF-NON', N'POF NOT for Membership', 1)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'LETTER', N'Letter', 1)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'STATEMENT', N'Statement', 1)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'BAP-REQD', N'Stmt requiring Baptism', 1)
INSERT INTO [lookup].[DecisionType] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'CANCELLED', N'Cancelled', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NON', N'Non-Dropped', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'ADM', N'Administrative', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'DEC', N'Deceased', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'LET', N'Lettered Out', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'REQ', N'Requested Drop', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'AND', N'Another Denomination', 1)
INSERT INTO [lookup].[DropType] ([Id], [Code], [Description], [Hardwired]) VALUES (98, N'OTH', N'Other', 1)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'(not specified)', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'BFC', N'Main Fellowship', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (15, N'ENROLL', N'Other Enrollments', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (17, N'ONLINE', N'Online Registration', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'WORSHIP', N'Worship', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'SPEC', N'Special Events', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (98, N'OTHER', N'Other', NULL)
INSERT INTO [lookup].[EntryPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (99, N'UNKNOWN', N'Unknown', NULL)
INSERT INTO [lookup].[EnvelopeOption] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'Null', N'(not specified)', 1)
INSERT INTO [lookup].[EnvelopeOption] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'I', N'Individual', 1)
INSERT INTO [lookup].[EnvelopeOption] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'J', N'Joint', 1)
INSERT INTO [lookup].[EnvelopeOption] ([Id], [Code], [Description], [Hardwired]) VALUES (9, N'N', N'None', 1)
INSERT INTO [lookup].[FamilyMemberType] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'ADU', N'Adult', NULL)
INSERT INTO [lookup].[FamilyMemberType] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'CHI', N'Child', NULL)
INSERT INTO [lookup].[FamilyPosition] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'Primary', N'Primary Adult', 1)
INSERT INTO [lookup].[FamilyPosition] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'Other', N'Secondary Adult', 1)
INSERT INTO [lookup].[FamilyPosition] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'Child', N'Child', 1)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (100, N'HOH', N'Head of Household', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (110, N'SPS', N'Spouse', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (120, N'SEC', N'Secondary Adult', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (130, N'AUN', N'Aunt', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (135, N'UNC', N'Uncle', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (140, N'GRM', N'Grand Mother', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (145, N'GRF', N'Grand Father', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (200, N'CHI', N'Child', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (210, N'DTR', N'Daughter', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (215, N'SON', N'Son', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (220, N'NCE', N'Niece', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (225, N'NPH', N'Nephew', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (230, N'GRD', N'Grand Daughter', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (235, N'GRS', N'Grand Son', NULL)
INSERT INTO [lookup].[FamilyRelationship] ([Id], [Code], [Description], [Hardwired]) VALUES (980, N'OTH', N'Other', NULL)
INSERT INTO [lookup].[Gender] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'U', N'Unknown', NULL)
INSERT INTO [lookup].[Gender] ([Id], [Code], [Description], [Hardwired]) VALUES (1, N'M', N'Male', NULL)
INSERT INTO [lookup].[Gender] ([Id], [Code], [Description], [Hardwired]) VALUES (2, N'F', N'Female', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'(not specified)', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'TV', N'TV', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'Radio', N'Radio', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'Newspaper', N'Newspaper', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (35, N'Mail', N'Mail', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'Friend', N'Friend', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'Relative', N'Relative', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'BillBoard', N'Billboard', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (70, N'Website', N'Website', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (98, N'Other', N'Other', NULL)
INSERT INTO [lookup].[InterestPoint] ([Id], [Code], [Description], [Hardwired]) VALUES (99, N'UNKNOWN', N'Unknown', NULL)
INSERT INTO [lookup].[JoinType] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'UNK', N'Unknown', 1)
INSERT INTO [lookup].[JoinType] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'BPP', N'Baptism POF', 1)
INSERT INTO [lookup].[JoinType] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'BPS', N'Baptism SRB', 1)
INSERT INTO [lookup].[JoinType] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'BPB', N'Baptism BIO', 1)
INSERT INTO [lookup].[JoinType] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'STM', N'Statement', 1)
INSERT INTO [lookup].[JoinType] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'LET', N'Letter', 1)
INSERT INTO [lookup].[MaritalStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'UNK', N'Unknown', 1)
INSERT INTO [lookup].[MaritalStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'SNG', N'Single', 1)
INSERT INTO [lookup].[MaritalStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'MAR', N'Married', 1)
INSERT INTO [lookup].[MaritalStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'SEP', N'Separated', NULL)
INSERT INTO [lookup].[MaritalStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'DIV', N'Divorced', 1)
INSERT INTO [lookup].[MaritalStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'WID', N'Widowed', 1)
INSERT INTO [lookup].[MeetingType] ([Id], [Code], [Description], [Hardwired]) VALUES (0, 'G', N'Group', NULL)
INSERT INTO [lookup].[MeetingType] ([Id], [Code], [Description], [Hardwired]) VALUES (1, 'R', N'Roster', NULL)
INSERT INTO [lookup].[MemberLetterStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'(not specified)', NULL)
INSERT INTO [lookup].[MemberLetterStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'1stReq', N'1st Request', NULL)
INSERT INTO [lookup].[MemberLetterStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'2ndReq', N'2nd Request', NULL)
INSERT INTO [lookup].[MemberLetterStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'Non-Resp', N'Non-Responsive', NULL)
INSERT INTO [lookup].[MemberLetterStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'Complete', N'Complete', NULL)
INSERT INTO [lookup].[MemberStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'Member', N'Member', 1)
INSERT INTO [lookup].[MemberStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'NonMember', N'Not Member', NULL)
INSERT INTO [lookup].[MemberStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'Pending', N'Pending Member', NULL)
INSERT INTO [lookup].[MemberStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'Previous', N'Previous Member', 1)
INSERT INTO [lookup].[MemberStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'Added', N'Just Added', 1)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'', N'', 1)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (100, N'Mr.', N'Mr.', NULL)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (110, N'Mrs.', N'Mrs.', NULL)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (120, N'Ms.', N'Ms.', NULL)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (130, N'Miss', N'Miss', NULL)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (140, N'Dr.', N'Dr.', NULL)
INSERT INTO [lookup].[NameTitle] ([Id], [Code], [Description], [Hardwired]) VALUES (150, N'Rev.', N'Rev.', NULL)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'(not specified)', 1)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'PN', N'Pending', 1)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'AT', N'Attended', 1)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'AA', N'Admin Approval', 1)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'GF', N'Grandfathered', 1)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'EX', N'Exempted Child (thru Grade 8)', 1)
INSERT INTO [lookup].[NewMemberClassStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (99, N'UNK', N'Unknown', NULL)
INSERT INTO [lookup].[OrganizationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'A', N'Active', 1)
INSERT INTO [lookup].[OrganizationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'I', N'Inactive', 1)
INSERT INTO [lookup].[Origin] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NSP', N'Not Specified', NULL)
INSERT INTO [lookup].[Origin] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'VISIT', N'Visit', 1)
INSERT INTO [lookup].[Origin] ([Id], [Code], [Description], [Hardwired]) VALUES (70, N'ENROLL', N'Enrollment', 1)
INSERT INTO [lookup].[Origin] ([Id], [Code], [Description], [Hardwired]) VALUES (90, N'CONTRIB', N'Contribution', 1)
INSERT INTO [lookup].[Origin] ([Id], [Code], [Description], [Hardwired]) VALUES (97, N'MENU', N'Main Menu', 1)
INSERT INTO [lookup].[Origin] ([Id], [Code], [Description], [Hardwired]) VALUES (100, N'FAM', N'New Family Member', 1)
INSERT INTO [lookup].[ResidentCode] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'M', N'Metro', NULL)
INSERT INTO [lookup].[ResidentCode] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'G', N'Marginal', NULL)
INSERT INTO [lookup].[ResidentCode] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'N', N'Non-Resident', NULL)
INSERT INTO [lookup].[ResidentCode] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'U', N'Unable to Locate', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'YT-S', N'Youth: Small (6-8)', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'YT-M', N'Youth: Medium (10-12)', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'YT-L', N'Youth: Large (14-16)', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'AD-S', N'Adult: Small', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'AD-M', N'Adult: Medium', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'AD-L', N'Adult: Large', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (70, N'AD-XL', N'Adult: X-Large', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (80, N'AD-XXL', N'Adult: XX-Large', NULL)
INSERT INTO [lookup].[ShirtSizes] ([Id], [Code], [Description], [Hardwired]) VALUES (90, N'AD-XXXL', N'Adult: XXX-Large', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AA', N'Armed Forces America', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AB', N'Alberta', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AE', N'Armed Forces East', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AK', N'Alaska', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AL', N'Alabama', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AP', N'Armed Forces Pacific', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AR', N'Arkansas', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'AZ', N'Arizona', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'BC', N'British Columbia', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'CA', N'California', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'CO', N'Colorado', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'CT', N'Connecticut', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'CZ', N'Canal Zone', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'DC', N'District Of Columbia', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'DE', N'Delaware', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'FL', N'Florida', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'FR', N'Foreign Address', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'GA', N'Georgia', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'GU', N'Guam', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'HI', N'Hawaii', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'IA', N'Iowa', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'ID', N'Idaho', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'IL', N'Illinois', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'IN', N'Indiana', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'KS', N'Kansas', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'KY', N'Kentucky', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'LA', N'Louisiana', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MA', N'Massachusetts', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MB', N'Manatoba', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MD', N'Maryland', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'ME', N'Maine', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MI', N'Michigan', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MN', N'Minnesota', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MO', N'Missouri', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MS', N'Mississippi', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'MT', N'Montana', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NB', N'New Brunswick', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NC', N'North Carolina', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'ND', N'North Dakota', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NE', N'Nebraska', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NH', N'New Hampshire', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NJ', N'New Jersey', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NL', N'Newfoundland and Labrador', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NM', N'New Mexico', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NS', N'Nova Scotia', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NT', N'Northwest Territories', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NU', N'Nunavut', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NV', N'Nevada', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'NY', N'New York', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'OH', N'Ohio', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'OK', N'Oklahoma', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'ON', N'Ontario', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'OR', N'Oregon', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'PA', N'Pennsylvania', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'PE', N'Prince Edward Island', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'PR', N'Puerto Rico', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'QC', N'Quebec', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'RI', N'Rhode Island', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'SC', N'South Carolina', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'SD', N'South Dakota', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'SK', N'Saskatchewan', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'TN', N'Tennessee', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'TX', N'Texas', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'UT', N'Utah', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'VA', N'Virginia', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'VI', N'Virgin Islands', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'VT', N'Vermont', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'WA', N'Washington', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'WI', N'Wisconsin', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'WV', N'West Virginia', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'WY', N'Wyoming', NULL)
INSERT INTO [lookup].[StateLookup] ([StateCode], [StateName], [Hardwired]) VALUES (N'YT', N'Yukon', NULL)
INSERT INTO [lookup].[TaskStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'A', N'Active', 1)
INSERT INTO [lookup].[TaskStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'W', N'Waiting For', 1)
INSERT INTO [lookup].[TaskStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'S', N'Someday', 1)
INSERT INTO [lookup].[TaskStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'C', N'Completed', 1)
INSERT INTO [lookup].[TaskStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (50, N'P', N'Pending Acceptance', 1)
INSERT INTO [lookup].[TaskStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (60, N'R', N'ReDelegated', 1)
INSERT INTO [lookup].[VolApplicationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'UK', N'(not specified)', NULL)
INSERT INTO [lookup].[VolApplicationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'Appr', N'Approved', 1)
INSERT INTO [lookup].[VolApplicationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (20, N'WD', N'Withdrawn', NULL)
INSERT INTO [lookup].[VolApplicationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'Not', N'Not Approved', 1)
INSERT INTO [lookup].[VolApplicationStatus] ([Id], [Code], [Description], [Hardwired]) VALUES (40, N'Pend', N'Pending', 1)
INSERT INTO [lookup].[VolunteerCodes] ([Id], [Code], [Description], [Hardwired]) VALUES (0, N'NA', N'None', NULL)
INSERT INTO [lookup].[VolunteerCodes] ([Id], [Code], [Description], [Hardwired]) VALUES (10, N'S', N'Standard', NULL)
INSERT INTO [lookup].[VolunteerCodes] ([Id], [Code], [Description], [Hardwired]) VALUES (30, N'L', N'Leader', NULL)
SET IDENTITY_INSERT [dbo].[Division] ON
INSERT INTO [dbo].[Division] ([Id], [Name], [ProgId], [SortOrder], [EmailMessage], [EmailSubject], [Instructions], [Terms], [ReportLine], [NoDisplayZero]) VALUES (1, N'First Division', 1, NULL, NULL, NULL, NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[Division] OFF
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (103, N'DR', N'Director', 10, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (130, N'CH', N'Chairman', 30, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (136, N'CC', N'Coach', 30, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (140, N'L', N'Leader', 10, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (160, N'T', N'Teacher', 10, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (161, N'AT', N'Assistant Teacher', 30, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (162, N'SC', N'Secretary', 30, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (170, N'IR', N'In Reach Leader', 10, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (172, N'OR', N'Outreach Leader', 10, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (220, N'M', N'Member', 30, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (230, N'IA', N'InActive', 40, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (300, N'VM', N'Visiting Member', 30, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (310, N'G', N'Guest', 60, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (311, N'PR', N'Prospect', 190, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (415, N'HB', N'Homebound', 100, NULL)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (500, N'IM', N'In-Service Member', 70, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (700, N'VI', N'VIP', 20, 1)
INSERT INTO [lookup].[MemberType] ([Id], [Code], [Description], [AttendanceTypeId], [Hardwired]) VALUES (710, N'VL', N'Volunteer', 20, NULL)
SET IDENTITY_INSERT [dbo].[Organizations] ON
INSERT INTO [dbo].[Organizations] ([OrganizationId], [CreatedBy], [CreatedDate], [OrganizationStatusId], [DivisionId], [LeaderMemberTypeId], [GradeAgeStart], [GradeAgeEnd], [RollSheetVisitorWks], [SecurityTypeId], [FirstMeetingDate], [LastMeetingDate], [OrganizationClosedDate], [Location], [OrganizationName], [ModifiedBy], [ModifiedDate], [EntryPointId], [ParentOrgId], [AllowAttendOverlap], [MemberCount], [LeaderId], [LeaderName], [ClassFilled], [OnLineCatalogSort], [PendingLoc], [CanSelfCheckin], [NumCheckInLabels], [CampusId], [AllowNonCampusCheckIn], [NumWorkerCheckInLabels], [ShowOnlyRegisteredAtCheckIn], [Limit], [GenderId], [Description], [BirthDayStart], [BirthDayEnd], [LastDayBeforeExtra], [RegistrationTypeId], [ValidateOrgs], [PhoneNumber], [RegistrationClosed], [AllowKioskRegister], [WorshipGroupCodes], [IsBibleFellowshipOrg], [NoSecurityLabel], [AlwaysSecurityLabel], [DaysToIgnoreHistory], [NotifyIds], [lat], [long], [RegSetting], [OrgPickList], [Offsite], [RegStart], [RegEnd], [LimitToRole], [OrganizationTypeId], [MemberJoinScript], [AddToSmallGroupScript], [RemoveFromSmallGroupScript], [SuspendCheckin], [NoAutoAbsents], [PublishDirectory], [ConsecutiveAbsentsThreshold], [IsRecreationTeam], [NotWeekly]) VALUES (1, 1, '2009-05-05 22:46:43.983', 30, 1, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, N'', N'First Organization', NULL, NULL, 0, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, 1, 0, NULL, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, N'Confirmation: 
	Subject: 


#ValidateOrgs:

#Shell:
#GroupToJoin:


Instructions: 
', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL)
EXEC(N'INSERT INTO [dbo].[Organizations] ([OrganizationId], [CreatedBy], [CreatedDate], [OrganizationStatusId], [DivisionId], [LeaderMemberTypeId], [GradeAgeStart], [GradeAgeEnd], [RollSheetVisitorWks], [SecurityTypeId], [FirstMeetingDate], [LastMeetingDate], [OrganizationClosedDate], [Location], [OrganizationName], [ModifiedBy], [ModifiedDate], [EntryPointId], [ParentOrgId], [AllowAttendOverlap], [MemberCount], [LeaderId], [LeaderName], [ClassFilled], [OnLineCatalogSort], [PendingLoc], [CanSelfCheckin], [NumCheckInLabels], [CampusId], [AllowNonCampusCheckIn], [NumWorkerCheckInLabels], [ShowOnlyRegisteredAtCheckIn], [Limit], [GenderId], [Description], [BirthDayStart], [BirthDayEnd], [LastDayBeforeExtra], [RegistrationTypeId], [ValidateOrgs], [PhoneNumber], [RegistrationClosed], [AllowKioskRegister], [WorshipGroupCodes], [IsBibleFellowshipOrg], [NoSecurityLabel], [AlwaysSecurityLabel], [DaysToIgnoreHistory], [NotifyIds], [lat], [long], [RegSetting], [OrgPickList], [Offsite], [RegStart], [RegEnd], [LimitToRole], [OrganizationTypeId], [MemberJoinScript], [AddToSmallGroupScript], [RemoveFromSmallGroupScript], [SuspendCheckin], [NoAutoAbsents], [PublishDirectory], [ConsecutiveAbsentsThreshold], [IsRecreationTeam], [NotWeekly]) VALUES (33, 1, ''2012-07-27 10:56:55.640'', 30, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, N''Manage Recurring Giving'', NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 14, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, N''Confirmation: 
	Subject: Online Recurring Giving Setup
	Body: <div style="margin: 10px; max-width: 600px"><table cellpadding="0" cellspacing="5" style="line-height: 15px; width: 100%; font-family: Arial; font-size: 13px"><tbody><tr><td><h1 style="color: #444; font-size: 24px; font-weight: bold">{church}</h1></td><td align="right"><p>Online Recurring Giving Setup<br />{date}</p></td></tr></tbody></table><p style="font-family: arial; color: #555555; font-size: 16pt; font-weight: bold">Online Recurring Giving Setup</p><table cellpadding="10" style="border-bottom-color: #ddd; border-right-width: 1px; background-color: #e6efc2; border-top-color: #ddd; border-top-width: 1px; border-bottom-width: 1px; border-right-color: #ddd; border-left-color: #ddd; border-left-width: 1px" width="100%"><tbody><tr><td style="font-family: arial; color: #222; font-size: 10pt; font-weight: bold">This is your confirmation for managing&nbsp;your recurring giving. Please keep this e-mail for your records.</td></tr></tbody></table><div><p style="font-style: italic; font-family: arial; font-size: 9pt"><br /><span style="color: rgb(102, 102, 102); font-size: 13pt; font-weight: bold; ">Summary</span></p><blockquote><p style="font-style: italic; font-family: arial; font-size: 9pt">{details}</p></blockquote><div style="border-bottom: #cccccc 1px solid; border-left: #cccccc 1px solid; color: #333333; border-top: #cccccc 1px solid; border-right: #cccccc 1px solid"><table style="margin: 5px; border-collapse: collapse; font-family: arial; font-size: 9pt" width="100%"><tbody><tr><td><b>Account</b></td><td><b>Contact Information</b></td></tr><tr><td>{name}<br />{email}<br />{phone}</td><td>{contact}<br />{contactphone}<br /><a href="mailto:{contactemail}">Email contact</a></td></tr></tbody></table></div></div></div>
Reminder: 
	ReminderSubject: 


Instructions: 
	Login: <p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">Enter your&nbsp;<strong>BVCMS Username</strong>&nbsp;(or your email address) and your&nbsp;<strong>Password</strong>.</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">If you have forgotten your password click the&nbsp;<strong>Forgot Password?</strong>&nbsp;link below.</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">If you have any problems or questions, please call the church to speak to someone in our Finance Office.</p>
	Find: <p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; line-height: normal;">Please enter the information in the required fields* below and press&nbsp;<strong>Find Profile</strong>&nbsp;in order to find your record in the Bellevue database. Once you complete this process, a&nbsp;<strong>one-use link</strong><strong>will be sent to the email address on your record</strong>. Use that link to finish setting up your recurring giving.</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; line-height: normal;">If you have a BVCMS Username and Password, you can&nbsp;<strong>Login with an Account</strong>.</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; line-height: normal;">If you have any problems or questions, please call the church and ask to speak to someone in our Finance Office.</p>
	Special: <p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">Enter the dollar amounts beside each fund to which you want to contribute. Then select the frequency of your contributions and the date on which you want the donations to begin (it must be after today&#39;s date).</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">Enter your bank routing number and your check'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL)')
UPDATE [dbo].[Organizations] SET [RegSetting].WRITE(N'ing account number and press Submit to complete the process.</p>
AllowOnlyOne: True
',NULL,NULL) WHERE [OrganizationId]=33
EXEC(N'INSERT INTO [dbo].[Organizations] ([OrganizationId], [CreatedBy], [CreatedDate], [OrganizationStatusId], [DivisionId], [LeaderMemberTypeId], [GradeAgeStart], [GradeAgeEnd], [RollSheetVisitorWks], [SecurityTypeId], [FirstMeetingDate], [LastMeetingDate], [OrganizationClosedDate], [Location], [OrganizationName], [ModifiedBy], [ModifiedDate], [EntryPointId], [ParentOrgId], [AllowAttendOverlap], [MemberCount], [LeaderId], [LeaderName], [ClassFilled], [OnLineCatalogSort], [PendingLoc], [CanSelfCheckin], [NumCheckInLabels], [CampusId], [AllowNonCampusCheckIn], [NumWorkerCheckInLabels], [ShowOnlyRegisteredAtCheckIn], [Limit], [GenderId], [Description], [BirthDayStart], [BirthDayEnd], [LastDayBeforeExtra], [RegistrationTypeId], [ValidateOrgs], [PhoneNumber], [RegistrationClosed], [AllowKioskRegister], [WorshipGroupCodes], [IsBibleFellowshipOrg], [NoSecurityLabel], [AlwaysSecurityLabel], [DaysToIgnoreHistory], [NotifyIds], [lat], [long], [RegSetting], [OrgPickList], [Offsite], [RegStart], [RegEnd], [LimitToRole], [OrganizationTypeId], [MemberJoinScript], [AddToSmallGroupScript], [RemoveFromSmallGroupScript], [SuspendCheckin], [NoAutoAbsents], [PublishDirectory], [ConsecutiveAbsentsThreshold], [IsRecreationTeam], [NotWeekly]) VALUES (34, 1, ''2012-07-27 11:15:41.310'', 30, 1, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, N''Online Giving'', NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, NULL, NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, N''Confirmation: 
	Subject: Online Giving Receipt
	Body: <p><title></title></p><p>{name}</p><p>You could put your thank you message here.</p><div style="margin: 10px; max-width: 600px"><table cellpadding="0" cellspacing="5" style="line-height: 15px; width: 100%; font-family: Arial; font-size: 13px"><tbody><tr><td><h1 style="color: #444; font-size: 24px; font-weight: bold">{church}</h1></td><td align="right"><p>Online Giving Receipt<br />{date}</p></td></tr></tbody></table><p style="font-family: arial; color: #555555; font-size: 16pt; font-weight: bold">Online Giving</p><table cellpadding="10" style="border-bottom-color: #ddd; border-right-width: 1px; background-color: #e6efc2; border-top-color: #ddd; border-top-width: 1px; border-bottom-width: 1px; border-right-color: #ddd; border-left-color: #ddd; border-left-width: 1px" width="100%"><tbody><tr><td style="font-family: arial; color: #222; font-size: 10pt; font-weight: bold">This is your confirmation. Please keep this e-mail for your records.</td></tr></tbody></table><div><p style="padding-top: 15px"><font style="font-family: arial; color: #666; font-size: 13pt; font-weight: bold">Confirmation #: {tranid}</font></p><p style="font-family: arial; color: #666; font-size: 13pt; font-weight: bold">Amount of Gift: ${amt}</p><p style="font-style: italic; font-family: arial; font-size: 9pt">The charge will appear on your statement as &quot;{church}&quot;.</p><blockquote><table style="border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; border-collapse: collapse; font-family: arial; color: #333333; font-size: 9pt; border-top: #ccc 1px solid; border-right: #ccc 1px solid"><thead><tr><td style="padding-bottom: 5px; background-color: #eee; padding-left: 10px; padding-right: 10px; color: #222; padding-top: 5px"><b>Items</b></td><td align="right" style="padding-bottom: 5px; background-color: #eee; padding-left: 10px; padding-right: 10px; color: #222; padding-top: 5px"><b>Amount</b></td></tr></thead><tfoot><tr><td align="right" style="padding-bottom: 5px; padding-left: 10px; padding-right: 10px; vertical-align: top; border-top: #bbb 1px solid; font-weight: bold; padding-top: 5px">Total</td><td align="right" style="padding-bottom: 5px; padding-left: 10px; padding-right: 10px; vertical-align: top; border-top: #bbb 1px solid; font-weight: bold; padding-top: 5px">${amt}</td></tr></tfoot><tbody><!--ITEM ROW START--><tr><td style="padding-bottom: 5px; padding-left: 10px; padding-right: 10px; padding-top: 5px">{funditem}</td><td align="right" style="padding-bottom: 5px; padding-left: 10px; padding-right: 10px; padding-top: 5px">${itemamt}</td></tr><!--ITEM ROW END--></tbody></table></blockquote><p style="font-family: arial; color: #666; font-size: 13pt; font-weight: bold">Billing Summary</p><div style="border-bottom: #cccccc 1px solid; border-left: #cccccc 1px solid; color: #333333; border-top: #cccccc 1px solid; border-right: #cccccc 1px solid"><table style="margin: 5px; border-collapse: collapse; font-family: arial; font-size: 9pt" width="100%"><tbody><tr><td><b>Account</b></td><td><b>Contact Information</b></td></tr><tr><td>{name}<br />{account}<br />{email}<br />{phone}</td><td>{contact}<br />{contactphone}<br /><a href="mailto:{contactemail}">Email contact</a></td></tr></tbody></table></div></div></div>
Reminder: 
	ReminderSubject: 


Instructions: 
	Login: <p style="color: rgb(51, 51, 51); font-family: sans-serif, Arial, Verdana, ''''Trebuchet MS''''; font-size: 13px; line-height: 20.796875px;">Enter your&nbsp;<b>BVCMS Username</b>&nbsp;(or your email address) and your&nbsp;<b>Password</b>.</p><p class="p1" style="color: rgb(51, 51, 51); font-family: sans-serif, Arial, Verdana, ''''Trebuchet MS''''; font-size: 13px; line-height: 20.796875px;">If you have forgotten your password click the&nbsp;<b>Forgot Password?</b>&nbsp;link below.</p><p class="p1" style="color: rgb(51, 51, 51); font-family: sans-serif, Arial, Verdana, ''''Trebuchet MS''''; font-size: 13px; line-height: 20.796875px;">If you have any prob'', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL)')
UPDATE [dbo].[Organizations] SET [RegSetting].WRITE(N'lems or questions, please call the church to speak to someone in our Finance Office.</p>
	Find: <p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; line-height: normal;">Please click&nbsp;<strong>Login with an Account&nbsp;</strong>below&nbsp;if you have a username and password on BVCMS.</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; line-height: normal;">If you have any problems or questions, please call the church and ask to speak with someone in our Finance Office.</p>
	Options: <p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">Enter the dollar amounts beside each fund to which you want to contribute, and press&nbsp;<strong>Submit</strong>. If you do not have a user account, you can choose to create one by checking the box below.</p><p style="color: rgb(34, 34, 34); font-family: Verdana, Arial, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">On the next page, enter your bank routing number and your checking account number and press&nbsp;<strong>Make Payment</strong>&nbsp;to complete the process. You can check Save Payment Information&nbsp;<em>if&nbsp;</em>?you&nbsp;are logged in.</p>
AllowOnlyOne: True
',NULL,NULL) WHERE [OrganizationId]=34
SET IDENTITY_INSERT [dbo].[Organizations] OFF
INSERT INTO [dbo].[ProgDiv] ([ProgId], [DivId]) VALUES (1, 1)
INSERT INTO [dbo].[DivOrg] ([DivId], [OrgId], [id]) VALUES (1, 1, 1)
INSERT INTO [dbo].[DivOrg] ([DivId], [OrgId], [id]) VALUES (1, 33, NULL)
INSERT INTO [dbo].[DivOrg] ([DivId], [OrgId], [id]) VALUES (1, 34, NULL)
INSERT INTO [dbo].[OrgSchedule] ([OrganizationId], [Id], [ScheduleId], [SchedTime], [SchedDay], [MeetingTime], [AttendCreditId]) VALUES (1, 1, 10930, '2012-01-20 09:30:00.000', 0, '1900-01-07 09:30:00.000', 1)
SET IDENTITY_INSERT [dbo].[Families] ON
INSERT INTO [dbo].[Families] ([FamilyId], [CreatedBy], [CreatedDate], [RecordStatus], [BadAddressFlag], [AltBadAddressFlag], [ResCodeId], [AltResCodeId], [AddressFromDate], [AddressToDate], [AddressLineOne], [AddressLineTwo], [CityName], [StateCode], [ZipCode], [CountryName], [StreetName], [HomePhone], [ModifiedBy], [ModifiedDate], [HeadOfHouseholdId], [HeadOfHouseholdSpouseId], [CoupleFlag], [HomePhoneLU], [HomePhoneAC], [Comments], [PictureId]) VALUES (1, 1, '2009-05-05 22:46:43.970', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, 1, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[Families] ([FamilyId], [CreatedBy], [CreatedDate], [RecordStatus], [BadAddressFlag], [AltBadAddressFlag], [ResCodeId], [AltResCodeId], [AddressFromDate], [AddressToDate], [AddressLineOne], [AddressLineTwo], [CityName], [StateCode], [ZipCode], [CountryName], [StreetName], [HomePhone], [ModifiedBy], [ModifiedDate], [HeadOfHouseholdId], [HeadOfHouseholdSpouseId], [CoupleFlag], [HomePhoneLU], [HomePhoneAC], [Comments], [PictureId]) VALUES (2, 0, NULL, 0, NULL, NULL, 30, NULL, NULL, NULL, N'235 Riveredge Cv.', NULL, N'Cordova', N'TN', N'38018', NULL, NULL, N'9017580791', NULL, NULL, 2, NULL, 0, '7580791', '901', NULL, NULL)
INSERT INTO [dbo].[Families] ([FamilyId], [CreatedBy], [CreatedDate], [RecordStatus], [BadAddressFlag], [AltBadAddressFlag], [ResCodeId], [AltResCodeId], [AddressFromDate], [AddressToDate], [AddressLineOne], [AddressLineTwo], [CityName], [StateCode], [ZipCode], [CountryName], [StreetName], [HomePhone], [ModifiedBy], [ModifiedDate], [HeadOfHouseholdId], [HeadOfHouseholdSpouseId], [CoupleFlag], [HomePhoneLU], [HomePhoneAC], [Comments], [PictureId]) VALUES (3, 0, NULL, 0, 0, NULL, 30, NULL, NULL, NULL, N'2000 Appling Rd', NULL, N'Cordova', N'TN', N'38016-4910', NULL, NULL, N'', NULL, NULL, 3, NULL, 0, '       ', '000', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Families] OFF
SET IDENTITY_INSERT [dbo].[People] ON
INSERT INTO [dbo].[People] ([PeopleId], [CreatedBy], [CreatedDate], [DropCodeId], [GenderId], [DoNotMailFlag], [DoNotCallFlag], [DoNotVisitFlag], [AddressTypeId], [PhonePrefId], [MaritalStatusId], [PositionInFamilyId], [MemberStatusId], [FamilyId], [BirthMonth], [BirthDay], [BirthYear], [OriginId], [EntryPointId], [InterestPointId], [BaptismTypeId], [BaptismStatusId], [DecisionTypeId], [NewMemberClassStatusId], [LetterStatusId], [JoinCodeId], [EnvelopeOptionsId], [BadAddressFlag], [ResCodeId], [AddressFromDate], [AddressToDate], [WeddingDate], [OriginDate], [BaptismSchedDate], [BaptismDate], [DecisionDate], [LetterDateRequested], [LetterDateReceived], [JoinDate], [DropDate], [DeceasedDate], [TitleCode], [FirstName], [MiddleName], [MaidenName], [LastName], [SuffixCode], [NickName], [AddressLineOne], [AddressLineTwo], [CityName], [StateCode], [ZipCode], [CountryName], [StreetName], [CellPhone], [WorkPhone], [EmailAddress], [OtherPreviousChurch], [OtherNewChurch], [SchoolOther], [EmployerOther], [OccupationOther], [HobbyOther], [SkillOther], [InterestOther], [LetterStatusNotes], [Comments], [ChristAsSavior], [MemberAnyChurch], [InterestedInJoining], [PleaseVisit], [InfoBecomeAChristian], [ContributionsStatement], [ModifiedBy], [ModifiedDate], [PictureId], [ContributionOptionsId], [PrimaryCity], [PrimaryZip], [PrimaryAddress], [PrimaryState], [HomePhone], [SpouseId], [PrimaryAddress2], [PrimaryResCode], [PrimaryBadAddrFlag], [LastContact], [Grade], [CellPhoneLU], [WorkPhoneLU], [BibleFellowshipClassId], [CampusId], [CellPhoneAC], [CheckInNotes], [AltName], [CustodyIssue], [OkTransport], [HasDuplicates], [FirstName2], [EmailAddress2], [SendEmailAddress1], [SendEmailAddress2], [NewMemberClassDate], [PrimaryCountry], [ReceiveSMS], [DoNotPublishPhones], [SSN], [DLN], [DLStateID]) VALUES (1, 1, '2009-05-05 22:46:43.970', 0, 0, 0, 0, 0, 10, 0, 0, 10, 20, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'The', NULL, NULL, N'Admin', NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, N'info@bvcms.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, NULL, NULL, NULL, 40, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'The', NULL, 1, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[People] ([PeopleId], [CreatedBy], [CreatedDate], [DropCodeId], [GenderId], [DoNotMailFlag], [DoNotCallFlag], [DoNotVisitFlag], [AddressTypeId], [PhonePrefId], [MaritalStatusId], [PositionInFamilyId], [MemberStatusId], [FamilyId], [BirthMonth], [BirthDay], [BirthYear], [OriginId], [EntryPointId], [InterestPointId], [BaptismTypeId], [BaptismStatusId], [DecisionTypeId], [NewMemberClassStatusId], [LetterStatusId], [JoinCodeId], [EnvelopeOptionsId], [BadAddressFlag], [ResCodeId], [AddressFromDate], [AddressToDate], [WeddingDate], [OriginDate], [BaptismSchedDate], [BaptismDate], [DecisionDate], [LetterDateRequested], [LetterDateReceived], [JoinDate], [DropDate], [DeceasedDate], [TitleCode], [FirstName], [MiddleName], [MaidenName], [LastName], [SuffixCode], [NickName], [AddressLineOne], [AddressLineTwo], [CityName], [StateCode], [ZipCode], [CountryName], [StreetName], [CellPhone], [WorkPhone], [EmailAddress], [OtherPreviousChurch], [OtherNewChurch], [SchoolOther], [EmployerOther], [OccupationOther], [HobbyOther], [SkillOther], [InterestOther], [LetterStatusNotes], [Comments], [ChristAsSavior], [MemberAnyChurch], [InterestedInJoining], [PleaseVisit], [InfoBecomeAChristian], [ContributionsStatement], [ModifiedBy], [ModifiedDate], [PictureId], [ContributionOptionsId], [PrimaryCity], [PrimaryZip], [PrimaryAddress], [PrimaryState], [HomePhone], [SpouseId], [PrimaryAddress2], [PrimaryResCode], [PrimaryBadAddrFlag], [LastContact], [Grade], [CellPhoneLU], [WorkPhoneLU], [BibleFellowshipClassId], [CampusId], [CellPhoneAC], [CheckInNotes], [AltName], [CustodyIssue], [OkTransport], [HasDuplicates], [FirstName2], [EmailAddress2], [SendEmailAddress1], [SendEmailAddress2], [NewMemberClassDate], [PrimaryCountry], [ReceiveSMS], [DoNotPublishPhones], [SSN], [DLN], [DLStateID]) VALUES (2, 0, '2010-10-30 15:23:10.743', 0, 1, 0, 0, 0, 10, 0, 20, 10, 20, 2, 5, 30, 1952, 70, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Mr.', N'David', NULL, NULL, N'Carroll', NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'9014890611', NULL, N'david@bvcms.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, N'Cordova', N'38018', N'235 Riveredge Cv.', N'TN', N'9017580791', NULL, NULL, 30, 0, NULL, NULL, '4890611', NULL, NULL, NULL, '901', NULL, NULL, NULL, NULL, NULL, N'David', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[People] ([PeopleId], [CreatedBy], [CreatedDate], [DropCodeId], [GenderId], [DoNotMailFlag], [DoNotCallFlag], [DoNotVisitFlag], [AddressTypeId], [PhonePrefId], [MaritalStatusId], [PositionInFamilyId], [MemberStatusId], [FamilyId], [BirthMonth], [BirthDay], [BirthYear], [OriginId], [EntryPointId], [InterestPointId], [BaptismTypeId], [BaptismStatusId], [DecisionTypeId], [NewMemberClassStatusId], [LetterStatusId], [JoinCodeId], [EnvelopeOptionsId], [BadAddressFlag], [ResCodeId], [AddressFromDate], [AddressToDate], [WeddingDate], [OriginDate], [BaptismSchedDate], [BaptismDate], [DecisionDate], [LetterDateRequested], [LetterDateReceived], [JoinDate], [DropDate], [DeceasedDate], [TitleCode], [FirstName], [MiddleName], [MaidenName], [LastName], [SuffixCode], [NickName], [AddressLineOne], [AddressLineTwo], [CityName], [StateCode], [ZipCode], [CountryName], [StreetName], [CellPhone], [WorkPhone], [EmailAddress], [OtherPreviousChurch], [OtherNewChurch], [SchoolOther], [EmployerOther], [OccupationOther], [HobbyOther], [SkillOther], [InterestOther], [LetterStatusNotes], [Comments], [ChristAsSavior], [MemberAnyChurch], [InterestedInJoining], [PleaseVisit], [InfoBecomeAChristian], [ContributionsStatement], [ModifiedBy], [ModifiedDate], [PictureId], [ContributionOptionsId], [PrimaryCity], [PrimaryZip], [PrimaryAddress], [PrimaryState], [HomePhone], [SpouseId], [PrimaryAddress2], [PrimaryResCode], [PrimaryBadAddrFlag], [LastContact], [Grade], [CellPhoneLU], [WorkPhoneLU], [BibleFellowshipClassId], [CampusId], [CellPhoneAC], [CheckInNotes], [AltName], [CustodyIssue], [OkTransport], [HasDuplicates], [FirstName2], [EmailAddress2], [SendEmailAddress1], [SendEmailAddress2], [NewMemberClassDate], [PrimaryCountry], [ReceiveSMS], [DoNotPublishPhones], [SSN], [DLN], [DLStateID]) VALUES (3, 0, '2010-10-30 15:23:12.310', 0, 2, 0, 0, 0, 10, 0, 20, 10, 20, 3, NULL, NULL, NULL, 70, 10, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Ms.', N'Karen', NULL, NULL, N'Worrell', NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, NULL, N'', N'', N'karen@bvcms.com', NULL, NULL, NULL, N'Bellevue Baptist Church', N'Systems Administrator', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, 1, NULL, N'Cordova', N'38016-4910', N'2000 Appling Rd', N'TN', N'', NULL, NULL, 30, 0, NULL, NULL, '       ', NULL, NULL, NULL, '000', NULL, NULL, NULL, NULL, NULL, N'Karen', NULL, 1, 0, NULL, NULL, 0, 0, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[People] OFF
SET IDENTITY_INSERT [dbo].[RecReg] ON
INSERT INTO [dbo].[RecReg] ([Id], [PeopleId], [ImgId], [IsDocument], [ActiveInAnotherChurch], [ShirtSize], [MedAllergy], [email], [MedicalDescription], [fname], [mname], [coaching], [member], [emcontact], [emphone], [doctor], [docphone], [insurance], [policy], [Comments], [Tylenol], [Advil], [Maalox], [Robitussin]) VALUES (2, 3, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[RecReg] OFF
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 1)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 2)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 3)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 4)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 5)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 6)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 8)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (1, 9)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 1)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 2)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 3)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 4)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 5)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 6)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 8)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 9)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 11)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 12)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (2, 25)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 1)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 2)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 3)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 4)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 5)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 6)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 8)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 9)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 11)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 12)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 15)
INSERT INTO [dbo].[UserRole] ([UserId], [RoleId]) VALUES (3, 25)
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT INTO [dbo].[Users] ([UserId], [PeopleId], [Username], [Comment], [Password], [PasswordQuestion], [PasswordAnswer], [IsApproved], [LastActivityDate], [LastLoginDate], [LastPasswordChangedDate], [CreationDate], [IsLockedOut], [LastLockedOutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [ItemsInGrid], [CurrentCart], [MustChangePassword], [Host], [TempPassword], [Name], [Name2], [ResetPasswordCode], [DefaultGroup], [ResetPasswordExpires]) VALUES (1, 1, N'Admin', NULL, N'2352354235', NULL, NULL, 1, '2014-01-24 10:37:44.450', NULL, '2014-01-24 10:37:12.077', '2009-05-05 22:46:43.890', 0, '2014-01-24 10:37:11.997', 0, '2014-01-24 10:35:54.547', 0, NULL, NULL, NULL, 0, N'starterdb.bvcms.com', N'bvcms', N'The Admin', N'Admin, The', NULL, NULL, '2014-01-25 10:36:44.310')
INSERT INTO [dbo].[Users] ([UserId], [PeopleId], [Username], [Comment], [Password], [PasswordQuestion], [PasswordAnswer], [IsApproved], [LastActivityDate], [LastLoginDate], [LastPasswordChangedDate], [CreationDate], [IsLockedOut], [LastLockedOutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [ItemsInGrid], [CurrentCart], [MustChangePassword], [Host], [TempPassword], [Name], [Name2], [ResetPasswordCode], [DefaultGroup], [ResetPasswordExpires]) VALUES (2, 2, N'david', N'', N'uNVML/ZamnY7YdE1NXvMHPIznic=', NULL, NULL, 1, '2014-01-24 10:37:24.863', '2014-01-24 10:36:52.857', '2013-12-19 00:03:08.440', '2010-10-30 15:23:25.763', 0, '2013-12-19 00:03:08.360', 0, '2013-12-18 22:54:19.783', 0, '2010-10-30 15:23:25.763', NULL, NULL, 0, N'starterdb.bvcms.com', N'bvcms', N'David Carroll', N'Carroll, David', NULL, NULL, '2013-12-19 22:55:00.120')
INSERT INTO [dbo].[Users] ([UserId], [PeopleId], [Username], [Comment], [Password], [PasswordQuestion], [PasswordAnswer], [IsApproved], [LastActivityDate], [LastLoginDate], [LastPasswordChangedDate], [CreationDate], [IsLockedOut], [LastLockedOutDate], [FailedPasswordAttemptCount], [FailedPasswordAttemptWindowStart], [FailedPasswordAnswerAttemptCount], [FailedPasswordAnswerAttemptWindowStart], [ItemsInGrid], [CurrentCart], [MustChangePassword], [Host], [TempPassword], [Name], [Name2], [ResetPasswordCode], [DefaultGroup], [ResetPasswordExpires]) VALUES (3, 3, N'karenw', N'', N'lpSVokbyDdVaXxNGDjZT4St468A=', NULL, NULL, 1, '2014-01-24 10:38:04.737', '2014-01-24 10:36:50.687', '2013-10-14 10:43:23.743', '2010-10-30 15:29:25.757', 0, '2013-10-14 10:43:23.667', 0, '2013-10-14 10:41:24.547', 0, '2010-10-30 15:29:25.757', NULL, NULL, 0, N'starterdb.bvcms.com', N'bvcms', N'Karen Worrell', N'Worrell, Karen', NULL, NULL, '2013-10-15 10:42:47.710')
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_Users_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId])
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [FK_UserRole_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
ALTER TABLE [dbo].[RecReg] ADD CONSTRAINT [FK_RecReg_People] FOREIGN KEY ([PeopleId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_BaptismStatus] FOREIGN KEY ([BaptismStatusId]) REFERENCES [lookup].[BaptismStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_BaptismType] FOREIGN KEY ([BaptismTypeId]) REFERENCES [lookup].[BaptismType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [BFMembers__BFClass] FOREIGN KEY ([BibleFellowshipClassId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Campus] FOREIGN KEY ([CampusId]) REFERENCES [lookup].[Campus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [StmtPeople__ContributionStatementOption] FOREIGN KEY ([ContributionOptionsId]) REFERENCES [lookup].[EnvelopeOption] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_DecisionType] FOREIGN KEY ([DecisionTypeId]) REFERENCES [lookup].[DecisionType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_DropType] FOREIGN KEY ([DropCodeId]) REFERENCES [lookup].[DropType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_EntryPoint] FOREIGN KEY ([EntryPointId]) REFERENCES [lookup].[EntryPoint] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [EnvPeople__EnvelopeOption] FOREIGN KEY ([EnvelopeOptionsId]) REFERENCES [lookup].[EnvelopeOption] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Families] FOREIGN KEY ([FamilyId]) REFERENCES [dbo].[Families] ([FamilyId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Gender] FOREIGN KEY ([GenderId]) REFERENCES [lookup].[Gender] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_InterestPoint] FOREIGN KEY ([InterestPointId]) REFERENCES [lookup].[InterestPoint] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_JoinType] FOREIGN KEY ([JoinCodeId]) REFERENCES [lookup].[JoinType] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_MemberLetterStatus] FOREIGN KEY ([LetterStatusId]) REFERENCES [lookup].[MemberLetterStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_MaritalStatus] FOREIGN KEY ([MaritalStatusId]) REFERENCES [lookup].[MaritalStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_MemberStatus] FOREIGN KEY ([MemberStatusId]) REFERENCES [lookup].[MemberStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_DiscoveryClassStatus] FOREIGN KEY ([NewMemberClassStatusId]) REFERENCES [lookup].[NewMemberClassStatus] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_Origin] FOREIGN KEY ([OriginId]) REFERENCES [lookup].[Origin] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_PEOPLE_TBL_Picture] FOREIGN KEY ([PictureId]) REFERENCES [dbo].[Picture] ([PictureId])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [FK_People_FamilyPosition] FOREIGN KEY ([PositionInFamilyId]) REFERENCES [lookup].[FamilyPosition] ([Id])
ALTER TABLE [dbo].[People] ADD CONSTRAINT [ResCodePeople__ResidentCode] FOREIGN KEY ([ResCodeId]) REFERENCES [lookup].[ResidentCode] ([Id])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FamiliesHeaded__HeadOfHousehold] FOREIGN KEY ([HeadOfHouseholdId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FamiliesHeaded2__HeadOfHouseholdSpouse] FOREIGN KEY ([HeadOfHouseholdSpouseId]) REFERENCES [dbo].[People] ([PeopleId])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [FK_Families_Picture] FOREIGN KEY ([PictureId]) REFERENCES [dbo].[Picture] ([PictureId])
ALTER TABLE [dbo].[Families] ADD CONSTRAINT [ResCodeFamilies__ResidentCode] FOREIGN KEY ([ResCodeId]) REFERENCES [lookup].[ResidentCode] ([Id])
ALTER TABLE [dbo].[OrgSchedule] ADD CONSTRAINT [FK_OrgSchedule_Organizations] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[DivOrg] ADD CONSTRAINT [FK_DivOrg_Division] FOREIGN KEY ([DivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[DivOrg] ADD CONSTRAINT [FK_DivOrg_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[ProgDiv] ADD CONSTRAINT [FK_ProgDiv_Division] FOREIGN KEY ([DivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[ProgDiv] ADD CONSTRAINT [FK_ProgDiv_Program] FOREIGN KEY ([ProgId]) REFERENCES [dbo].[Program] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_Campus] FOREIGN KEY ([CampusId]) REFERENCES [lookup].[Campus] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_Division] FOREIGN KEY ([DivisionId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_ORGANIZATIONS_TBL_EntryPoint] FOREIGN KEY ([EntryPointId]) REFERENCES [lookup].[EntryPoint] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_Gender] FOREIGN KEY ([GenderId]) REFERENCES [lookup].[Gender] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_ORGANIZATIONS_TBL_OrganizationStatus] FOREIGN KEY ([OrganizationStatusId]) REFERENCES [lookup].[OrganizationStatus] ([Id])
ALTER TABLE [dbo].[Organizations] ADD CONSTRAINT [FK_Organizations_OrganizationType] FOREIGN KEY ([OrganizationTypeId]) REFERENCES [lookup].[OrganizationType] ([Id])
ALTER TABLE [dbo].[Organizations] WITH NOCHECK ADD CONSTRAINT [ChildOrgs__ParentOrg] FOREIGN KEY ([ParentOrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[ActivityLog] WITH NOCHECK ADD CONSTRAINT [FK_ActivityLog_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[Attend] WITH NOCHECK ADD CONSTRAINT [FK_AttendWithAbsents_TBL_ORGANIZATIONS_TBL] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[Coupons] WITH NOCHECK ADD CONSTRAINT [FK_Coupons_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[EnrollmentTransaction] WITH NOCHECK ADD CONSTRAINT [ENROLLMENT_TRANSACTION_ORG_FK] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[Meetings] WITH NOCHECK ADD CONSTRAINT [FK_MEETINGS_TBL_ORGANIZATIONS_TBL] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[MemberTags] WITH NOCHECK ADD CONSTRAINT [FK_MemberTags_Organizations] FOREIGN KEY ([OrgId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[OrganizationExtra] WITH NOCHECK ADD CONSTRAINT [FK_OrganizationExtra_Organizations] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [dbo].[OrganizationMembers] WITH NOCHECK ADD CONSTRAINT [ORGANIZATION_MEMBERS_ORG_FK] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([OrganizationId])
ALTER TABLE [lookup].[MemberType] ADD CONSTRAINT [FK_MemberType_AttendType] FOREIGN KEY ([AttendanceTypeId]) REFERENCES [lookup].[AttendType] ([Id])
ALTER TABLE [dbo].[Attend] WITH NOCHECK ADD CONSTRAINT [FK_Attend_MemberType] FOREIGN KEY ([MemberTypeId]) REFERENCES [lookup].[MemberType] ([Id])
ALTER TABLE [dbo].[EnrollmentTransaction] WITH NOCHECK ADD CONSTRAINT [FK_ENROLLMENT_TRANSACTION_TBL_MemberType] FOREIGN KEY ([MemberTypeId]) REFERENCES [lookup].[MemberType] ([Id])
ALTER TABLE [dbo].[OrganizationMembers] WITH NOCHECK ADD CONSTRAINT [FK_ORGANIZATION_MEMBERS_TBL_MemberType] FOREIGN KEY ([MemberTypeId]) REFERENCES [lookup].[MemberType] ([Id])
ALTER TABLE [dbo].[Division] ADD CONSTRAINT [FK_Division_Program] FOREIGN KEY ([ProgId]) REFERENCES [dbo].[Program] ([Id])
ALTER TABLE [dbo].[Coupons] WITH NOCHECK ADD CONSTRAINT [FK_Coupons_Division] FOREIGN KEY ([DivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[Promotion] WITH NOCHECK ADD CONSTRAINT [FromPromotions__FromDivision] FOREIGN KEY ([FromDivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[Promotion] WITH NOCHECK ADD CONSTRAINT [ToPromotions__ToDivision] FOREIGN KEY ([ToDivId]) REFERENCES [dbo].[Division] ([Id])
ALTER TABLE [dbo].[VoluteerApprovalIds] WITH NOCHECK ADD CONSTRAINT [FK_VoluteerApprovalIds_VolunteerCodes] FOREIGN KEY ([ApprovalId]) REFERENCES [lookup].[VolunteerCodes] ([Id])
ALTER TABLE [dbo].[Volunteer] WITH NOCHECK ADD CONSTRAINT [FK_Volunteer_VolApplicationStatus] FOREIGN KEY ([StatusId]) REFERENCES [lookup].[VolApplicationStatus] ([Id])
ALTER TABLE [dbo].[Task] WITH NOCHECK ADD CONSTRAINT [FK_Task_TaskStatus] FOREIGN KEY ([StatusId]) REFERENCES [lookup].[TaskStatus] ([Id])
ALTER TABLE [dbo].[Zips] WITH NOCHECK ADD CONSTRAINT [FK_Zips_ResidentCode] FOREIGN KEY ([MetroMarginalCode]) REFERENCES [lookup].[ResidentCode] ([Id])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK ADD CONSTRAINT [FK_Contribution_ContributionType] FOREIGN KEY ([ContributionTypeId]) REFERENCES [lookup].[ContributionType] ([Id])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK ADD CONSTRAINT [FK_Contribution_ContributionStatus] FOREIGN KEY ([ContributionStatusId]) REFERENCES [lookup].[ContributionStatus] ([Id])
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_Contacts_ContactTypes] FOREIGN KEY ([ContactTypeId]) REFERENCES [lookup].[ContactType] ([Id])
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_NewContacts_ContactReasons] FOREIGN KEY ([ContactReasonId]) REFERENCES [lookup].[ContactReason] ([Id])
ALTER TABLE [dbo].[BundleHeader] WITH NOCHECK ADD CONSTRAINT [FK_BUNDLE_HEADER_TBL_BundleStatusTypes] FOREIGN KEY ([BundleStatusId]) REFERENCES [lookup].[BundleStatusTypes] ([Id])
ALTER TABLE [dbo].[BundleHeader] WITH NOCHECK ADD CONSTRAINT [FK_BUNDLE_HEADER_TBL_BundleHeaderTypes] FOREIGN KEY ([BundleHeaderTypeId]) REFERENCES [lookup].[BundleHeaderTypes] ([Id])
ALTER TABLE [dbo].[Attend] WITH NOCHECK ADD CONSTRAINT [FK_AttendWithAbsents_TBL_AttendType] FOREIGN KEY ([AttendanceTypeId]) REFERENCES [lookup].[AttendType] ([Id])
ALTER TABLE [dbo].[Meetings] WITH NOCHECK ADD CONSTRAINT [FK_Meetings_AttendCredit] FOREIGN KEY ([AttendCreditId]) REFERENCES [lookup].[AttendCredit] ([Id])
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_Contacts_Ministries] FOREIGN KEY ([MinistryId]) REFERENCES [dbo].[Ministries] ([MinistryId])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK ADD CONSTRAINT [FK_Contribution_ExtraData] FOREIGN KEY ([ExtraDataId]) REFERENCES [dbo].[ExtraData] ([Id])
ALTER TABLE [dbo].[BundleHeader] WITH NOCHECK ADD CONSTRAINT [BundleHeaders__Fund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[ContributionFund] ([FundId])
ALTER TABLE [dbo].[Contribution] WITH NOCHECK ADD CONSTRAINT [FK_Contribution_ContributionFund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[ContributionFund] ([FundId])
ALTER TABLE [dbo].[RecurringAmounts] WITH NOCHECK ADD CONSTRAINT [FK_RecurringAmounts_ContributionFund] FOREIGN KEY ([FundId]) REFERENCES [dbo].[ContributionFund] ([FundId])
ALTER TABLE [dbo].[ContentKeyWords] WITH NOCHECK ADD CONSTRAINT [FK_ContentKeyWords_Content] FOREIGN KEY ([Id]) REFERENCES [dbo].[Content] ([Id])
COMMIT TRANSACTION
GO
