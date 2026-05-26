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
ENV PYTHONPATH=/app

EXPOSE 8000

# /app folder se hi start karo
CMD ["python", "-m", "uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "8000"]