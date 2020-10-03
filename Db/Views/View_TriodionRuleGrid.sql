Create View typicondb.View_TriodionRuleGrid as 
SELECT 
        `dr`.`Id` AS `Id`,
        `dr`.`TypiconVersionId` AS `TypiconVersionId`,
        GROUP_CONCAT(`dni`.`Text`
            ORDER BY `drw`.`Order` ASC
            SEPARATOR ' ') AS `Name`,
        `sni`.`Text` AS `TemplateName`,
        `dr`.`IsAddition` AS `IsAddition`,
        `dr`.`DaysFromEaster`,
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
        ((`dr`.`Discriminator` = 'TriodionRule')
            AND (`dni`.`Language` = 'cs-ru')
            AND (`sni`.`Language` = 'cs-ru'))
    GROUP BY `dr`.`Id`