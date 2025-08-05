#!/bin/bash

echo "[1/6] Atualizando pacotes..."
sudo apt update -y

echo "[2/6] Instalando Python com dependências necessárias..."
sudo apt install -y python3 python3-pip python3-venv

echo "[3/6] Criando ambiente virtual com Python padrão do sistema..."
python3 -m venv venv

if [ ! -f "venv/bin/activate" ]; then
    echo "[ERRO] Ambiente virtual não foi criado corretamente."
    exit 1
fi

echo "[4/6] Ativando ambiente virtual e instalando Flask..."
source venv/bin/activate
pip install --upgrade pip
pip install Flask==2.3.2

echo "[5/6] Criando arquivo de flag..."
echo "FLAG{command_injection_works}" | sudo tee /etc/flag.txt > /dev/null
sudo chmod 644 /etc/flag.txt

echo "[6/6] Iniciando servidor Flask em http://localhost:5000 ..."
python app.py
