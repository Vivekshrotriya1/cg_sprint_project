FROM python:3.11-slim

# System dependencies agar pandas/numpy ko zaroorat pade
RUN apt-get update && apt-get install -y gcc g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir torch==2.2.2+cpu --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

# Pura code copy karo
COPY . .

# PYTHONPATH set karo taaki modules mil sakein
# Saare folders ko path mein add kar do
ENV PYTHONPATH=/app:/app/api:/app/src:/app/agents:/app/blobstorage

EXPOSE 8000

# /app folder se hi start karo
# /app folder se chalayein, lekin module ko directly import karein
CMD ["python", "-m", "uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "8000"]