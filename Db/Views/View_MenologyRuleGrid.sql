CREATE VIEW `view_menologyrulegrid` AS
    SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`TypiconVersionId` AS `TypiconVersionId`,
        GROUP_CONCAT(`dw`.`WorshipName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `s`.`SignName` AS `TemplateName`,
        `dr`.`IsAddition` AS `IsAddition`,
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
		END) AS `HasModRuleDefinition`,
        (CASE
			WHEN
				`dr`.`RuleDefinition` != '' 
			THEN 1 
            ELSE 0 
		END) AS `HasRuleDefinition`
    FROM
        (((`dayrule` `dr`
        JOIN `dayruleworship` `drw` ON ((`dr`.`Id` = `drw`.`DayRuleId`)))
        JOIN `dayworship` `dw` ON ((`dw`.`Id` = `drw`.`DayWorshipId`)))
        JOIN `sign` `s` ON ((`dr`.`TemplateId` = `s`.`Id`)))
    WHERE
        (`dr`.`Discriminator` = 'MenologyRule')
    GROUP BY `dr`.`Id`