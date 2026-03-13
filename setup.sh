#!/bin/bash
# Instalador automático para entornos Linux, nada de MACBOOK

echo "[*] Instalando dependencias del sistema..."
# Agregamos netcat-openbsd (necesario para la rotación de IP del monitor)
sudo apt update && sudo apt install -y tor proxychains4 python3-pip python3-venv git netcat-openbsd curl

# Opcional: Si el usuario ya está en la carpeta, no clonar de nuevo
if [ ! -d ".git" ]; then
    echo "[*] Descargando Ghost Anonimus..."
    git clone https://github.com/OFCALEXANDER/Ghost-Anonimus.git
    cd Ghost-Anonimus || exit
fi

echo "[*] Configurando Tor ControlPort..."
sudo bash -c 'grep -q "ControlPort 9051" /etc/tor/torrc || echo "ControlPort 9051" >> /etc/tor/torrc'
sudo bash -c 'grep -q "CookieAuthentication 1" /etc/tor/torrc || echo "CookieAuthentication 1" >> /etc/tor/torrc'

echo "[*] Reiniciando y habilitando servicio Tor..."
# ESTA ES LA MEJORA: Asegura que el servicio no quede en 'exited'
sudo systemctl enable tor
sudo systemctl restart tor
sleep 2

echo "[*] Creando entorno virtual..."
python3 -m venv venv
source venv/bin/activate

echo "[*] Instalando dependencias Python..."
pip install -r requirements.txt

# DAR PERMISOS AL MONITOR
chmod +x ghost_monitor.sh

echo ""
echo "[+] CONFIGURACIÓN COMPLETADA."
echo "------------------------------------------------------------------"
echo "[!] IMPORTANTE: Si Tor falla, usa: sudo systemctl restart tor"
echo "[!] Para modo manual: source venv/bin/activate && python3 ghost_proxy.py"
echo "[!] Para modo monitor: ./ghost_monitor.sh"
echo "------------------------------------------------------------------"
