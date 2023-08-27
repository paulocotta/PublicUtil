parabens para o marco e pedir o endereço

function TesteSX(){
	for i in {1..5}; do {
		TMP=$(curl --retry 10 --retry-delay 3 --max-time 10 --fail --insecure --silent --location --compressed \
			--output '/dev/null' \
			--write-out '%{http_code}' \
			--request POST 'https://aaaaaaaa/bbbbbbb' \
			--header 'Content-Type: application/json' \
			--data '{"zap_seu": "11946034552"}');
		echo "${TMP}";
		[ "${TMP}" == '200' ] && { break; } || { sleep 5; }
	} done
}

TesteSX;
exit;


function TesteSX(){
	TMP=$(curl \
		--output '/dev/null' \
		--write-out '%{http_code}' \
		--retry 10 \
		--retry-delay 3 \
		--fail \
		--insecure \
		--silent \
		--location \
		--compressed \
		--max-time 10 \
		--request POST 'https://aaaaaaaa/bbbbbbb' \
		--header 'Content-Type: application/json' \
		--data '{"zap_seu": "11946034552"}');
	echo "${TMP}";
	[ "${TMP}" != '201' ] && { TesteSX; }
}

TesteSX;


def DelGif():
	try:
		records=DB.Exec("CALL `ssssssssssssss`(JSON_OBJECT('act','cleanup'));")
		assert(records)
		for val in records[0]:
			for _ in range(5):
				try:
					r=get(val['link'], timeout=20, allow_redirects=True, headers=headers_rest)
					assert(r.status_code==200)
				except: time.sleep(5)
				else: break
			else:
				print('Delete:', val['id'], val['link'], r.status_code)
				SendTgm(message=f"DelGif: {val['id']}, {val['link']}, {r.status_code}")
		else: pass
	except Exception as e: SetLogging('DelGif', 40)

