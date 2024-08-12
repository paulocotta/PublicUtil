#!/usr/bin/env python3
# -*- coding: utf-8 -*-
if (True):
	import sys, os; sys.dont_write_bytecode=True
	from time import sleep
	from requests import request
	from json import load
	from re import search, MULTILINE, IGNORECASE, DOTALL
	sys.path.append(os.path.dirname(__file__)+'/../../global/pkg')
	from SGDB import Mysql
	jdata=load(open('/tmp/jdata.json', 'r', encoding='utf-8'))
	headers=dict({'Pragma':'no-cache', 'Cache-Control':'no-cache', 'Cache-Control':'no-store', 'Cache-Control':'no-transform', 'User-Agent':'WhatsApp/2.20.201.2 A'})

#:FUNCTIONS
def AllClose() -> None:
	try: sys.modules[__name__].__dict__.clear()
	except: pass
	finally: exit()
def SendTgm(message:str()) -> None:
	try:
		url, message = str('https://api.telegram.org/bot676689288:AAGItCflxsTv3098I7nLCwyGlWETe5J-boE/sendMessage'), str(message).strip()
		payload={'chat_id':'201591376', 'text':message, 'parse_mode':'html'}
		for _ in range(5):
			try:
				r=request('POST', url, data=payload, timeout=10, allow_redirects=True)
				assert(int(r.status_code)==200)
				break
			except: pass
		else: raise
	except: print('Failed: SendTgm')
def Request(jdata:dict) -> dict:
	ret=dict({'id_check':0, 'status_code':0, 'tps':0, 'match':0, 'reason':str('UNKNOWN'), 'bypass':list([429])})
	try:
		for _ in range(jdata['retry']):
			try:
				ret['id_check']=jdata['id_check']
				jdata['headers']=dict(jdata['headers'], **headers)
				r=request(jdata['method'], jdata['url'], headers=jdata['headers'], json=jdata['body'], timeout=jdata['timeout'], verify=True, allow_redirects=True)
				ret['status_code']=r.status_code
				ret['tps']=r.elapsed.total_seconds()
				ret['reason']=str(r.reason)
				assert((r.status_code in ret['bypass']) or (r.status_code in list(jdata['status_code'])))
				if ( (jdata['match']) and (not search(r'{}'.format(jdata['match']), str(r.text), MULTILINE|IGNORECASE|DOTALL)) ): raise
				ret['match']=1
				break
			except: sleep(jdata['delay'])
		else: raise Exception('Max Retry Loop')
	except Exception as e: print(type(e), str(e))
	finally: return(ret)

#:MAIN
try:
	DB=Mysql()
	jdata=jdata[int(sys.argv[1])]
	print('Process', jdata['vhash'])
	ret=Request(jdata)
	sql=str(f"CALL `SetCheck`(JSON_OBJECT('id_check','{ret['id_check']}', 'ret_status_code','{ret['status_code']}', 'ret_tps','{ret['tps']}', 'ret_match','{ret['match']}', 'ret_reason','{ret['reason']}'));")
	DB.Exec(sql)
except Exception as e: print(type(e), str(e))
else: print(sql)

#:END
AllClose()
sys.exit()