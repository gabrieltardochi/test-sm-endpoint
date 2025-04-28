FROM python:3.10.4

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src src
COPY app.py app.py

ENV SM_MODEL_DIR /opt/ml/model

ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:8080", "app:app", "-n"]