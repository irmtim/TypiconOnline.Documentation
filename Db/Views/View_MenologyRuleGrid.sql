CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `view_menologyrulegrid` AS
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
        (((((`dayrule` `dr`
        JOIN `dayruleworship` `drw` ON ((`dr`.`Id` = `drw`.`DayRuleId`)))
        JOIN `dayworship` `dw` ON ((`dw`.`Id` = `drw`.`DayWorshipId`)))
        JOIN `dayworshipnameitems` `dni` ON ((`dw`.`Id` = `dni`.`NameId`)))
        JOIN `sign` `s` ON ((`dr`.`TemplateId` = `s`.`Id`)))
        JOIN `signnameitems` `sni` ON ((`s`.`Id` = `sni`.`NameId`)))
    WHERE
        ((`dr`.`Discriminator` = 'MenologyRule')
            AND (`dni`.`Language` = 'cs-ru')
            AND (`sni`.`Language` = 'cs-ru'))
    GROUP BY `dr`.`Id`