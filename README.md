Ghost Anonimus - Advanced Pentesting IP Mask

Ghost Anonimus es una herramienta diseñada para entornos de pentesting controlado. Automatiza la creación de túneles mediante la red Tor, forzando el tráfico a través de un proxy SOCKS5 con rotación dinámica de identidad (The Master Touch) y protección contra fugas de DNS.

----------------------------------------------------

Instalación Instantánea (One-Liner)

Para configurar todo el entorno automáticamente en Kali Linux, Parrot OS o Arch Linux, simplemente copia y pega el siguiente comando en tu terminal:

```bash
curl -sSL [https://raw.githubusercontent.com/OFCALEXANDER/Ghost-Anonimus/main/setup.sh](https://raw.githubusercontent.com/OFCALEXANDER/Ghost-Anonimus/main/setup.sh) | bash


-------------------------------------------------------------------------------------------------------------------------------------

Una vez finalizada la instalación automática, sigue estos pasos:

PROCEDE Activar el entorno:

Bash:
source venv/bin/activate

Bash:
python3 ghost_proxy.py

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Al utilizar herramientas como nmap o sqlmap también sean invisibles, úsalas con proxychains:

Bash:
proxychains4 nmap -sV [IP-VICTIMA]

---------------------------------------------------------------- 


SE UTILIZA LA MISMA SINTAXIS PARA CUALQUIER ESCANEO O EJECUCIÓN DE HERRAMIENTA.

Ejemplos de invisibilidad:
  Escaneo de puertos Nmap:

    Normal: nmap -sV target.com -> IP Detectada.
    Invisible: proxychains4 nmap -sV target.com -> IP de Tor Detectada.
