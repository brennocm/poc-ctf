#!/bin/bash

echo "[1/6] Atualizando pacotes..."
sudo apt update -y

echo "[2/6] Instalando Python 3.12 com dependências necessárias..."
sudo apt install -y python3.12 python3.12-venv python3.12-ensurepip python3.12-distutils python3.12-full

echo "[3/6] Criando ambiente virtual com Python 3.12..."
python3.12 -m venv venv

if [ ! -f "venv/bin/activate" ]; then
    echo "[ERRO] Ambiente virtual não foi criado corretamente."
    exit 1
fi

echo "[4/6] Ativando ambiente virtual e instalando Flask..."
source venv/bin/activate
pip install --upgrade pip
pip install Flask==2.3.2

echo "[5/6] Criando arquivo de flag..."
echo "FLAG{command_injection_works}" > flag.txt
chmod 644 flag.txt

echo "[6/6] Iniciando servidor Flask em http://localhost:5000 ..."
python app.py
