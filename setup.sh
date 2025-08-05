#!/bin/bash

echo "[+] Criando ambiente virtual..."
python3 -m venv venv
source venv/bin/activate

echo "[+] Instalando dependências..."
pip install -r requirements.txt

echo "[+] Garantindo permissões no flag.txt..."
echo "FLAG{command_injection_works}" > flag.txt
chmod 644 flag.txt

echo "[+] Iniciando o servidor Flask..."
python app.py
