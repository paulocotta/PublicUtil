#!/bin/bash
#clear;
#echo "RUN: $(basename ${0^^})";
renice -n -10 $$ >/dev/null 2>&1;
export CURL_CONF='/mnt/Data/08_GitHub/servers/global/bots/curl.conf';

#:GetPlanos
function GetPlanos(){
	for _ in {1..3}; do
		local TMP=$(timeout 3m curl8 --config ${CURL_CONF} --write-out 'HTTP_CODE:%{http_code}' --request GET --url 'https://id.opf.itau.com.br/.well-known/openid-configuration' --header 'Content-Type: application/json');
		[ $? -eq 0 ] && { break; } || { continue; }
	done
	# local HTTP_CODE=${TMP##*HTTP_CODE:};
	# local RESP_BODY=${TMP%%HTTP_CODE:*};
	# echo ${RESP_BODY};
	# echo ${HTTP_CODE};
}

GetPlanos;
wait;
exit 0;

# seq 1 1000 | xargs -n1 -P300 '/mnt/Data/08_GitHub/servers/global/bots/src/PostarPraVender.sh';
# seq 1 10 | xargs -n 1 -P 4 -I {} ./simple_task.sh
# [ $(uname -a | egrep -csi 'x86_64') -eq 1 ] && { wget --quiet --output-document='/usr/bin/curl8' 'https://github.com/moparisthebest/static-curl/releases/download/v8.7.1/curl-amd64'; chmod +x '/usr/bin/curl8'; }
#### Substituição Simples
# - `${parameter}`: Substitui pelo valor de `parameter`.
# - `${parameter:-word}`: Substitui por `word` se `parameter` estiver vazio ou não definido.
# - `${parameter:=word}`: Substitui por `word` se `parameter` estiver vazio ou não definido, e define `parameter` como `word`.
# - `${parameter:+word}`: Substitui por `word` se `parameter` estiver definido e não vazio. Caso contrário, substitui por vazio.
# - `${parameter:?word}`: Exibe `word` como mensagem de erro se `parameter` estiver vazio ou não definido.
# local CHAT_ID=${1:-"201591376"};
# pkill -fi 'StressTest'; pkill -fi 'curl8';
# curl8 --no-show-error --request GET --url 'https://api.mkst.app/getPlanos' --header 'Content-Type: application/json'
# [ -z "${TMP}" ] && { echo '===='; continue; }
# mktemp