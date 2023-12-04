function SendTgm(){
	MSG="${HOSTNAME^^}\n${1:-"Texto Vazio"}";
	TGM_URI='https://api.telegram.org/bot676689288:AAGItCflxsTv3098I7nLCwyGlWETe5J-boE/sendMessage';
	TGM_CHAT_ID='201591376';
	(curl --silent --fail --insecure --location --compressed \
	--retry-connrefused --retry 5 --retry-delay 3 --max-time 30 --request POST "${TGM_URI}" \
	--header 'Pragma: no-cache' --header 'Cache-Control: no-cache' --header 'Content-Type: application/json' \
	--data-raw '{"chat_id":"'"${TGM_CHAT_ID}"'", "text":"'"${MSG}"'", "parse_mode":"html"}') >/dev/null 2>&1;
}

function GetData(){
	(mysql -sfrBnw --reconnect --skip-column-names -uroot -p${PWD_DB} -h51.81.34.90 -P3606 -Ddb_wsapp -e'SELECT * FROM `GetCurls`;' 2>/dev/null) > '/tmp/curls.tmp';
}

function SetData(){
	echo -e "$(date)\t${1}";
	mysql -fnw --reconnect -uroot -p${PWD_DB} -h51.81.34.90 -P3606 -Ddb_wsapp -e"${1}" 2>/dev/null >/dev/null 2>&1;
}

function SetDataLote(){
	cat '/tmp/update.sql';
	cat '/tmp/update.sql' | mysql -fnw --reconnect -uroot -p${PWD_DB} -h51.81.34.90 -P3606 -Ddb_wsapp >/dev/null 2>&1;
	true > '/tmp/update.sql';
}

function GetTokenAlexa(){
	export TOKEN='5976a44feeadcab6d3956fe6a690d6ecf6520916';
}

function GetAccessToken(){
	export TOKEN=$(curl8 --silent --fail --location --insecure \
	--retry 5 --retry-delay 3 --retry-all-errors --retry-connrefused --max-time 30 \
	--request POST 'https://api.mkst.app/getAccessToken' \
	--header 'Content-Type: application/json' \
	--header 'Authorization: Bearer '$(echo -n $(date +'@%d@%m@%y@') | sha256sum | awk '{print $1}') \
	--data-raw '{"login":"thiago@realizati.com.br","pwd":"thiago@realizati.com.br"}' | jq -r .jdata.token);
}

function BkpGetAccessToken(){
	(find '/tmp/' -iname 'mkst.token' -cmin +1 -type f -delete) >/dev/null 2>&1;
	if [ -s '/tmp/mkst.token' ]; then
		export TOKEN=$(cat '/tmp/mkst.token')
	else
		export TOKEN=$(curl8 --silent --fail --location --insecure \
		--retry 5 --retry-delay 3 --retry-all-errors --retry-connrefused --max-time 30 \
		--request POST 'https://api.mkst.app/getAccessToken' \
		--header 'Content-Type: application/json' \
		--header 'Authorization: Bearer '$(echo -n $(date +'@%d@%m@%y@') | sha256sum | awk '{print $1}') \
		--data-raw '{"login":"thiago@realizati.com.br","pwd":"thiago@realizati.com.br"}' | jq -r .jdata.token);
		echo "${TOKEN}" > '/tmp/mkst.token';
	fi
}





curl8 --silent --location --fail --insecure --output '/dev/null' --write-out '%{http_code} %{time_total} %{errormsg}' --retry 5 --retry-delay 3 --retry-all-errors --retry-connrefused --max-time 30 --request GET 'https://api.mkst.app/getPlanos' --header 'Pragma: no-cache' --header 'Cache-Control: no-cache' --header 'Content-Type: application/json'


select `curls`.`vhash` AS `vhash`,ifnull(`curls`.`token`,'_') AS `token`,replace(to_base64(`curls`.`cmd`),'\n','') AS `cmd` from `curls` where (`curls`.`ativo` = 'S')


BEGIN
	SET @vhash:=TRIM(SUBSTRING_INDEX(`data`, '|', 1));
	SET @now_status_code:=TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(`data`, '|', 2), '|', -1));
	SET @now_tps:=TRIM(SUBSTRING_INDEX(`data`, '|', -1));

	START TRANSACTION;
	ALTER TABLE `curls` AUTO_INCREMENT=0;
	UPDATE `curls`
	SET `curls`.`now_status_code`=@now_status_code, `curls`.`now_tps`=@now_tps
	WHERE `curls`.`vhash`=@vhash LIMIT 1;
	COMMIT;
END
