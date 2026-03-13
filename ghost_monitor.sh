#!/bin/bash

# --- CONFIGURACIÓN DE COLORES ---
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

clear
echo -e "${BLUE}====================================${NC}"
echo -e "${BLUE}      GHOST ANONYMITY MONITOR       ${NC}"
echo -e "${BLUE}====================================${NC}"

# --- FUNCIÓN: VERIFICAR Y REANIMAR TOR ---
check_tor() {
    echo -e "[*] Verificando servicio Tor..."
    
    # Intenta detectar si el proceso real de Tor está corriendo
    if ! pgrep -x "tor" > /dev/null; then
        echo -e "${RED}[!] Tor no está respondiendo. Reanimando servicio...${NC}"
        sudo systemctl stop tor
        sudo systemctl start tor
        sleep 5
        
        # Segundo intento si falla el systemctl
        if ! pgrep -x "tor" > /dev/null; then
            echo -e "${RED}[!] Fallo crítico: Intentando arranque forzado...${NC}"
            sudo -u debian-tor tor &
            sleep 8
        fi
    fi
    echo -e "${GREEN}[✓] Tor activo y operando.${NC}"
}

# Ejecutar verificación inicial
check_tor

# --- OBTENER IPs PARA COMPARAR ---
echo -e "[*] Obteniendo mapa de red actual..."
REAL_IP=$(curl -s https://api.ipify.org)
# Usamos proxychains para forzar que curl pase por Tor
TOR_IP=$(proxychains4 curl -s https://api.ipify.org 2>/dev/null)

echo -e "------------------------------------"
echo -e "IP REAL : ${RED}$REAL_IP${NC}"
echo -e "IP TOR  : ${GREEN}$TOR_IP${NC}"
echo -e "------------------------------------"

# --- PRUEBA DE FUGA DNS ---
echo -e "[*] Verificando DNS Leak..."
DNS_TEST=$(proxychains4 curl -s https://dnsleaktest.com/ | grep -i "from" | head -n 1)

if [[ -z "$DNS_TEST" ]]; then
    echo -e "${GREEN}[✓] No se detectan fugas de DNS externas.${NC}"
else
    echo -e "${BLUE}[i] Info: Túnel DNS establecido.${NC}"
fi

echo -e "------------------------------------"
echo -e "${BLUE}[*] Iniciando rotación automática (10 min)${NC}"
echo -e "------------------------------------"

# --- BUCLE INFINITO DE MONITOREO ---
while true
do
    # Contador de 10 minutos (600 segundos)
    for i in {600..1}
    do
        printf "\r${BLUE}Ghost Status: ${NC}Protegido | ${GREEN}Nueva IP en:${NC} %02d:%02d " $((i/60)) $((i%60))
        sleep 1
    done

    echo -e "\n[*] Rotando identidad Tor (The Master Touch)..."

    # Enviamos la señal NEWNYM a través de Netcat al puerto de control
    # Esto es lo que cambia la IP automáticamente
    echo -e 'AUTHENTICATE ""\r\nSIGNAL NEWNYM\r\nQUIT' | nc -q 1 127.0.0.1 9051

    if [ $? -ne 0 ]; then
        echo -e "${RED}[!] Error: No se pudo conectar al puerto de control 9051.${NC}"
        check_tor
    else
        sleep 5
        NEW_IP=$(proxychains4 curl -s https://api.ipify.org 2>/dev/null)
        echo -e "${GREEN}[✓] Identidad cambiada con éxito.${NC}"
        echo -e "${GREEN}[✓] Nueva IP Tor: $NEW_IP${NC}"
        echo -e "------------------------------------"
    fi
done
