from flask import Flask, render_template, jsonify, request
from flask_cors import CORS
import json
import os
import threading
import time
import random
from datetime import datetime

app = Flask(__name__)
CORS(app)

# Almacenamiento en memoria para los pedidos
orders_data = {
    "pending": [],      # Pedidos en el tópico (esperando ser procesados)
    "processing": [],   # Pedidos siendo procesados
    "completed": [],    # Pedidos completados
    "stats": {
        "total_orders": 0,
        "completed_orders": 0,
        "processing_orders": 0
    }
}

# Productos disponibles
PRODUCTS = ["Laptop", "Mouse", "Teclado", "Monitor", "Auriculares", "Webcam", "Silla Gamer", "Escritorio"]

def generate_order():
    """Genera un pedido aleatorio"""
    return {
        "id": orders_data["stats"]["total_orders"] + 1,
        "product": random.choice(PRODUCTS),
        "quantity": random.randint(1, 3),
        "timestamp": datetime.now().strftime("%H:%M:%S"),
        "status": "pending"
    }

def producer_thread():
    """Simula el productor de Kafka"""
    while True:
        time.sleep(random.uniform(1.5, 3))
        order = generate_order()
        orders_data["stats"]["total_orders"] += 1
        orders_data["pending"].append(order)

def consumer_thread():
    """Simula el consumidor de Kafka"""
    while True:
        time.sleep(0.5)
        if orders_data["pending"]:
            # Mover un pedido de pending a processing
            order = orders_data["pending"].pop(0)
            order["status"] = "processing"
            order["processing_timestamp"] = datetime.now().strftime("%H:%M:%S")
            orders_data["processing"].append(order)
            orders_data["stats"]["processing_orders"] = len(orders_data["processing"])
            
            # Simular procesamiento (2-3 segundos)
            time.sleep(random.uniform(2, 3))
            
            # Mover a completado
            order["status"] = "completed"
            order["completed_timestamp"] = datetime.now().strftime("%H:%M:%S")
            orders_data["processing"].remove(order)
            orders_data["completed"].append(order)
            orders_data["stats"]["processing_orders"] = len(orders_data["processing"])
            orders_data["stats"]["completed_orders"] += 1
            
            # Mantener solo los últimos 10 completados en la vista
            if len(orders_data["completed"]) > 10:
                orders_data["completed"] = orders_data["completed"][-10:]

@app.route('/')
def index():
    """Página principal"""
    return render_template('index.html')

@app.route('/api/orders')
def get_orders():
    """API para obtener el estado actual de los pedidos"""
    return jsonify(orders_data)

@app.route('/api/stats')
def get_stats():
    """API para obtener estadísticas"""
    return jsonify(orders_data["stats"])

@app.route('/api/reset', methods=['POST'])
def reset_demo():
    """Reinicia la demo"""
    global orders_data
    orders_data = {
        "pending": [],
        "processing": [],
        "completed": [],
        "stats": {
            "total_orders": 0,
            "completed_orders": 0,
            "processing_orders": 0
        }
    }
    return jsonify({"status": "reset"})

if __name__ == '__main__':
    # Iniciar los threads de productor y consumidor
    producer = threading.Thread(target=producer_thread, daemon=True)
    consumer = threading.Thread(target=consumer_thread, daemon=True)
    
    producer.start()
    consumer.start()
    
    # Iniciar la aplicación Flask
    print("=" * 60)
    print("Demo de Apache Kafka: Sistema de Pedidos en Tiempo Real")
    print("=" * 60)
    print("Abre tu navegador en: http://localhost:5000")
    print("Presiona Ctrl+C para detener la aplicación")
    print("=" * 60)
    
    app.run(debug=False, host='0.0.0.0', port=5000)
