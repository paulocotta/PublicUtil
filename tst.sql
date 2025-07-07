select
  (
    select
      json_arrayagg(
        json_object(
          'id',`despesas`.`id`,
          'tag',`despesas`.`tag`,
          'ref',`despesas`.`ref`,
          'valor',`despesas`.`valor`,
          'venc',trim(`despesas`.`venc`),
          'pagto',trim(`despesas`.`pagto`),
          'status',`despesas`.`status`,
          'who',`despesas`.`who`,
          'obs',`despesas`.`obs`,
          'criado',trim(`despesas`.`criado`)
        )
      )
    from
      `despesas`
  ) AS `GetDespesas`,
  (
    select
      json_arrayagg(
        json_object(
          'id',`despesas_pm`.`id`,
          'ref',`despesas_pm`.`ref`,
          'valor',`despesas_pm`.`valor`,
          'cashback_perc',`despesas_pm`.`cashback_perc`,
          'cashback_valor',`despesas_pm`.`cashback_valor`,
          'venc',trim(`despesas_pm`.`venc`),
          'pagto',trim(`despesas_pm`.`pagto`),
          'status',`despesas_pm`.`status`,
          'who',`despesas_pm`.`who`,
          'tag',`despesas_pm`.`tag`,
          'obs',`despesas_pm`.`obs`,
          'criado',trim(`despesas_pm`.`criado`)
        )
      )
    from
      `despesas_pm`
  ) AS `GetDespesasPM`




#!/usr/bin/python3.8
# -*- coding: utf-8 -*-
# region Imports
from mysql.connector import connect
from os import environ
from time import sleep
cnx_conf={'host':'', 'user':'root', 'passwd':environ['PWD_DB'], 'database':'db_wsapp', 'port':'3606'}
#cnx_conf={'host':'', 'user':'root', 'passwd':environ['PWD_DB'], 'database':'db_wsapp', 'port':'3606', 'charset':'utf8mb4', 'collation':'utf8mb4_general_ci'}
#cnx_conf={'host':'', 'user':'root', 'passwd':environ['PWD_DB'], 'database':'db_wsapp', 'port':'3606', 'charset':'utf8mb4', 'collation':'utf8mb4_0900_ai_ci'}
# endregion
class Mysql:
	#:Init
	def __init__(self, conf=None) -> None:
		self.conf, self.cnx, self.cur = None, None, None
		self.conf = conf if (conf) else cnx_conf
		self.conf.update({'connect_timeout':30, 'autocommit':False, 'use_pure':False, 'compress':True, 'buffered':True})
		if ( self.conf.get('port',None) == None ): self.conf.update({'port':'3606'})

	#:Del
	def __del__(self) -> None:
		self.__close()
		try: del self
		except: pass

	#:Close
	def __close(self) -> None:
		try: self.cur.close()
		except: pass
		try: self.cnx.close()
		except: pass

	#:Exec
	def Exec(self, sql:str, args=None, commit=False, records=None) -> list:
		try:
			for _ in range(6):
				try:
					with connect(**self.conf) as self.cnx:
						#print(self.conf, self.cnx.charset, self.cnx.collation)
						with self.cnx.cursor(dictionary=True, buffered=True) as self.cur:
							results=self.cur.execute(sql.strip(), params=args, multi=True)
							records=[result.fetchall() for result in results if result.with_rows]
							if ( commit ): self.cnx.commit()
							#if ( cursor.rowcount < 0 ): records=cursor.fetchall()
							self.cur.close()
						self.cnx.close()
				except: sleep(2)
				else: return(records)
			else: raise
		except: raise Exception('Failed: Exec')





WITH status_max AS (
    SELECT 
        returns.vhash, 
        MAX(returns.status) AS max_status
    FROM returns
    GROUP BY returns.vhash
)
SELECT 
    tags.id_tag,
    tags.label,
    GROUP_CONCAT(tags_hchecks.id_hcheck SEPARATOR ',') AS ids_hcheck,
    status_max.max_status AS status_group,
    status.label AS status_group_label
FROM tags_hchecks
INNER JOIN tags ON tags.id_tag = tags_hchecks.id_tag
INNER JOIN hchecks ON hchecks.id_hcheck = tags_hchecks.id_hcheck
INNER JOIN status_max ON status_max.vhash = hchecks.vhash
INNER JOIN status ON status.id_status = status_max.max_status
WHERE tags.ativo = 's'
GROUP BY tags.id_tag, status_max.max_status, status.label
ORDER BY hchecks.label, hchecks.sigla;















Prezados, bom dia!

Gostaria de expressar meu sincero reconhecimento e agradecimento pelo excelente trabalho de Diego Santos Araújo no projeto Health Check V2.
Desde o início, sua postura proativa, comprometimento e competência técnica foram essenciais para o desenvolvimento e conclusão bem-sucedida do projeto.
Ao longo de toda a execução, Diego demonstrou um alto nível de profissionalismo, colaboração e dedicação, sempre buscando soluções eficazes e contribuindo significativamente para a qualidade do resultado final.

Seu empenho e expertise são dignos de reconhecimento e fazem dele um profissional exemplar.

Deixo aqui meus sinceros agradecimentos e elogios por sua atuação.

Atenciosamente,
Paulo Cotta


Fabio
Fuzetti
Cabral
Madureira
Thiago
Pinho
Edson
Cassio IBM
Outro IBM
Michelle
Ele

Segue spoiler: 
