def ParseCurl():
	from shlex import split
	from base64 import b64decode
	from re import compile, MULTILINE
	from json import dumps, loads
	_COMPACT_RE=compile(r'\s{2,}|\n|\\', MULTILINE)
	_DATA_FLAGS={'-d', '--data', '--data-raw', '--data-binary'}
	_HEADER_FLAGS={'-H', '--header'}
	_METHOD_FLAGS={'-X', '--request'}
	try:
		jdata=load(open('/mnt/Data/08_GitHub/servers/srv-itcloud-01/aqui.json', 'r', encoding='utf-8'))
		jdata['cmd']=b64decode(jdata['cmd']).decode('utf-8').strip()
		jdata['cmd']=_COMPACT_RE.sub('', jdata['cmd']).strip()
		tokens=split(jdata['cmd'], posix=True)
		assert((tokens) and (tokens[0]=='curl')), 'Comando inválido. Esperado curl ...'
		it=iter(tokens[1:])
		method, url, headers, data_parts, data = 'GET', None, dict(), list(), None
		for tok in it:
			if ( tok in _METHOD_FLAGS ): method=next(it).upper()
			elif ( tok in _HEADER_FLAGS ):
				header=next(it)
				k,v=header.split(':', 1)
				headers[k.strip()]=v.strip()
			elif ( tok in _DATA_FLAGS ): data_parts.append(next(it))
			elif ( tok.startswith('-') ): continue
			elif ( url is None ): url=tok
			else: continue
		else: pass
		if ( data_parts ): data='&'.join(data_parts)
		try: data=loads(data)
		except: pass
		parsed={'method':method, 'url':url, 'headers':headers, 'data':data}
		print(dumps(parsed, ensure_ascii=False, indent=2))
	except Exception as e:
		print(str(e))
		# print_exc()
		# raise Exception('Failed: ParseCurl')
ParseCurl()
#jdata['cmd']=sub(r'\s{2,}|\n|\\', str(), jdata['cmd'], 0, MULTILINE).strip()
exit()

Successfully installed pyperclip-1.9.0 uncurl-0.0.11

--header.'(.+?)'
import uncurl

print(uncurl.parse("""curl -X POST https://api.wsapp.com.br/getCep --header 'Cache-Control: no-cache' --header 'Content-Type: application/json' --header 'Pragma: no-cache' --data '{"token": "219eae5aa550ac56140122b7f85f5d254b29c513","cep": "09820240"}'"""))

curl -s --libcurl out.c --output /dev/null --write-out '%{http_code}' \
--request POST --url https://api.wsapp.com.br/getCep \
--header 'Cache-Control: no-cache' \
--header 'Content-Type: application/json' --header 'Pragma: no-cache' --data '{"token": "219eae5aa550ac56140122b7f85f5d254b29c513","cep": "09820240"}'

curl --libcurl out.c 'https://api.exemplo.com' -H 'X: Y' --data 'a=b'
