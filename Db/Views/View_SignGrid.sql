CREATE VIEW `view_signgrid` AS
    SELECT 
        `s`.`Id` AS `Id`,
        `s`.`TypiconVersionId` AS `TypiconVersionId`,
        `s`.`SignName` AS `Name`,
        `parent`.`SignName` AS `TemplateName`,
        `s`.`IsAddition` AS `IsAddition`,
        `print`.`Number` AS `Number`,
        `s`.`Priority` AS `Priority`,
        `s`.`HasRuleGlobally` AS `HasRuleGlobally`
    FROM
        ((`sign` `s`
        LEFT JOIN `sign` `parent` ON ((`parent`.`Id` = `s`.`TemplateId`)))
        LEFT JOIN `printdaytemplate` `print` ON ((`s`.`PrintTemplateId` = `print`.`Id`)))
