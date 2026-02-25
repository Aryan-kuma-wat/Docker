"""
SysInfo Dashboard - A Flask-based System Information Web App
Dockerized Application for Academic Submission
Author: Aryan
"""

from flask import Flask, render_template
import platform
import socket
import os
import datetime
import psutil

app = Flask(__name__)

def get_system_info():
    """Collect live system and container information."""
    boot_time = datetime.datetime.fromtimestamp(psutil.boot_time())
    cpu_percent = psutil.cpu_percent(interval=0.5)
    mem = psutil.virtual_memory()
    disk = psutil.disk_usage('/')

    return {
        "app_name": "SysInfo Dashboard",
        "version": "1.0.0",
        "timestamp": datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC"),
        "hostname": socket.gethostname(),
        "ip_address": socket.gethostbyname(socket.gethostname()),
        "os_name": platform.system(),
        "os_version": platform.version(),
        "architecture": platform.machine(),
        "python_version": platform.python_version(),
        "cpu_count": psutil.cpu_count(logical=True),
        "cpu_usage": f"{cpu_percent:.1f}%",
        "total_ram": f"{mem.total / (1024**3):.2f} GB",
        "used_ram": f"{mem.used / (1024**3):.2f} GB",
        "ram_usage": f"{mem.percent:.1f}%",
        "total_disk": f"{disk.total / (1024**3):.2f} GB",
        "used_disk": f"{disk.used / (1024**3):.2f} GB",
        "disk_usage": f"{disk.percent:.1f}%",
        "container_env": os.environ.get("CONTAINER_ENV", "Docker Container"),
        "boot_time": boot_time.strftime("%Y-%m-%d %H:%M:%S"),
    }

@app.route("/")
def index():
    info = get_system_info()
    return render_template("index.html", info=info)

@app.route("/health")
def health():
    return {"status": "healthy", "service": "SysInfo Dashboard"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
