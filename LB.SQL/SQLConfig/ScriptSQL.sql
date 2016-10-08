USE [master]
GO

/****** Object:  Database [lb_project]    Script Date: 09/12/2016 22:56:32 ******/
IF not EXISTS (SELECT name FROM sys.databases WHERE name = N'lb_project')
begin
/****** Object:  Database [lb_project]    Script Date: 09/12/2016 22:56:32 ******/
CREATE DATABASE [lb_project] ON  PRIMARY 
( NAME = N'lb_project', FILENAME = N'H:\Program Files\Tools\SQL SERVER 2008\MSSQL10_50.SQL2008\MSSQL\DATA\lb_project.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'lb_project_log', FILENAME = N'H:\Program Files\Tools\SQL SERVER 2008\MSSQL10_50.SQL2008\MSSQL\DATA\lb_project_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
end

go

USE [lb_project]

go

IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbPermission]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[DbPermission](
		[PermissionID] [bigint] IDENTITY(1,1) NOT NULL,
		[PermissionName] [varchar](100) NOT NULL,
		[ParentPermissionID] [bigint] NULL,
	 CONSTRAINT [PK_DbPermission] PRIMARY KEY CLUSTERED 
	(
		[PermissionID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
end

go
IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbPermissionData]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[DbPermissionData](
	[PermissionDataID] [bigint] IDENTITY(1,1) NOT NULL,
	[PermissionID] [bigint] NOT NULL,
	[PermissionCode] [varchar](100) NOT NULL,
	[PermissionDataName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DbPermissionData] PRIMARY KEY CLUSTERED 
(
	[PermissionDataID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

end

go


if not exists( select 1 from dbo.syscolumns c inner join dbo.sysobjects o on c.id = o.id 
	where o.id = object_id( 'dbo.DbPermissionData' ) and c.name = 'PermissionType' )		
begin
	alter table dbo.DbPermissionData
		add PermissionType tinyint	not null
end

go


if not exists( select 1 from dbo.syscolumns c inner join dbo.sysobjects o on c.id = o.id 
	where o.id = object_id( 'dbo.DbPermissionData' ) and c.name = 'PermissionSPType' )		
begin
	alter table dbo.DbPermissionData
		add PermissionSPType int	null
end

go

if not exists( select 1 from dbo.syscolumns c inner join dbo.sysobjects o on c.id = o.id 
	where o.id = object_id( 'dbo.DbPermissionData' ) and c.name = 'PermissionViewType' )		
begin
	alter table dbo.DbPermissionData
		add PermissionViewType int	null
end

go

if not exists( select 1 from dbo.syscolumns c inner join dbo.sysobjects o on c.id = o.id 
	where o.id = object_id( 'dbo.DbPermissionData' ) and c.name = 'LogFieldName' )		
begin
	alter table dbo.DbPermissionData
		add LogFieldName varchar(50)	null
end
go

IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbSystemConst]') AND type in (N'U'))
begin
CREATE TABLE [dbo].[DbSystemConst](
	[SystemConstID] [bigint] IDENTITY(1,1) NOT NULL,
	[FieldName] [varchar](100) NOT NULL,
	[ConstValue] [tinyint] NOT NULL,
	[ConstText] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DbSystemConst] PRIMARY KEY CLUSTERED 
(
	[SystemConstID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

end

go
IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DBUser]') AND type in (N'U'))
begin
CREATE TABLE [dbo].[DBUser](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[LoginName] [varchar](100) NOT NULL,
	[UserPassword] [varchar](1000) NOT NULL,
	[ForbidLogin] [tinyint] NOT NULL,
	[IsManager] [tinyint] NOT NULL,
	[ChangeBy] [varchar](100) NOT NULL,
	[ChangeTime] [smalldatetime] NOT NULL,
	[UserType] [tinyint] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[UserSex] [tinyint] NOT NULL,
 CONSTRAINT [PK_DBUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
end
go

IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbUserPermission]') AND type in (N'U'))
begin
CREATE TABLE [dbo].[DbUserPermission](
	[UserPermissionID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[PermissionDataID] [bigint] NOT NULL,
	[ChangeBy] [varchar](100) NOT NULL,
	[ChangeTime] [varchar](100) NOT NULL,
	[HasPermission] [tinyint] NOT NULL,
 CONSTRAINT [PK_DbUserPermission] PRIMARY KEY CLUSTERED 
(
	[UserPermissionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

end

go

IF not EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DbUserPermission_DbPermissionData]') AND parent_object_id = OBJECT_ID(N'[dbo].[DbUserPermission]'))
begin
	ALTER TABLE [dbo].[DbUserPermission]  WITH CHECK ADD  CONSTRAINT [FK_DbUserPermission_DbPermissionData] FOREIGN KEY([PermissionDataID])
	REFERENCES [dbo].[DbPermissionData] ([PermissionDataID])

	ALTER TABLE [dbo].[DbUserPermission] CHECK CONSTRAINT [FK_DbUserPermission_DbPermissionData]
end

go

IF not EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DbUserPermission_DBUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[DbUserPermission]'))
begin
	ALTER TABLE [dbo].[DbUserPermission]  WITH CHECK ADD  CONSTRAINT [FK_DbUserPermission_DBUser] FOREIGN KEY([UserID])
	REFERENCES [dbo].[DBUser] ([UserID])

	ALTER TABLE [dbo].[DbUserPermission] CHECK CONSTRAINT [FK_DbUserPermission_DBUser]
end

go

IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SysSPType]') AND type in (N'U'))
begin
CREATE TABLE [dbo].[SysSPType](
	[SysSPTypeID] [bigint] IDENTITY(1,1) NOT NULL,
	[SysSPType] [int] NOT NULL,
	[SysSPName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SysSPType] PRIMARY KEY CLUSTERED 
(
	[SysSPTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

end

go

IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SysViewType]') AND type in (N'U'))
begin
CREATE TABLE [dbo].[SysViewType](
	[SysViewTypeID] [bigint] IDENTITY(1,1) NOT NULL,
	[SysViewType] [varchar](50) NOT NULL,
	[SysViewName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SysViewType] PRIMARY KEY CLUSTERED 
(
	[SysViewTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
end
go
IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbReportType]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[DbReportType](
		[ReportTypeID] [bigint] IDENTITY(1,1) NOT NULL,
		[ReportTypeName] [varchar](100) NOT NULL,
	 CONSTRAINT [PK_DbReportType] PRIMARY KEY CLUSTERED 
	(
		[ReportTypeID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
end

go

IF not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbReportTemplate]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[DbReportTemplate](
	[ReportTemplateID] [bigint] IDENTITY(1,1) NOT NULL,
	[ReportTemplateName] [varchar](100) NOT NULL,
	[TemplateFileTime] [smalldatetime] NOT NULL,
	[TemplateSeq] [int] NOT NULL,
	[Description] [varchar](100) NOT NULL,
	[ReportTemplateNameExt] [varchar](100) NOT NULL,
	[TemplateData] [image] NOT NULL,
	[ReportTypeID] [bigint] NOT NULL,
	 CONSTRAINT [PK_DbReportTemplate] PRIMARY KEY CLUSTERED 
	(
		[ReportTemplateID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	ALTER TABLE [dbo].[DbReportTemplate]  WITH CHECK ADD  CONSTRAINT [FK_DbReportTemplate_DbReportType] FOREIGN KEY([ReportTypeID])
	REFERENCES [dbo].[DbReportType] ([ReportTypeID])

	ALTER TABLE [dbo].[DbReportTemplate] CHECK CONSTRAINT [FK_DbReportTemplate_DbReportType]
end
go
IF not  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DbPrinterConfig]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[DbPrinterConfig](
		[PrinterConfigID] [bigint] IDENTITY(1,1) NOT NULL,
		[ReportTemplateID] [bigint] NOT NULL,
		[PrinterName] [varchar](100) NULL,
		[MachineName] [varchar](100) NOT NULL,
		[IsManualPaperType] [tinyint] NOT NULL,
		[PaperType] [varchar](100) NULL,
		[IsManualPaperSize] [tinyint] NOT NULL,
		[PaperSizeHeight] [int] NULL,
		[PaperSizeWidth] [int] NULL,
		[IsPaperTransverse] [tinyint] NOT NULL,
	 CONSTRAINT [PK_BDPrinterConfig] PRIMARY KEY CLUSTERED 
	(
		[PrinterConfigID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
end

go
IF not  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SbSysLog]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[SbSysLog](
		[SysLogID] [bigint] IDENTITY(1,1) NOT NULL,
		[LoginName] [varchar](100) NOT NULL,
		[LogTime] [smalldatetime] NOT NULL,
		[LogMachineName] [varchar](100) NOT NULL,
		[LogMachineIP] [varchar](100) NOT NULL,
		[LogModule] [varchar](100) NOT NULL,
		[LogStatusName] [varchar](100) NOT NULL,
		[LogDescription] [varchar](100) NOT NULL,
	 CONSTRAINT [PK_SBSysLog] PRIMARY KEY CLUSTERED 
	(
		[SysLogID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
end


--添加默认管理员权限

if not exists(
select 1
from dbo.DBUser 
where LoginName='admin'
)
begin
	insert into dbo.DBUser ( LoginName, UserPassword, ForbidLogin, IsManager, ChangeBy, ChangeTime, UserType, UserName, UserSex)
	values('admin','sIJN5MJNrKo=',0,0,'admin',getdate(),2,'admin',0)
end

--添加报表模板配置
set IDENTITY_INSERT DbReportType on 
if not exists(
select 1
from dbo.DbReportType 
where ReportTypeID=1
)
begin
	insert dbo.DbReportType (ReportTypeID,ReportTypeName)
	values(1,'用户管理')
end

set IDENTITY_INSERT DbReportType off 



