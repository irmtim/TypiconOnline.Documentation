Create view u0351320_typicondb.View_MenologyRuleGrid AS
SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`TypiconVersionId` AS `TypiconVersionId`,
        GROUP_CONCAT(`dni`.`Text`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `sni`.`Text` AS `TemplateName`,
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
        (`dr`.`ModRuleDefinition` = '') AS `HasModRuleDefinition`,
        (`dr`.`RuleDefinition` = '') AS `HasRuleDefinition`
    FROM
        (((((`u0351320_typicondb`.`dayrule` `dr`
        JOIN `u0351320_typicondb`.`dayruleworship` `drw` ON ((`dr`.`Id` = `drw`.`DayRuleId`)))
        JOIN `u0351320_typicondb`.`dayworship` `dw` ON ((`dw`.`Id` = `drw`.`DayWorshipId`)))
        JOIN `u0351320_typicondb`.`dayworshipnameitems` `dni` ON ((`dw`.`Id` = `dni`.`NameId`)))
        JOIN `u0351320_typicondb`.`sign` `s` ON ((`dr`.`TemplateId` = `s`.`Id`)))
        JOIN `u0351320_typicondb`.`signnameitems` `sni` ON ((`s`.`Id` = `sni`.`NameId`)))
    WHERE
        ((`dr`.`Discriminator` = 'MenologyRule')
            AND (`dni`.`Language` = 'cs-ru')
            AND (`sni`.`Language` = 'cs-ru'))
    GROUP BY `dr`.`Id`;

Create view u0351320_typicondb.View_triodionrulegrid AS
SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`TypiconVersionId` AS `TypiconVersionId`,
        GROUP_CONCAT(`dni`.`Text`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `sni`.`Text` AS `TemplateName`,
        `dr`.`IsAddition` AS `IsAddition`,
        `dr`.`DaysFromEaster` AS `DaysFromEaster`,
        `dr`.`IsTransparent` AS `IsTransparent`,
        (`dr`.`ModRuleDefinition` = '') AS `HasModRuleDefinition`,
        (`dr`.`RuleDefinition` = '') AS `HasRuleDefinition`
    FROM
        (((((`u0351320_typicondb`.`dayrule` `dr`
        JOIN `dayruleworship` `drw` ON ((`dr`.`Id` = `drw`.`DayRuleId`)))
        JOIN `dayworship` `dw` ON ((`dw`.`Id` = `drw`.`DayWorshipId`)))
        JOIN `dayworshipnameitems` `dni` ON ((`dw`.`Id` = `dni`.`NameId`)))
        JOIN `sign` `s` ON ((`dr`.`TemplateId` = `s`.`Id`)))
        JOIN `signnameitems` `sni` ON ((`s`.`Id` = `sni`.`NameId`)))
    WHERE
        ((`dr`.`Discriminator` = 'TriodionRule')
            AND (`dni`.`Language` = 'cs-ru')
            AND (`sni`.`Language` = 'cs-ru'))
    GROUP BY `dr`.`Id`;

CREATE VIEW `view_menologydaygrid` AS
SELECT 
        `dw`.`Id` AS `Id`,
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
        `dni`.`Text` AS `Name`,
        `dsni`.`Text` AS `ShortName`,
        `dw`.`IsCelebrating` AS `IsCelebrating`
    FROM
        (((`day` `dr`
        JOIN `dayworship` `dw` ON ((`dw`.`ParentId` = `dr`.`Id`)))
        JOIN `dayworshipnameitems` `dni` ON ((`dw`.`Id` = `dni`.`NameId`)))
        LEFT JOIN `dayworshipshortnameitems` `dsni` ON ((`dw`.`Id` = `dsni`.`NameId`)))
    WHERE
        ((`dr`.`Discriminator` = 'MenologyDay')
            AND (`dni`.`Language` = 'cs-ru'));

CREATE VIEW `view_triodiondaygrid` AS
    SELECT 
        `dw`.`Id` AS `Id`,
        `dr`.`DaysFromEaster` AS `DaysFromEaster`,
        `dni`.`Text` AS `Name`,
        `dsni`.`Text` AS `ShortName`,
        `dw`.`IsCelebrating` AS `IsCelebrating`
    FROM
        (((`day` `dr`
        JOIN `dayworship` `dw` ON ((`dw`.`ParentId` = `dr`.`Id`)))
        JOIN `dayworshipnameitems` `dni` ON ((`dw`.`Id` = `dni`.`NameId`)))
        LEFT JOIN `dayworshipshortnameitems` `dsni` ON ((`dw`.`Id` = `dsni`.`NameId`)))
    WHERE
        ((`dr`.`Discriminator` = 'TriodionDay')
            AND (`dni`.`Language` = 'cs-ru'));

CREATE VIEW `view_signgrid` AS   
SELECT s.Id,
		s.TypiconVersionId,
		sign_name.Text AS "Name",
        parent_name.Text AS "TemplateName",
        s.IsAddition,
        print.Number,
        s.Priority
FROM Sign AS s 
INNER JOIN SignNameItems AS sign_name ON s.Id = sign_name.NameId
LEFT JOIN Sign AS parent ON parent.Id = s.TemplateId
LEFT JOIN SignNameItems AS parent_name ON parent.Id = parent_name.NameId
LEFT JOIN PrintDayTemplate AS print ON s.PrintTemplateId = print.Id
WHERE sign_name.Language = "cs-ru"
    AND (parent_name.Language IS NULL OR parent_name.Language = "cs-ru")


