Get-Service LxssManager
Restart-Service LxssManager


dism.exe /online /get-feature /featurename:Microsoft-Windows-Subsystem-Linux

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart

https://gist.github.com/franciscojsc/127da118d12a0b83c064407c5e860d71


wsl --shutdown
wsl -d Ubuntu -- ip a          # deve listar eth0
wsl -d Ubuntu -- ping 1.1.1.1  # teste de saída

[wsl2]
networkingMode=mirrored
dnsTunneling=true
autoProxy=true

https://learn.microsoft.com/pt-br/windows/wsl/wsl-config#configuration-settings-for-wslconfig
https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig
[wsl2]
networkingMode=bridged
vmSwitch=myswitch1

[wsl2]
kernel=C:\\WINDOWS\\System32\\lxss\\tools\\5.15.90.1-kernel-usb
networkingMode=mirrored
dnsTunneling=true
firewall=false
autoProxy=true

[experimental]
sparseVhd=true
autoMemoryReclaim=gradual

[wsl2]
networkingMode=VirtioProxy   # ou "virtioproxy"; não há distinção de maiúsculas
localhostForwarding=true     # mantém acesso via localhost




[wsl2]
networkingMode=VirtioProxy   ; obriga o WSL a usar o proxy virtio-socket
localhostForwarding=true     ; mantém portas localhost disponíveis
dnsTunneling=true            ; opcional, evita quebra de DNS em VPN
wsl.exe -d wsl-vpnkit --cd /app wsl-vpnkit   # foreground (p/ testes)




# Build markdown content for the session summary
content = textwrap.dedent("""
# WSL 2 — Rede com **VirtioProxy** + **wsl-vpnkit**

## 1  Contexto
Erro comum ao iniciar o WSL 2:  
**“Failed to configure network (networkingMode Nat)”**  
Causa: NAT do WSL depende do HNS/Hyper-V; quando esses componentes estão ausentes ou a porta 53 está ocupada, a interface NAT não sobe.

## 2  Modos de rede disponíveis
| networkingMode | Requisitos | Notas |
| -------------- | ---------- | ----- |
| `NAT` (padrão) | VMP, Hyper-V, WHP, HNS | Falha se componentes ou porta 53 indisponíveis |
| `None` | Nenhum | Usado com **wsl-vpnkit** quando não se quer NAT |
| `mirrored` | Windows 11 22H2+, WSL ≥ 2.0.9 | Replica NICs/IPs do host |
| `VirtioProxy` | VMP; sem HNS | IP da VM == IP do host; funciona onde NAT/HNS falham |

## 3  Procedimento rápido — **VirtioProxy + wsl-vpnkit**

1. **Editar `%USERPROFILE%\\.wslconfig`:**
   ```ini
   [wsl2]
   networkingMode=VirtioProxy
   localhostForwarding=true
   dnsTunneling=true   ; opcional
