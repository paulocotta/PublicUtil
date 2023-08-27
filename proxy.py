from selenium import webdriver

PROXY_HOST = "proxy_host"
PROXY_PORT = "proxy_port"
PROXY_USER = "proxy_username"
PROXY_PASS = "proxy_password"

# Configurações do proxy com as credenciais
PROXY = f"{PROXY_USER}:{PROXY_PASS}@{PROXY_HOST}:{PROXY_PORT}"
webdriver.DesiredCapabilities.CHROME['proxy'] = {
    "httpProxy": PROXY,
    "ftpProxy": PROXY,
    "sslProxy": PROXY,
    "proxyType": "MANUAL",
}

# Inicialização do driver do Chrome com as configurações do proxy
driver = webdriver.Chrome()



from selenium import webdriver

PROXY_HOST = "proxy_host"
PROXY_PORT = "proxy_port"
PROXY_USER = "proxy_username"
PROXY_PASS = "proxy_password"

# Configurações do proxy com as credenciais
proxy = {
    "proxy": {
        "httpProxy": f"http://{PROXY_USER}:{PROXY_PASS}@{PROXY_HOST}:{PROXY_PORT}",
        "ftpProxy": f"ftp://{PROXY_USER}:{PROXY_PASS}@{PROXY_HOST}:{PROXY_PORT}",
        "sslProxy": f"https://{PROXY_USER}:{PROXY_PASS}@{PROXY_HOST}:{PROXY_PORT}",
        "noProxy": None,
        "proxyType": "MANUAL",
        "class": "org.openqa.selenium.Proxy",
        "autodetect": False,
    }
}

# Inicialização do driver do Chrome com as configurações do proxy
options = webdriver.ChromeOptions()
options.set_capability("proxy", proxy)
driver = webdriver.Chrome(options=options)


from selenium import webdriver

PROXY_HOST = "proxy_host"
PROXY_PORT = "proxy_port"
PROXY_USER = "proxy_username"
PROXY_PASS = "proxy_password"

# Configurações do proxy com as credenciais
options = webdriver.ChromeOptions()
options.add_argument(f"--proxy-server=http://{PROXY_USER}:{PROXY_PASS}@{PROXY_HOST}:{PROXY_PORT}")

# Inicialização do driver do Chrome com as configurações do proxy
driver = webdriver.Chrome(options=options)


from selenium import webdriver

# Definir as credenciais do servidor proxy
proxy_username = 'user'
proxy_password = 'pass'

# Configurar o servidor proxy com as credenciais
proxies = {'http': f'http://{proxy_username}:{proxy_password}@<proxy_server_address>:<proxy_port>',
           'https': f'https://{proxy_username}:{proxy_password}@<proxy_server_address>:<proxy_port>'}

# Criar uma instância do navegador
options = webdriver.ChromeOptions()
options.add_argument('--proxy-server=http://<proxy_server_address>:<proxy_port>')
options.add_argument('--ignore-certificate-errors')
driver = webdriver.Chrome(options=options)

# Iniciar uma sessão do navegador com o servidor proxy configurado
driver.get('https://www.google.com/')




from selenium import webdriver
from selenium.webdriver.common.keys import Keys

# Configurar as informações do servidor proxy
proxy_server_address = '<proxy_server_address>'
proxy_port = '<proxy_port>'
proxy_username = '<proxy_username>'
proxy_password = '<proxy_password>'

# Criar uma instância do navegador
driver = webdriver.Chrome()

# Abrir uma página qualquer para forçar a janela de autenticação do proxy aparecer
driver.get('https://www.google.com')

# Enviar as credenciais do servidor proxy para os campos correspondentes na janela de autenticação
alert = driver.switch_to.alert
alert.send_keys(proxy_username)
alert.send_keys(Keys.TAB)
alert.send_keys(proxy_password)
alert.accept()

# Configurar o servidor proxy com as credenciais
proxy = f'{proxy_username}:{proxy_password}@{proxy_server_address}:{proxy_port}'
driver.execute_script(f"chrome.proxy.settings.set({{'value': {{'mode': 'fixed_servers', 'rules': {{'singleProxy': {{'scheme': 'http', 'host': '{proxy_server_address}', 'port': {proxy_port}}}}, 'bypassList': []}}, 'scope': 'regular'}}, function() {{}});")



"proxy-server=http://john:password123@127.0.0.1:8080",



docker run -d \
  -e http_proxy=http://<username>:<password>@<proxy_host>:<proxy_port> \
  -e https_proxy=http://<username>:<password>@<proxy_host>:<proxy_port> \
  -p 8080:80 \
  meu-container
                            
                            
                            
                            
ie=list([ElementNotVisibleException,ElementNotSelectableException,NoSuchElementException,WebDriverException,TimeoutException,StaleElementReferenceException])

def PsKill(ctn:str, driver=None) -> None:
	try: driver.quit()
	except: pass
	try: [os.system(f'(docker exec --privileged --tty --user=root "{ctn}" ""pkill -fi "{app}""") >/dev/null 2>&1') for app in list(['chrome','webpki','chromedriver','xdotool'])]
	except: raise Exception('Failed: PsKill')

