CREATE VIEW View_TriodionDayGrid AS
SELECT dr.Id, 
		`dr`.`DaysFromEaster` AS `DaysFromEaster`,
		dni.Text AS "Name",
        dsni.Text AS "ShortName",
        dw.IsCelebrating
FROM typicondb.Day AS dr 
INNER JOIN typicondb.DayWorship AS dw ON dw.ParentId = dr.Id
INNER JOIN typicondb.DayWorshipNameItems AS dni ON dw.Id = dni.NameId 
left JOIN typicondb.DayWorshipShortNameItems AS dsni ON dw.Id = dsni.NameId
WHERE dr.Discriminator = "TriodionDay"
	AND dni.Language = "cs-ru"