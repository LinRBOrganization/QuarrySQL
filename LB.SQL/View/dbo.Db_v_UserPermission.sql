CREATE view dbo.Db_v_UserPermission
as
select d.UserPermissionID, d.UserID, d.PermissionDataID, d.ChangeBy, d.ChangeTime,
	p.PermissionID, p.PermissionCode, p.PermissionDataName,d.HasPermission,s.PermissionName
from dbo.DbPermissionData p
	inner join dbo.DbPermission s on
		s.PermissionID = p.PermissionID
	left outer join dbo.DbUserPermission d on
		p.PermissionDataID = d.PermissionDataID
