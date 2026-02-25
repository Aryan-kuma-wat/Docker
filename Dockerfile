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
# PORT is injected by Render at runtime — default 5000 for local Docker use
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    CONTAINER_ENV="Docker Container" \
    PORT=5000

WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy application source code
COPY app.py .
COPY templates/ templates/

# Create a non-root user for security (best practice)
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

# Expose port (informational — Render overrides this via $PORT env var)
EXPOSE $PORT

# Health check — uses $PORT dynamically
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request, os; urllib.request.urlopen('http://localhost:' + os.environ.get('PORT','5000') + '/health')"

# Start Gunicorn — binds to 0.0.0.0:$PORT (Render sets $PORT automatically)
CMD gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 60 app:app
