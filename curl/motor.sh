#!/bin/bash
[ ${HOSTNAME,,} != 'srv-itcloud-01' ] && { exit 0; }
[ ${#} -ne 3 ] && { echo 'Parametro incorreto'; exit 9; } || { (renice -n -10 $$) >/dev/null 2>&1; }
source '/mnt/Data/08_GitHub/servers/srv-itcloud-01/curl/util.sh';

#:Check ENVs
VHASH=$(echo "${1}" | xargs);
TOKEN=$(echo "${2}" | xargs);
CMD_CURL=$(echo "${3}" | xargs | base64 -d);
[ -z "${VHASH}" ] || [ -z "${TOKEN}" ] || [ -z "${CMD_CURL}" ] && { echo 'Comando invalido ou vazio'; exit 9; }

#:Tokens
if [ $(echo "${TOKEN}" | egrep -csvi '_') -gt 0 ]; then
	[ $(echo "${TOKEN}" | egrep -csi 'ALEXA') -gt 0 ] && { GetTokenAlexa; }
	[ $(echo "${TOKEN}" | egrep -csi 'MKST') -gt 0 ] && { GetAccessToken; }
	[ -z "${TOKEN}" ] || [ "${TOKEN}" == '_' ] || [ "${TOKEN}" == 'null' ] && { exit 0; }
fi

#:Run
for i in {1..5}; do
	TMP=$(eval "${CMD_CURL}");
	TMP=$(echo "${TMP}" | xargs);
	NOW_STATUS_CODE=$(echo "${TMP}" | awk '{print $1}');
	[[ ${NOW_STATUS_CODE} =~ 000 ]] && { sleep 3; continue; }
	NOW_TPS=$(echo "${TMP}" | awk '{print $2}');
	ERROR=$(echo "${TMP}" | cut -d' ' -f3- | xargs);
	[ -n "${ERROR}" ] && { SendTgm "${VHASH} ${ERROR}"; }
	break;
done
echo "CALL \`SetCurls\`('${VHASH}|${NOW_STATUS_CODE}|${NOW_TPS}');" >> '/tmp/update.sql';

#:End
wait;
exit 0;