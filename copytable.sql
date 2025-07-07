BEGIN
	/*
	* Utilizado por: Procedure: RunReindexMKST, RunFaturamento
	* Executa uma copia das tabelas: contratos, faturas
	*/
	DECLARE `_done` TINYINT(1) DEFAULT FALSE;
	DECLARE `_cmd`  TINYTEXT DEFAULT NULL;
	DECLARE `_name` VARCHAR(50) DEFAULT TRIM(REPLACE(REGEXP_REPLACE(NOW(),'[:\-]',''),' ','_'));
	DECLARE `_cur` CURSOR FOR(VALUES
		ROW('DROP TABLE IF EXISTS `db_tmp`.`contratos_#name`;'),
		ROW('DROP TABLE IF EXISTS `db_tmp`.`faturas_#name`;'),
		ROW('DROP TABLE IF EXISTS `db_tmp`.`service_mautic_#name`;'),
		ROW('CREATE TABLE `db_tmp`.`contratos_#name` ENGINE=INNODB (SELECT * FROM `db_mkst`.`contratos`);'),
		ROW('CREATE TABLE `db_tmp`.`faturas_#name` ENGINE=INNODB (SELECT * FROM `db_mkst`.`faturas`);'),
		ROW('CREATE TABLE `db_tmp`.`service_mautic_#name` ENGINE=INNODB (SELECT * FROM `db_mkst`.`service_mautic`);')
	);
	DECLARE CONTINUE HANDLER FOR NOT FOUND BEGIN SET `_done`:=TRUE; END;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
	OPEN `_cur`;
	LOOP1:LOOP
		FETCH `_cur` INTO `_cmd`;
		IF (`_done`) THEN LEAVE LOOP1; END IF;
		SET @sqlexe:=TRIM(REPLACE(`_cmd`, '#name', `_name`));
		#SELECT @sqlexe;
		PREPARE stmt FROM @sqlexe;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
		COMMIT;
	END LOOP LOOP1;
	CLOSE `_cur`;
END
