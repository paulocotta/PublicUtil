CREATE TABLE `curls` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`vhash` CHAR(40) NOT NULL COMMENT 'hash do cmd' COLLATE 'utf8mb4_0900_ai_ci',
	`descricao` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`cmd` TEXT NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`token` VARCHAR(10) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`status_code` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '200' COMMENT 'status_code esperado',
	`tps` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '10' COMMENT 'tps esperado',
	`now_status_code` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '200' COMMENT 'status_code corrente',
	`now_tps` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '10' COMMENT 'tps corrente',
	`status` ENUM('1','2','3') NOT NULL DEFAULT '1' COMMENT '1: Up\n2: Tps Baixa\n3: Down' COLLATE 'utf8mb4_0900_ai_ci',
	`ativo` ENUM('S','N') NOT NULL DEFAULT 'N' COLLATE 'utf8mb4_0900_ai_ci',
	`modificado` TIMESTAMP NOT NULL DEFAULT 'CURRENT_TIMESTAMP' ON UPDATE CURRENT_TIMESTAMP,
	`criado` TIMESTAMP NOT NULL DEFAULT 'CURRENT_TIMESTAMP',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `vhash` (`vhash`) USING BTREE
)
COMMENT='Tabela: Controle dos comandos Curls'
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
AUTO_INCREMENT=12
;



ALTER ALGORITHM = UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `GetCurls` AS select trim(concat(`curls`.`vhash`,' ',ifnull(`curls`.`token`,'_'),' ',replace(to_base64(`curls`.`cmd`),'\n',''),' ',lpad(if((`curls`.`now_status_code` <> `curls`.`status_code`),`curls`.`now_status_code`,`curls`.`status_code`),3,'0'),' ',if((`curls`.`now_tps` > `curls`.`tps`),-(1),`curls`.`tps`),' ')) AS `data` from `curls` where ((`curls`.`ativo` = 'S') and ('comment' <> 'Se now_status_code <> status_code, considera now_status_code para evitar atualização no banco (write), se não status_code') and ('comment' <> 'Se now_tps > tps, considera -1 para forçar a atualização, se não tps')) order by rand() ;
ALTER ALGORITHM = UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `GetCurlsJson` AS select json_arrayagg(json_object('id',`curls`.`id`,'vhash',`curls`.`vhash`,'descricao',`curls`.`descricao`,'now_status_code',`curls`.`now_status_code`,'now_tps',`curls`.`now_tps`,'status',`curls`.`status`)) AS `jdata` from `curls` where (`curls`.`ativo` = 'S') ;

CREATE DEFINER=`root`@`localhost` TRIGGER `curls_before_update` BEFORE UPDATE ON `curls` FOR EACH ROW BEGIN
	SET
		NEW.`cmd`             = NULLIF(TRIM(REGEXP_REPLACE(NEW.`cmd`,'[[:space:]][[:space:]]+|\\\\$|\n', '', 1, 0, 'imu')),''),
		NEW.`vhash`           = NULLIF(TRIM(SHA1(NEW.`cmd`)),''),
		NEW.`descricao`       = NULLIF(TRIM(NEW.`descricao`),''),
		NEW.`token`           = NULLIF(TRIM(NEW.`token`),''),
		NEW.`status_code`     = NULLIF(TRIM(NEW.`status_code`),''),
		NEW.`tps`             = NULLIF(TRIM(NEW.`tps`),''),
		NEW.`now_status_code` = NULLIF(TRIM(NEW.`now_status_code`),''),
		NEW.`now_tps`         = NULLIF(TRIM(NEW.`now_tps`),''),
		NEW.`ativo`           = NULLIF(TRIM(UPPER(NEW.`ativo`)),'');

	#:Controla o status (farol)
	IF ( NEW.`status_code` != NEW.`now_status_code` ) THEN
		SET NEW.`status` = 3;
	ELSE
		IF ( NEW.`now_tps` > NEW.`tps` ) THEN
			SET NEW.`status` = 2;
		ELSE
			SET NEW.`status` = 1;
		END IF;
	END IF;
END
