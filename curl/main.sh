#!/bin/bash
[ ${HOSTNAME,,} != 'srv-itcloud-01' ] && { exit 9; } || { clear; echo 'Start'; }
source '/mnt/Data/08_GitHub/servers/srv-itcloud-01/curl/util.sh';
(find '/tmp/' -iname 'curls.tmp' -cmin +20 -type f -delete) >/dev/null 2>&1;
[ -s '/tmp/curls.tmp' ] || { GetData; }
[ -s '/tmp/curls.tmp' ] && { cat '/tmp/curls.tmp' | shuf | xargs -n3 -P10 '/mnt/Data/08_GitHub/servers/srv-itcloud-01/curl/motor.sh'; }
wait;
SetDataLote;
exit 0;