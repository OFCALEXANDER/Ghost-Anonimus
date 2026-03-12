import requests
import time
from stem import Signal
from stem.control import Controller
from fake_useragent import UserAgent

proxies = {
    'http': 'socks5h://127.0.0.1:9050',
    'https': 'socks5h://127.0.0.1:9050'
}

def rotate_identity():
    try:
        with Controller.from_port(port=9051) as controller:
            controller.authenticate()
            controller.signal(Signal.NEWNYM)
            print("\n[!] IDENTIDAD ROTADA - IP CAMBIADA")
            time.sleep(5)
    except Exception as e:
        print(f"[-] Error al rotar IP: {e}")

def get_status():
    ua = UserAgent()
    try:
        s = requests.Session()
        s.headers.update({'User-Agent': ua.random})
        r = s.get('https://ipapi.co/json/', proxies=proxies, timeout=10)
        data = r.json()
        print(f"[+] IP ACTUAL: {data['ip']} | PAÍS: {data['country_name']}")
    except:
        print("[-] Error: Tor no responde. Asegúrate de ejecutar el setup.sh primero.")

if __name__ == "__main__":
    print("--- GHOST ANONYMUS LOADED ---")
    get_status()
    rotate_identity()