CREATE VIEW View_MenologyDayGrid AS
SELECT dr.Id, 
		CASE 
			WHEN (dr.Date_Month = 0 AND dr.Date_Day = 0)
				THEN "" 
            ELSE CONCAT(LPAD(dr.Date_Month, 2, 0), 
				"-", 
				LPAD(dr.Date_Day, 2, 0) ) 
		END AS "Date",
		CASE 
			WHEN (dr.LeapDate_Month = 0 AND dr.LeapDate_Day = 0)
				THEN "" 
            ELSE CONCAT(LPAD(dr.LeapDate_Month, 2, 0), 
				"-", 
				LPAD(dr.LeapDate_Day, 2, 0) ) 
		END AS "LeapDate",
		dni.Text AS "Name",
        dsni.Text AS "ShortName",
        dw.IsCelebrating
FROM typicondb.Day AS dr 
INNER JOIN typicondb.DayWorship AS dw ON dw.ParentId = dr.Id
INNER JOIN typicondb.DayWorshipNameItems AS dni ON dw.Id = dni.NameId 
left JOIN typicondb.DayWorshipShortNameItems AS dsni ON dw.Id = dsni.NameId
WHERE dr.Discriminator = "MenologyDay"
	AND dni.Language = "cs-ru"