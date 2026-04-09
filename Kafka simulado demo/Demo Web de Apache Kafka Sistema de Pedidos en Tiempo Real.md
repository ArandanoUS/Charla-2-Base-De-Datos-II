# Demo Web de Apache Kafka: Sistema de Pedidos en Tiempo Real

Una aplicación web interactiva y visual que demuestra los conceptos fundamentales de Apache Kafka mediante un sistema de procesamiento de pedidos en tiempo real.

## Características

- **Interfaz Visual Moderna**: Dashboard interactivo con Tailwind CSS
- **Tiempo Real**: Actualización en vivo cada 500ms del estado de los pedidos
- **Tres Fases de Pedidos**:
  - **Productor**: Pedidos esperando ser procesados
  - **Procesamiento**: Pedidos siendo consumidos
  - **Consumidor**: Pedidos completados
- **Estadísticas en Vivo**: Contador de pedidos totales, en procesamiento y completados
- **Animaciones Suaves**: Transiciones visuales para cada cambio de estado

## Requisitos

- Python 3.7 o superior
- pip (gestor de paquetes de Python)
- Navegador web moderno

## Instalación

### Windows

1. Descarga todos los archivos en una carpeta
2. Haz doble clic en `run_windows.bat`
3. Espera a que se instalen las dependencias
4. Abre tu navegador en `http://localhost:5000`

### Linux/macOS

```bash
chmod +x run_linux.sh
./run_linux.sh
```

Luego abre tu navegador en `http://localhost:5000`

## Cómo Funciona

### Arquitectura de la Demo

```
┌─────────────────────────────────────────────────────────────┐
│                    Flask Application                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Producer Thread          Kafka Topic          Consumer    │
│  (Genera Pedidos)    (Almacenamiento)    (Procesa Pedidos) │
│        ↓                      ↓                    ↓        │
│   Pending Orders    →   Processing Orders   →  Completed   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
         ↓
    Frontend (HTML/CSS/JS)
         ↓
    Navegador Web
```

### Conceptos de Kafka Demostrados

1. **Productor**: Genera pedidos aleatorios cada 1.5-3 segundos
2. **Tópico**: Los pedidos se almacenan en la "cola" de procesamiento
3. **Consumidor**: Procesa los pedidos de forma asíncrona (2-3 segundos cada uno)
4. **Desacoplamiento**: El productor y consumidor funcionan independientemente
5. **Escalabilidad**: Puede manejar múltiples pedidos simultáneamente

## Estructura de Archivos

```
kafka_demo_web/
├── app.py                 # Aplicación Flask con lógica de Kafka
├── requirements.txt       # Dependencias de Python
├── run_windows.bat        # Script para ejecutar en Windows
├── run_linux.sh          # Script para ejecutar en Linux/macOS
├── templates/
│   └── index.html        # Interfaz web
└── README.md             # Este archivo
```

## API Endpoints

- `GET /` - Página principal
- `GET /api/orders` - Obtiene el estado actual de todos los pedidos
- `GET /api/stats` - Obtiene las estadísticas (totales, en procesamiento, completados)
- `POST /api/reset` - Reinicia la demo

## Puntos Clave para la Presentación

1. **Desacoplamiento**: Observa cómo el productor envía pedidos sin saber quién los consume
2. **Asincronía**: Los pedidos se procesan de forma independiente al ritmo de generación
3. **Persistencia**: Los pedidos permanecen en el tópico hasta ser completados
4. **Escalabilidad**: Múltiples pedidos pueden estar en diferentes estados simultáneamente
5. **Tiempo Real**: La interfaz se actualiza instantáneamente con cada cambio

## Solución de Problemas

### "Puerto 5000 ya está en uso"
Cambia el puerto en `app.py` línea 65: `app.run(debug=False, host='0.0.0.0', port=5001)`

### "ModuleNotFoundError: No module named 'flask'"
Ejecuta: `pip install -r requirements.txt`

### "Python no encontrado"
Asegúrate de que Python esté instalado y agregado al PATH del sistema

## Personalización

Puedes modificar fácilmente:
- **Productos**: Edita la lista `PRODUCTS` en `app.py`
- **Velocidad de Generación**: Cambia el `time.sleep()` en `producer_thread()`
- **Tiempo de Procesamiento**: Cambia el `time.sleep()` en `consumer_thread()`
- **Colores**: Edita las clases de Tailwind en `templates/index.html`

¡Disfruta tu presentación! 🚀
