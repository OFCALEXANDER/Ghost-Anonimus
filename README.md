Ghost Anonimus - Advanced Pentesting IP Mask

Ghost Anonimus es una herramienta diseñada para entornos de pentesting controlado. Automatiza la creación de túneles mediante la red Tor, forzando el tráfico a través de un proxy SOCKS5 con rotación dinámica de identidad (The Master Touch) y protección contra fugas de DNS.

Para mayor anonimato, se recomienda utilizar una **VPN** antes de ejecutar la herramienta. Esto reduce el riesgo de exposición en caso de que se olvide utilizar la sintaxis necesaria, como agregar **`proxychains4`** antes de ejecutar cualquier herramienta. De esta forma, si ocurre un descuido, el tráfico seguirá saliendo a través de la VPN y no desde tu **IP real**.


----------------------------------------------------

Instalación Instantánea (One-Liner)

Para configurar todo el entorno automáticamente en Kali Linux, Parrot OS o Debian, simplemente copia y pega el siguiente comando en tu terminal:

Bash:
       
        git clone https://github.com/OFCALEXANDER/Ghost-Anonimus.git && cd Ghost-Anonimus && chmod +x *.sh && ./setup.sh


----------------------------------------------------------------------------------------------------------------------------

Una vez finalizada la instalación automática, sigue estos pasos:

Activación del Escudo
Se recomienda abrir una terminal dedicada para el monitor. Este script asegura que Tor esté siempre activo y rota tu IP automáticamente cada 10 minutos:

Bash:
       
        cd ~/Ghost-Anonimus && chmod +x ghost_monitor.sh && ./ghost_monitor.sh





----------------------------------------------------------------------------------------------------------------------------



SE UTILIZA LA MISMA SINTAXIS PARA CUALQUIER ESCANEO O EJECUCIÓN DE HERRAMIENTA.
Al utilizar herramientas como nmap o sqlmap sean invisibles, úsalas con proxychains:

Bash:

        proxychains4 [HERRAMIENTA] [SINTAXIS DE HERRAMIENTA] [IP-VICTIMA]

Normal: nmap -sV target.com -> IP Detectada.

Invisible: proxychains4 nmap -sV target.com -> IP de Tor Detectada.

