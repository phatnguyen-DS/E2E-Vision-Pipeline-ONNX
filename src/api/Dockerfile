FROM python:3.10-bullseye
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libc6-dev \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY src/api/requirements-backend.txt .
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements-backend.txt
COPY src ./src
COPY model ./model
ENV PYTHONPATH=/app
EXPOSE 8000
CMD ["uvicorn", "src.api.api:app", "--host", "0.0.0.0", "--port", "8000"]
