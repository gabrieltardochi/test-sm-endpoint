from amazonlinux:2023

ENV PYTHON_VERSION=3.11.9
ENV PYTHON_MAJOR_VERSION=3.11

RUN dnf install -y \
    python${PYTHON_MAJOR_VERSION} \
    python${PYTHON_MAJOR_VERSION}-devel \
    python${PYTHON_MAJOR_VERSION}-pip && \
    dnf clean all && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_MAJOR_VERSION} 2 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip${PYTHON_MAJOR_VERSION} 2
    
COPY sys-requirements.txt sys-requirements.txt
RUN dnf install -y $(cat sys-requirements.txt) && \
    dnf clean all

ENV TZ=America/Sao_Paulo

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src src
COPY app.py app.py

ENV SM_MODEL_DIR /opt/ml/model
ENV PYTHONBUFFERED=1

ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:8080", "app:app", "-n"]