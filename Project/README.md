# 🐳 SysInfo Dashboard — Dockerized Flask Application

> **Academic Docker Project** | Python · Flask · Docker · Gunicorn

A professional, containerized web application that displays **live system information** (CPU, RAM, Disk, OS, hostname) through a sleek dark-themed dashboard. Built as a complete demonstration of the Docker workflow: **Build → Run → Tag → Push**.

---

## 📁 Project Structure

```
Project/
├── app.py               # Flask application (main source code)
├── requirements.txt     # Python dependencies (pinned versions)
├── Dockerfile           # Multi-stage Docker build instructions
├── .dockerignore        # Files to exclude from Docker build context
├── templates/
│   └── index.html       # Jinja2 HTML dashboard template
└── README.md            # This file
```

---

## 🚀 Quick Start

> **Prerequisites**: Docker Desktop must be installed and running on Windows.

### Step 1 — Build the Docker Image

```powershell
docker build -t sysinfo-dashboard:1.0 .
```

**What this does:**
- Reads the `Dockerfile` in the current directory
- Downloads the base Python image (only once, cached after)
- Installs all dependencies from `requirements.txt`
- Copies your application code into the image
- Creates a ready-to-run image named `sysinfo-dashboard` with tag `1.0`

---

### Step 2 — Run the Container Locally

```powershell
docker run -d -p 5000:5000 --name sysinfo-app sysinfo-dashboard:1.0
```

**Flag explanations:**
| Flag | Meaning |
|------|---------|
| `-d` | Detached mode — runs in background |
| `-p 5000:5000` | Maps host port 5000 to container port 5000 |
| `--name sysinfo-app` | Gives the container a friendly name |

**✅ Verify it's running:**
```powershell
docker ps
```

**✅ Open in browser:**
```
http://localhost:5000
```

---

### Step 3 — View Container Logs

```powershell
docker logs sysinfo-app
```

---

### Step 4 — Tag the Image for Docker Hub

> Replace `YOUR_DOCKERHUB_USERNAME` with your actual Docker Hub username.

```powershell
docker tag sysinfo-dashboard:1.0 YOUR_DOCKERHUB_USERNAME/sysinfo-dashboard:1.0
```

**What this does:** Creates an alias for the image that includes your Docker Hub username, which is required for pushing.

---

### Step 5 — Login to Docker Hub

```powershell
docker login
```

Enter your Docker Hub username and password when prompted.

---

### Step 6 — Push the Image to Docker Hub

```powershell
docker push YOUR_DOCKERHUB_USERNAME/sysinfo-dashboard:1.0
```

**What this does:** Uploads your image to the public Docker Hub registry. Anyone can now pull and run it with:
```powershell
docker pull YOUR_DOCKERHUB_USERNAME/sysinfo-dashboard:1.0
```

---

## 🛑 Stopping & Cleaning Up

```powershell
# Stop the running container
docker stop sysinfo-app

# Remove the container
docker rm sysinfo-app

# (Optional) Remove the local image
docker rmi sysinfo-dashboard:1.0
```

---

## 🔬 Dockerfile — Best Practices Used

| Practice | Implementation |
|----------|----------------|
| **Multi-stage build** | Separate builder and runtime stages |
| **Slim base image** | `python:3.11-slim` instead of full Python image |
| **Non-root user** | Runs as `appuser` for security |
| **Health check** | `HEALTHCHECK` instruction monitors app availability |
| **Layer caching** | `requirements.txt` copied before source code |
| **Production server** | Gunicorn WSGI server (not Flask dev server) |
| **.dockerignore** | Excludes `venv/`, `.git/`, cache files |
| **Labels** | `LABEL` metadata for maintainer/version info |

---

## 📊 Application Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /` | Main dashboard with live system info |
| `GET /health` | JSON health check response |

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|-----------|
| Language | Python 3.11 |
| Web Framework | Flask 3.0.3 |
| WSGI Server | Gunicorn 22.0.0 |
| System Metrics | psutil 5.9.8 |
| Containerization | Docker (multi-stage) |
| Base Image | python:3.11-slim |

---

## 📸 Screenshots to Capture for Submission

1. **Project files** — VS Code / File Explorer showing all project files
2. **Docker build** — Terminal output of `docker build` command
3. **Docker run** — Terminal output of `docker run` command  
4. **docker ps** — Running container listed in terminal
5. **Browser dashboard** — `http://localhost:5000` showing system info
6. **Docker Hub** — Your image listed on hub.docker.com
7. **docker push** — Terminal output of the push command
8. **Docker Desktop** — GUI showing the running container

---

## 📄 Project Description (For Report)

> **SysInfo Dashboard** is a containerized web application developed using Python (Flask) and Docker. The application collects and displays real-time system information — including CPU usage, memory utilization, disk storage, OS details, and container hostname — through a responsive, dark-themed web dashboard.
>
> The project demonstrates a complete Docker workflow: building a production-grade image using a multi-stage `Dockerfile`, running the container locally, and publishing the image to Docker Hub for public distribution. Best practices including non-root execution, health checks, `.dockerignore`, slim base images, and Gunicorn as the production WSGI server have been implemented throughout to reflect industry standards.

---

*Built with ❤️ by Aryan | Docker Academic Project 2026*
