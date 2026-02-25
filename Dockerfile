<<<<<<< HEAD:Project/Dockerfile
# ─────────────────────────────────────────────
# Stage 1: Builder — install dependencies only
# ─────────────────────────────────────────────
FROM python:3.11-slim AS builder

WORKDIR /app

# Install deps into a dedicated directory (keeps final image clean)
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ─────────────────────────────────────────────
# Stage 2: Runtime — minimal production image
# ─────────────────────────────────────────────
FROM python:3.11-slim

# Metadata labels (best practice)
LABEL maintainer="Aryan <your-email@example.com>"
LABEL version="1.0.0"
LABEL description="SysInfo Dashboard - Dockerized Flask App"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    CONTAINER_ENV="Docker Container"

WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy application source code
COPY app.py .
COPY templates/ templates/

# Create a non-root user for security (best practice)
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

# Expose the application port
EXPOSE 5000

# Health check (best practice)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"

# Use Gunicorn as production WSGI server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--timeout", "60", "app:app"]
=======
# ─────────────────────────────────────────────
# Stage 1: Builder — install dependencies only
# ─────────────────────────────────────────────
FROM python:3.11-slim AS builder

WORKDIR /app

# Install deps into a dedicated directory (keeps final image clean)
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ─────────────────────────────────────────────
# Stage 2: Runtime — minimal production image
# ─────────────────────────────────────────────
FROM python:3.11-slim

# Metadata labels (best practice)
LABEL maintainer="Aryan <your-email@example.com>"
LABEL version="1.0.0"
LABEL description="SysInfo Dashboard - Dockerized Flask App"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    CONTAINER_ENV="Docker Container"

WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy application source code
COPY app.py .
COPY templates/ templates/

# Create a non-root user for security (best practice)
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

# Expose the application port
EXPOSE 5000

# Health check (best practice)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"

# Use Gunicorn as production WSGI server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--timeout", "60", "app:app"]
>>>>>>> df8d927a8c8bb69b44291b0ae631f6cf0945aab2:Dockerfile
