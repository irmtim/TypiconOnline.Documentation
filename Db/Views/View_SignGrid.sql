CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `typicondb`.`view_signgrid` AS
    SELECT 
        `s`.`Id` AS `Id`,
        `s`.`TypiconVersionId` AS `TypiconVersionId`,
        `sign_name`.`Text` AS `Name`,
        `parent_name`.`Text` AS `TemplateName`,
        `s`.`IsAddition` AS `IsAddition`,
        `print`.`Number` AS `Number`,
        `s`.`Priority` AS `Priority`
    FROM
        ((((`typicondb`.`sign` `s`
        JOIN `typicondb`.`signnameitems` `sign_name` ON ((`s`.`Id` = `sign_name`.`NameId`)))
        LEFT JOIN `typicondb`.`sign` `parent` ON ((`parent`.`Id` = `s`.`TemplateId`)))
        LEFT JOIN `typicondb`.`signnameitems` `parent_name` ON ((`parent`.`Id` = `parent_name`.`NameId`)))
        LEFT JOIN `typicondb`.`printdaytemplate` `print` ON ((`s`.`PrintTemplateId` = `print`.`Id`)))
    WHERE
        ((`sign_name`.`Language` = 'cs-ru')
            AND (ISNULL(`parent_name`.`Language`)
            OR (`parent_name`.`Language` = 'cs-ru')))