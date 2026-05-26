FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y gcc g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Requirements install karo
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir torch==2.2.2+cpu --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

# Pura code copy karo
COPY . .

# Environment variables
ENV PYTHONPATH=/app
ENV BASE_PATH=/app

EXPOSE 8000

# Server chalane ka sahi tareeka
CMD ["python", "-m", "uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "8000"]