Create View View_TriodionRuleGrid as 
SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`TypiconVersionId` AS `TypiconVersionId`,
        GROUP_CONCAT(`dw`.`WorshipName`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `s`.`SignName` AS `TemplateName`,
        `dr`.`IsAddition` AS `IsAddition`,
        `dr`.`DaysFromEaster`,
        `dr`.`IsTransparent`,
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
        (`dr`.`Discriminator` = 'TriodionRule')
    GROUP BY `dr`.`Id`