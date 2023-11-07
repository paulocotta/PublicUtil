#!/bin/bash
[ ${HOSTNAME,,} != 'srv-itcloud-01' ] && { exit 0; } || { clear; }
source '/mnt/Data/08_GitHub/servers/srv-itcloud-01/curl/util.sh';
true > '/tmp/curls.tmp';
IFS=$'\n';
for VAL in $(GetData); do
	VHASH=$(echo ${VAL} | awk '{print $1}' | xargs);
	[ $(ps aux | egrep -vi 'grep' | egrep -csi "${VHASH}") -gt 0 ] && { continue; }
	echo -e "${VAL}" >> '/tmp/curls.tmp';
	#for i in {1..100}; do { echo -e ${VAL} >> '/tmp/curls.tmp'; } done
done
cat '/tmp/curls.tmp' | shuf | xargs -n5 -P30 '/mnt/Data/08_GitHub/servers/srv-itcloud-01/curl/motor.sh';
wait; exit 0;
######################
#!/bin/bash
[ ${HOSTNAME,,} != 'srv-itcloud-01' ] && { exit 0; }
[ ${#} -ne 5 ] && { echo 'Parametro incorreto'; exit 9; }
source '/mnt/Data/08_GitHub/servers/srv-itcloud-01/curl/util.sh';

#:CHECK ENVS
VHASH=$(echo "${1}" | xargs);
TOKEN=$(echo "${2}" | xargs);
CMD_CURL=$(echo "${3}" | base64 -d);
STATUS_CODE=$(echo "${4}" | xargs);
TPS=$(echo "${5}" | xargs);
[ -z "${VHASH}" ] || [ -z "${TOKEN}" ] || [ -z "${CMD_CURL}" ] || [ -z "${STATUS_CODE}" ] || [ -z "${TPS}" ] && { echo 'Comando invalido ou vazio'; exit 9; }

#:TOKEN
if [ $(echo "${TOKEN}" | egrep -csvi '_') -gt 0 ]; then
	[ $(echo "${TOKEN}" | egrep -csi 'ALEXA') -gt 0 ] && { TOKEN=$(GetTokenAlexa); }
	[ $(echo "${TOKEN}" | egrep -csi 'MKST') -gt 0 ] && { TOKEN=$(GetMKST); }
	[ -z "${TOKEN}" ] || [ "${TOKEN}" == '_' ] && { exit 0; }
fi

#:RUN
START_TIME=$(date +%s);
for i in {1..5}; do
	NOW_STATUS_CODE=$(eval "(timeout 3m ${CMD_CURL});");
	[[ ${NOW_STATUS_CODE} =~ 000 ]] && { sleep 3; continue; }
	break;
done
END_TIME=$(date +%s);
NOW_TPS=$(echo "${END_TIME} - ${START_TIME}" | bc);

#:UPDATE
SetData "UPDATE \`curls\` SET \`curls\`.\`now_status_code\`='${NOW_STATUS_CODE}', \`curls\`.\`now_tps\`='${NOW_TPS}' WHERE \`curls\`.\`vhash\`='${VHASH}' LIMIT 1; COMMIT;";
wait; exit 0;
#############
function GetTokenAlexa(){
	echo '5976a44feeadcab6d3956fe6a690d6ecf6520916';
}

function GetData(){
	echo $(mysql -sfrBnw --reconnect --skip-column-names -uroot -p${PWD_DB} -h51.81.34.90 -P3606 -Ddb_wsapp -e'SELECT * FROM `GetCurls`;' 2>/dev/null);
}

function SetData(){
	echo ${1};
	(mysql -fnw --reconnect -uroot -p${PWD_DB} -h51.81.34.90 -P3606 -Ddb_wsapp -e"${1}" 2>/dev/null) >/dev/null 2>&1;
}

function GetMKST(){
	TMP=$(curl --silent --location --fail --insecure \
	--retry 5 --retry-delay 3 --retry-connrefused --max-time 10 \
	--request POST 'https://api.mkst.app/getAccessToken' \
	--header 'Content-Type: application/json' \
	--header 'Authorization: Bearer '$(echo -n $(date +'@%d@%m@%y@') | sha256sum | awk '{print $1}') \
	--data-raw '{"login":"thiago@realizati.com.br","pwd":"thiago@realizati.com.br"}' | jq -r .jdata.token);
	[ "${TMP}" == 'null' ] && { TMP='_'; }
	echo "${TMP}";
}
curl --silent --location --fail --insecure --output '/dev/null' --write-out '%{http_code}' --retry 5 --retry-delay 3 --retry-connrefused --max-time 10 --request POST 'https://api.mkst.app/getAccount' --header 'Connection: keep-alive' --header 'Pragma: no-cache' --header 'Cache-Control: no-cache' --header 'Content-Type: application/json' --header 'Authorization: Bearer '${TOKEN} --data-raw '{"login":"thiago@realizati.com.br"}'
