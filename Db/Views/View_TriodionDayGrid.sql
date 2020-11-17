CREATE VIEW View_TriodionDayGrid AS
SELECT dr.Id, 
		`dr`.`DaysFromEaster` AS `DaysFromEaster`,
		dw.WorshipName AS "Name",
        dw.WorshipShortName AS "ShortName",
        dw.IsCelebrating
FROM typicondb.Day AS dr 
INNER JOIN typicondb.DayWorship AS dw ON dw.ParentId = dr.Id
WHERE dr.Discriminator = "TriodionDay"
