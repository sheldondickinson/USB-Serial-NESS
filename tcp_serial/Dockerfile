FROM python:3.9-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY tcp_serial_redirect.py /app/
COPY run.sh /app/

RUN chmod +x /app/run.sh

CMD ["/app/run.sh"]
