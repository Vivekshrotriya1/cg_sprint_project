FROM python:3.11-slim

WORKDIR /app

# 1. Pehle requirements copy ki
COPY requirements.txt /app/

# 2. Pip upgrade kiya
RUN pip install --upgrade pip

# 3. Sabse pehle PyTorch ko alag se download karke cache karlo (with retries)
RUN pip install --no-cache-dir --default-timeout=2000 --retries 10 torch==2.2.2+cpu --index-url https://download.pytorch.org/whl/cpu

# 4. Ab baaki saare bache hue packages install karo
RUN pip install --no-cache-dir --default-timeout=2000 --retries 10 -r requirements.txt

# 5. Code copy karo
COPY . /app

# Sabse IMPORTANT: Docker ko batao ki /app aur /app/api dono jagah modules dhoonde
ENV PYTHONPATH=/app:/app/api

EXPOSE 8000

# Server ko directly /app/api ke andar se chalayenge taki 'routes' asani se mil jaye
WORKDIR /app/api

CMD ["python", "-m", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]