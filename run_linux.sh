#!/bin/bash

echo "==================================================================="
echo "Demo de Apache Kafka: Sistema de Pedidos en Tiempo Real"
echo "==================================================================="
echo ""

# Verificar si Python está instalado
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 no está instalado"
    echo "Por favor, instala Python 3 desde https://www.python.org/"
    exit 1
fi

# Instalar dependencias
echo "[SISTEMA] Instalando dependencias..."
pip3 install -r requirements.txt

# Iniciar la aplicación Flask
echo ""
echo "[SISTEMA] Iniciando la aplicación Flask..."
echo ""
echo "==================================================================="
echo "Abre tu navegador en: http://localhost:5000"
echo "Presiona Ctrl+C para detener la aplicación"
echo "==================================================================="
echo ""

python3 app.py
