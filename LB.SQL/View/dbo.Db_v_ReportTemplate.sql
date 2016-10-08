CREATE view dbo.Db_v_ReportTemplate
as
select t.ReportTemplateID, t.ReportTemplateName, t.TemplateFileTime, t.TemplateSeq, t.Description, 
	t.ReportTemplateNameExt, t.TemplateData, t.ReportTypeID,
	c.PrinterConfigID, c.PrinterName, c.MachineName, c.IsManualPaperType, c.PaperType, 
	c.IsManualPaperSize, c.PaperSizeHeight, c.PaperSizeWidth, c.IsPaperTransverse
from dbo.DbReportTemplate t
	left outer join dbo.DbPrinterConfig c on
		c.ReportTemplateID = t.ReportTemplateID
