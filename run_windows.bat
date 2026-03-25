@echo off
title Demo Apache Kafka: Sistema de Pedidos en Tiempo Real (Web)
echo ===================================================================
echo Demo de Apache Kafka: Sistema de Pedidos en Tiempo Real
echo ===================================================================
echo.

:: Verificar si Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python no está instalado o no está en el PATH
    echo Por favor, instala Python desde https://www.python.org/
    pause
    exit /b 1
)

:: Instalar dependencias
echo [SISTEMA] Instalando dependencias...
pip install -r requirements.txt

:: Iniciar la aplicación Flask
echo.
echo [SISTEMA] Iniciando la aplicación Flask...
echo.
echo ===================================================================
echo Abre tu navegador en: http://localhost:5000
echo Presiona Ctrl+C para detener la aplicación
echo ===================================================================
echo.

python app.py

pause
