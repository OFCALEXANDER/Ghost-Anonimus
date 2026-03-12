#!/bin/bash
# Instalador automático para entornos Linux (Kali/Parrot/Arch)

echo "[*] Instalando dependencias del sistema..."
sudo apt update && sudo apt install -y tor proxychains4 python3-pip python3-venv

echo "[*] Configurando Tor ControlPort..."
sudo bash -c 'grep -q "ControlPort 9051" /etc/tor/torrc || echo "ControlPort 9051" >> /etc/tor/torrc'
sudo bash -c 'grep -q "CookieAuthentication 1" /etc/tor/torrc || echo "CookieAuthentication 1" >> /etc/tor/torrc'

sudo service tor restart

echo "[*] Creando entorno virtual..."
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

echo "[+] Configuración completada."
echo "[!] Para ejecutar usa: source venv/bin/activate && python3 ghost_proxy.py"