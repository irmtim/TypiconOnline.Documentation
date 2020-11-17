
Create View View_TriodionDayGrid as 
SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`CalendarId` AS `CalendarId`,
        GROUP_CONCAT(`dw`.`WorshipName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
		GROUP_CONCAT(`dw`.`DefaultName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `DefaultName`,
        `s`.`Name` AS `TemplateName`,
        `dr`.`DaysFromEaster`,
        `dr`.`IsTransparent`,
        (CASE
			WHEN
				`dr`.`ModRuleDefinition` != '' 
			THEN 1 
            ELSE 0 
		END) AS `HasModRuleDefinition`
    FROM
        (((`triodionday` `dr`
        JOIN `triodiondayworship` `drw` ON ((`dr`.`Id` = `drw`.`DayId`)))
        JOIN `triodionworship` `dw` ON ((`dw`.`Id` = `drw`.`WorshipId`)))
        JOIN `sign` `s` ON ((`dr`.`TemplateId` = `s`.`Id`)))
    GROUP BY `dr`.`Id`;
    
CREATE VIEW `view_menologydaygrid` AS
    SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`CalendarId` AS `CalendarId`,
        GROUP_CONCAT(`dw`.`WorshipName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `s`.`Name` AS `TemplateName`,
        (CASE
            WHEN
                ((`dr`.`Date_Month` = 0)
                    AND (`dr`.`Date_Day` = 0))
            THEN
                ''
            ELSE CONCAT(LPAD(`dr`.`Date_Month`, 2, 0),
                    '-',
                    LPAD(`dr`.`Date_Day`, 2, 0))
        END) AS `Date`,
        (CASE
            WHEN
                ((`dr`.`LeapDate_Month` = 0)
                    AND (`dr`.`LeapDate_Day` = 0))
            THEN
                ''
            ELSE CONCAT(LPAD(`dr`.`LeapDate_Month`, 2, 0),
                    '-',
                    LPAD(`dr`.`LeapDate_Day`, 2, 0))
        END) AS `LeapDate`,
        (CASE
			WHEN
				`dr`.`ModRuleDefinition` != '' 
			THEN 1 
            ELSE 0 
		END) AS `HasModRuleDefinition`
    FROM
        (((`menologyday` `dr`
        JOIN `menologydayworship` `drw` ON ((`dr`.`Id` = `drw`.`DayId`)))
        JOIN `menologyworship` `dw` ON ((`dw`.`Id` = `drw`.`WorshipId`)))
        JOIN `sign` `s` ON ((`dr`.`TemplateId` = `s`.`Id`)))
    GROUP BY `dr`.`Id`;
    
CREATE VIEW `view_triodionrulegrid` AS
	SELECT 
        `dr`.`Id` AS `Id`,
        GROUP_CONCAT(`dw`.`WorshipName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `s`.`Name` AS `TemplateName`,
        `md`.`DaysFromEaster`,
        `md`.`IsTransparent`,
        (CASE
			WHEN
				`dr`.`RuleDefinition` != '' 
			THEN 1 
            ELSE 0 
		END) AS `HasRule`
    FROM
        ((((`triodionrule` `dr`
        JOIN `triodionday` `md` ON (`dr`.`DayId` = `md`.`Id`))
        JOIN `triodiondayworship` `drw` ON (`dr`.`Id` = `drw`.`DayId`))
        JOIN `triodionworship` `dw` ON (`dw`.`Id` = `drw`.`WorshipId`))
        JOIN `sign` `s` ON (`md`.`TemplateId` = `s`.`Id`))
	GROUP BY `dr`.`Id`;
    
CREATE VIEW `view_menologyrulegrid` AS
    SELECT 
        `dr`.`Id` AS `Id`,
        GROUP_CONCAT(`dw`.`WorshipName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `s`.`Name` AS `TemplateName`,
        (CASE
            WHEN
                ((`md`.`Date_Month` = 0)
                    AND (`md`.`Date_Day` = 0))
            THEN
                ''
            ELSE CONCAT(LPAD(`md`.`Date_Month`, 2, 0),
                    '-',
                    LPAD(`md`.`Date_Day`, 2, 0))
        END) AS `Date`,
        (CASE
            WHEN
                ((`md`.`LeapDate_Month` = 0)
                    AND (`md`.`LeapDate_Day` = 0))
            THEN
                ''
            ELSE CONCAT(LPAD(`md`.`LeapDate_Month`, 2, 0),
                    '-',
                    LPAD(`md`.`LeapDate_Day`, 2, 0))
        END) AS `LeapDate`,
        (CASE
			WHEN
				`dr`.`RuleDefinition` != '' 
			THEN 1 
            ELSE 0 
		END) AS `HasRule`
    FROM
        ((((`menologyrule` `dr`
        JOIN `menologyday` `md` ON (`dr`.`DayId` = `md`.`Id`))
        JOIN `menologydayworship` `drw` ON (`dr`.`Id` = `drw`.`DayId`))
        JOIN `menologyworship` `dw` ON (`dw`.`Id` = `drw`.`WorshipId`))
        JOIN `sign` `s` ON (`md`.`TemplateId` = `s`.`Id`))
    GROUP BY `dr`.`Id`;
    
CREATE VIEW `view_menologyworshipgrid` AS
    SELECT 
        *,
        (CASE
            WHEN
                ((`Date_Month` = 0)
                    AND (`Date_Day` = 0))
            THEN
                ''
            ELSE CONCAT(LPAD(`Date_Month`, 2, 0),
                    '-',
                    LPAD(`Date_Day`, 2, 0))
        END) AS `Date`,
        (CASE
            WHEN
                ((`Date_Month` = 0)
                    AND (`Date_Day` = 0))
            THEN
                ''
            ELSE CONCAT(LPAD(`LeapDate_Month`, 2, 0),
                    '-',
                    LPAD(`LeapDate_Day`, 2, 0))
        END) AS `LeapDate`
    FROM menologyworship;