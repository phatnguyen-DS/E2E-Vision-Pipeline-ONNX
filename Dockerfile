FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements-frontend.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements-frontend.txt
COPY src/ui/ src/ui/

EXPOSE 8501
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl --fail http://localhost:8501/_stcore/health || exit 1
CMD ["streamlit", "run", "src/ui/streamlit.py", "--server.port=8501", "--server.address=0.0.0.0"]
