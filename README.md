Ghost Anonimus - Advanced Pentesting IP Mask

Ghost Anonimus es una herramienta diseñada para entornos de pentesting controlado. Automatiza la creación de túneles mediante la red Tor, forzando el tráfico a través de un proxy SOCKS5 con rotación dinámica de identidad (The Master Touch) y protección contra fugas de DNS.

Para mayor anonimato, se recomienda utilizar una **VPN** antes de ejecutar la herramienta. Esto reduce el riesgo de exposición en caso de que se olvide utilizar la sintaxis necesaria, como agregar **`proxychains4`** antes de ejecutar cualquier herramienta. De esta forma, si ocurre un descuido, el tráfico seguirá saliendo a través de la VPN y no desde tu **IP real**.


----------------------------------------------------

Instalación Instantánea (One-Liner)

Para configurar todo el entorno automáticamente en Kali Linux, Parrot OS o Arch Linux, simplemente copia y pega el siguiente comando en tu terminal:

Bash:
       
        curl -sSL https://raw.githubusercontent.com/OFCALEXANDER/Ghost-Anonimus/main/setup.sh | bash


----------------------------------------------------------------------------------------------------------------------------

Una vez finalizada la instalación automática, sigue estos pasos:

PROCEDE Activar Tor manualmente:

Bash:
       
        sudo systemctl start tor

Para validar:

               sudo systemctl status tor


---------------------------------------------------------------------------------------------

PROCEDE Activar el entorno:

Bash:
       
        source venv/bin/activate && python3 ghost_proxy.py



----------------------------------------------------------------------------------------------------------------------------


Test de Invisibilidad

Antes de lanzar cualquier ataque, es vital confirmar que tu Chaleco de Invisibilidad está bien puesto. Le recomiendo realizar este test para validar el correcto funcionamiento de la herramienta.

Paso 1: Ver IP del Script, (Recomiendo anotar la IP que te salga aquí, por ejemplo: 185.220.101.10)

bash:
        
        source venv/bin/activate && python3 ghost_proxy.py

Paso 2: Ver IP del Sistema con Proxychains

bash:
        
        proxychains4 curl ifconfig.me


Antes y despues de ejecutar este comando es recomendable validar tu ip publica para evitar errores.

ÉXITO : Si la IP del Paso A y el Paso B son IGUALES (y diferentes a tu IP real).
ERROR : Si el Paso B te muestra tu IP real. (Validar la herramienta con: sudo service tor start).


-----------------------------------------------------------------------------------------------------------------------------


SE UTILIZA LA MISMA SINTAXIS PARA CUALQUIER ESCANEO O EJECUCIÓN DE HERRAMIENTA.
Al utilizar herramientas como nmap o sqlmap sean invisibles, úsalas con proxychains:

Bash:

        proxychains4 [HERRAMIENTA] [SINTAXIS DE HERRAMIENTA] [IP-VICTIMA]

Normal: nmap -sV target.com -> IP Detectada.

Invisible: proxychains4 nmap -sV target.com -> IP de Tor Detectada.

