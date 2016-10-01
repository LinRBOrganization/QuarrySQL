
if not exists(select 1 from SysViewType where SysViewType='100')
begin
	insert dbo.SysViewType( SysViewType, SysViewName ) values('100','DBUser') 
end
go
if not exists(select 1 from SysViewType where SysViewType='101')
begin
	insert dbo.SysViewType( SysViewType, SysViewName) values('101','DbSystemConst') 
end
go
if not exists(select 1 from SysViewType where SysViewType='102')
begin
	insert dbo.SysViewType( SysViewType, SysViewName) values('102','Db_v_UserPermission') 
end
go
if not exists(select 1 from SysViewType where SysViewType='103')
begin
	insert dbo.SysViewType( SysViewType, SysViewName) values('103','DbPermission') 
end
go
if not exists(select 1 from SysViewType where SysViewType='104')
begin
	insert dbo.SysViewType( SysViewType, SysViewName) values('104','DbPermissionData') 
end
go
if not exists(select 1 from SysViewType where SysViewType='105')
begin
	insert dbo.SysViewType( SysViewType, SysViewName) values('105','DbReportTemplate') 
end