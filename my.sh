SELECT (16*1024*1024), (131072/1024/1024);
performance_schema_show_processlist = 1                       # Ativa SHOW PROCESSLIST via Performance Schema – útil para monitorar conexões
[mysqld_safe]
socket = /var/run/mysqld/mysqld.sock       # Caminho do socket Unix local
nice = 0                                   # Prioridade padrão do processo

[mysqld]
# ================== CONFIGURAÇÕES BÁSICAS ==================
user = mysql                                # Usuário do sistema que roda o MySQL
pid-file = /var/run/mysqld/mysqld.pid       # PID file do processo MySQL
socket = /var/run/mysqld/mysqld.sock        # Socket local
port = 3606                                 # Porta de escuta do MySQL (alterada da padrão 3306)
basedir = /usr                              # Diretório base de instalação
datadir = /var/lib/mysql                    # Diretório onde ficam os dados
tmpdir = /tmp                               # Diretório para arquivos temporários
lc-messages-dir = /usr/share/mysql          # Diretório de mensagens traduzidas
symbolic-links = 0                          # Desativa links simbólicos (por segurança)
connect_timeout = 10                        # Tempo de timeout para conexões (segundos)
skip-external-locking                       # Evita locking externo (aumenta desempenho)
skip-name-resolve                           # Evita resolução DNS (usa apenas IP)
federated                                    # Ativa engine FEDERATED (acesso remoto a dados)

# ================== LOCALIZAÇÃO E COMPATIBILIDADE ==================
lc_time_names = "pt_BR"                     # Datas/meses em português do Brasil
default_time_zone = "-03:00"                # Fuso horário GMT-3
character_set_server = "utf8"               # Charset padrão (compatível com sistemas legados)
collation_server = "utf8_general_ci"        # Regras de ordenação/comparação de strings
sql_mode = "TRADITIONAL"                    # SQL mais estrito (modo tradicional)
event_scheduler = 1                         # Habilita o agendador de eventos SQL

# ================== OTIMIZAÇÃO E DESEMPENHO ==================
optimizer_search_depth = 62                 # Profundidade de busca do otimizador
innodb_dedicated_server = 1                 # Ajustes automáticos InnoDB (baseado na máquina)
innodb_flush_log_at_trx_commit = 0          # Maior desempenho, menos durabilidade (escreve log 1x/seg)
innodb_io_capacity = 2000                   # Capacidade de I/O do disco (otimiza operações)
innodb_read_io_threads = 16                 # Threads de leitura paralela
innodb_write_io_threads = 16                # Threads de escrita paralela
innodb_thread_concurrency = 0               # Sem limite de concorrência de threads InnoDB
innodb_file_per_table = 1                   # Um arquivo .ibd por tabela InnoDB
innodb_autoinc_lock_mode = 0                # Lock tradicional para AUTO_INCREMENT (compatibilidade)
innodb_buffer_pool_instances = 8            # Instâncias do buffer pool (melhora concorrência)
innodb_buffer_pool_size = 4G                # Cache de dados InnoDB (quanto maior, melhor)
innodb_log_buffer_size = 16M                # Buffer para log de transações InnoDB
innodb_doublewrite = 0                      # Desativa escrita dupla (melhora performance, menos segurança)
sync_binlog = 0                             # Não sincroniza binlog a cada transação (melhor performance)
innodb_log_file_size = 1G                   # Tamanho dos arquivos de log do InnoDB
innodb_log_files_in_group = 2               # Número de arquivos de log do InnoDB
innodb_undo_tablespaces = 2                 # Tablespaces separados para UNDO
innodb_max_undo_log_size = 1G               # Tamanho máximo do log UNDO antes de limpar
tmp_table_size = 256M                       # Tamanho máximo de tabelas temporárias em memória
max_heap_table_size = 256M                  # Tamanho máximo para tabelas em memória (HEAP)

# ================== CACHE E OTIMIZAÇÕES ==================
log_bin_trust_function_creators = 1         # Permite criar funções que modificam dados sem SUPER
thread_cache_size = -1                      # MySQL ajusta automaticamente o cache de threads
group_concat_max_len = 4294967295           # Tamanho máximo para GROUP_CONCAT
net_read_timeout = 31536000                 # Tempo máximo para leitura de rede (segundos)
net_write_timeout = 31536000                # Tempo máximo para escrita de rede (segundos)
max-execution-time = 900000                 # Tempo máximo para execução de uma query (ms)
join_buffer_size = 4M                       # Buffer para joins sem índice
sort_buffer_size = 4M                       # Buffer para ordenações
read_rnd_buffer_size = 4M                   # Buffer de leitura aleatória após ordenação
thread_stack = 1M                           # Tamanho da pilha de cada thread

# ================== AUTENTICAÇÃO E ACESSO ==================
default_authentication_plugin = mysql_native_password  # Plugin de autenticação padrão
table_open_cache = 3000                                # Número máximo de tabelas abertas simultaneamente
open_files_limit = 65535                               # Limite de arquivos abertos (sistema + MySQL)
bind-address = 0.0.0.0                                  # Aceita conexões externas (qualquer IP)

# ================== RECUPERAÇÃO E CONFIABILIDADE ==================
myisam-recover-options = BACKUP            # Tenta recuperar tabelas MyISAM corrompidas (faz backup antes)
max_connections = 201                       # Máximo de conexões simultâneas permitidas

# ================== LOGS E REPLICAÇÃO ==================
log_error = /var/log/mysql/error.log        # Caminho do log de erros
log_error_verbosity = 1                     # Nível de verbosidade dos logs de erro
binlog_expire_logs_seconds = 172800         # Expiração do binlog após 2 dias (em segundos)
expire_logs_days = 2                        # Expiração dos logs em dias (legado)
max_binlog_size = 100M                      # Tamanho máximo de um arquivo binlog



# ================== LOGS E REPLICAÇÃO ==================
# ================== LOGS E REPLICAÇÃO ==================
# ================== LOGS E REPLICAÇÃO ==================
# ================== LOGS E REPLICAÇÃO ==================
# ================== LOGS E REPLICAÇÃO ==================
# ================== LOGS E REPLICAÇÃO ==================



[mysqld_safe]
socket  = /var/run/mysqld/mysqld.sock                         # Caminho do socket Unix local
nice    = 0                                                   # Prioridade padrão do processo

[mysqld]
#
# * BASIC SETTINGS
#
user                    = mysql                               # Usuário do sistema que roda o MySQL
pid-file                = /var/run/mysqld/mysqld.pid          # PID file do processo MySQL
socket                  = /var/run/mysqld/mysqld.sock         # Socket local
port                    = 3606                                # Porta de escuta do MySQL (alterada da padrão 3306)
basedir                 = /usr                                # Diretório base de instalação
datadir                 = /var/lib/mysql                      # Diretório onde ficam os dados
tmpdir                  = /tmp                                # Diretório para arquivos temporários
lc-messages-dir         = /usr/share/mysql                    # Diretório de mensagens traduzidas
symbolic-links          = 0                                   # Desativa links simbólicos (por segurança)
connect_timeout         = 10                                  # Tempo de timeout para conexões (segundos)
skip-external-locking                                         # Evita locking externo (aumenta desempenho)
skip-name-resolve                                             # Evita resolução DNS (usa apenas IP)
federated                                                     # Ativa engine FEDERATED (acesso remoto a dados)

#
# * LOCALIZAÇÃO E COMPATIBILIDADE
#
lc_time_names                     = "pt_BR"                   # Datas/meses em português do Brasil
default_time_zone                 = "-03:00"                  # Fuso horário GMT-3
character_set_server              = "utf8"                    # Charset padrão (compatível com sistemas legados)
collation_server                  = "utf8_general_ci"         # Regras de ordenação/comparação de strings
sql_mode                          = "TRADITIONAL"             # SQL mais estrito (modo tradicional): "TRADITIONAL,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
event_scheduler                   = 1                         # Habilita o agendador de eventos SQL
log_bin_trust_function_creators   = 1                         # Permite criar funções que modificam dados sem SUPER

#
# * OTIMIZAÇÃO E DESEMPENHO
#
optimizer_search_depth            = 62                        # Profundidade de busca do otimizador (Default: 0)
innodb_dedicated_server           = 1                         # Ajustes automáticos InnoDB (baseado na máquina)
innodb_flush_log_at_trx_commit    = 0                         # Maior desempenho, menos durabilidade (escreve log 1x/seg)
innodb_io_capacity                = 10000                     # Capacidade de I/O do disco (otimiza operações)
innodb_read_io_threads            = 16                        # Threads de leitura paralela
innodb_write_io_threads           = 16                        # Threads de escrita paralela
innodb_thread_concurrency         = 0                         # Sem limite de concorrência de threads InnoDB
innodb_file_per_table             = 1                         # Um arquivo .ibd por tabela InnoDB
innodb_autoinc_lock_mode          = 0                         # Lock tradicional para AUTO_INCREMENT (compatibilidade)
innodb_buffer_pool_instances      = 8                         # Instâncias do buffer pool (melhora concorrência)
innodb_buffer_pool_size           = 5G                        # Cache de dados InnoDB (quanto maior, melhor)
innodb_log_buffer_size            = 16M                       # Buffer para log de transações InnoDB
innodb_doublewrite                = 0                         # Desativa escrita dupla (melhora performance, menos segurança)
sync_binlog                       = 0                         # Não sincroniza binlog a cada transação (melhor performance)
innodb_log_file_size              = 1G                        # Tamanho dos arquivos de log do InnoDB
innodb_log_files_in_group         = 3                         # Número de arquivos de log do InnoDB
innodb_undo_tablespaces           = 2                         # Tablespaces separados para UNDO
innodb_max_undo_log_size          = 1G                        # Tamanho máximo do log UNDO antes de limpar
tmp_table_size                    = 256M                      # Tamanho máximo de tabelas temporárias em memória
max_heap_table_size               = 256M                      # Tamanho máximo para tabelas em memória (HEAP)
#innodb_flush_log_at_trx_commit   = 1
#innodb_read_io_threads           = 64
#innodb_write_io_threads          = 64
#innodb_buffer_pool_instances     = 16
#innodb_buffer_pool_instances     = 24
#innodb_buffer_pool_instances     = 36
#innodb_buffer_pool_size          = 32G
#innodb_flush_method              = O_DIRECT

#
# * CACHE E OTIMIZAÇÕES
#
group_concat_max_len              = 4294967295                # Tamanho máximo para GROUP_CONCAT
net_read_timeout                  = 31536000                  # Tempo máximo para leitura de rede (segundos)
net_write_timeout                 = 31536000                  # Tempo máximo para escrita de rede (segundos)
max-execution-time                = 900000                    # Tempo máximo para execução de uma query (ms)
join_buffer_size                  = 4M                        # Buffer para joins sem índice
sort_buffer_size                  = 4M                        # Buffer para ordenações
read_buffer_size                  = 1M                        # Tamanho do buffer para leitura sequencial por conexão
read_rnd_buffer_size              = 4M                        # Buffer de leitura aleatória após ordenação
thread_stack                      = 1M                        # Tamanho da pilha de cada thread
#thread_cache_size                = -1                        # MySQL ajusta automaticamente o cache de threads
#join_buffer_size                 = 8M
#join_buffer_size                 = 10M
#sort_buffer_size                 = 8M
#sort_buffer_size                 = 10M
#thread_stack                     = 256K
#thread_stack                     = 512K

#
# * AUTENTICAÇÃO E ACESSO
# * Instead of skip-networking the default is now to listen only on localhost which is more compatible and is not less secure.
#
performance_schema_show_processlist = 1                       # Ativa SHOW PROCESSLIST via Performance Schema – útil para monitorar conexões
default_authentication_plugin       = mysql_native_password   # Plugin de autenticação padrão
table_open_cache                    = 4000                    # Número máximo de tabelas abertas simultaneamente
open_files_limit                    = 65535                   # Limite de arquivos abertos (sistema + MySQL): Vide Systemd: LimitNOFILE=65535
bind-address                        = 0.0.0.0                 # Aceita conexões externas (qualquer IP)
#mysqlx-bind-address                = 0.0.0.0
#skip-networking                    = 1
# general_log                       = 1
# general_log_file                  = /tmp/mysql_query.log
# log_output                        = 'TABLE'
# slow_query_log                    = 1
# slow_query_log_file               = /var/log/mysql/mysql-slowquery.log

#
# If MySQL is running as a replication slave, this should be
# changed. Ref https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmpdir
# tmpdir  = /tmp
#
#
# * Fine Tuning
#
# key_buffer_size             = 16M   #DEFAULT
# key_buffer_size             = 128M
# max_allowed_packet          = 128M
# thread_stack                = 512K
# max_heap_table_size         = 256M  #:NEW

# This replaces the startup script and checks MyISAM tables if needed the first time they are touched
myisam-recover-options        = BACKUP                        # Tenta recuperar tabelas MyISAM corrompidas (faz backup antes)
max_connections               = 201                           # Máximo de conexões simultâneas permitidas

#
# * Query Cache Configuration
#
# query_cache_type            = 1
# query_cache_limit           = 64M
# query_cache_min_res_unit    = 2k
# query_cache_size            = 512M
# query_cache_limit           = 1M    #DEFAULT
# query_cache_size            = 16M   #DEFAULT

#
# * Logging and Replication
#
# Both location gets rotated by the cronjob.
#
# Log all queries
# Be aware that this log type is a performance killer.
# general_log_file  = /var/log/mysql/query.log
# general_log       = 1

#
# Error log - should be very few entries.
#
log_error = /var/log/mysql/error.log                        # Caminho do log de erros
log_error_verbosity = 1                                     # Nível de verbosidade dos logs de erro

#
# Here you can see queries with especially long duration
# slow_query_log        = 1
# slow_query_log_file   = /var/log/mysql/mysql-slow.log
# long_query_time       = 2
# log-queries-not-using-indexes
#
# The following can be used as easy to replay backup logs or for replication.
# note: if you are setting up a replication slave, see README.Debian about other settings you may need to change.
#server-id                    = 1
#log_bin                      = /var/log/mysql/mysql-bin.log
#binlog_expire_logs_seconds   = 2592000
#binlog_do_db                 = include_database_name
#binlog_ignore_db             = include_database_name
#expire_logs_days             = 10  #:Deprecated > binlog_expire_logs_seconds
binlog_expire_logs_seconds    = 172800                      # Expiração do binlog após 2 dias (em segundos): (60 segundos * 60 minutos * 24 horas * 2 dias)
expire_logs_days              = 2                           # Expiração dos logs em dias (legado)
max_binlog_size               = 100M                        # Tamanho máximo de um arquivo binlog
#
# * InnoDB
#
# InnoDB is enabled by default with a 10MB datafile in /var/lib/mysql/.
# Read the manual for more InnoDB related options. There are many!
#
# * Security Features
#
# Read the manual, too, if you want chroot!
# chroot = /var/lib/mysql/
#
# For generating SSL certificates I recommend the OpenSSL GUI "tinyca".
#
# ssl-ca=/etc/mysql/cacert.pem
# ssl-cert=/etc/mysql/server-cert.pem
# ssl-key=/etc/mysql/server-key.pem
#:END
# innodb_flush_log_at_trx_commit = 0: O InnoDB grava os logs de transações no buffer de log e os grava no disco a cada segundo. Menor durabilidade de dados, maior desempenho.
# innodb_flush_log_at_trx_commit = 1: (Padrão) O InnoDB grava os logs de transações no buffer de log e no disco a cada commit de transação. Máxima durabilidade de dados, impacto potencial no desempenho devido a operações frequentes de I/O.
# innodb_flush_log_at_trx_commit = 2: O InnoDB grava os logs de transações no buffer de log a cada commit, mas grava no disco uma vez por segundo. Compromisso entre durabilidade de dados e desempenho.
