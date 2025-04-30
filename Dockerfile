# Dockerfile
FROM python:3.11-slim

RUN apt update && apt install -y \
    xvfb \
    x11-utils \
    tigervnc-standalone-server \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install -r requirements.txt

ENV DISPLAY=:1
ENV VNC_PORT=5901
ENV VNC_PASSWORD=password

EXPOSE $VNC_PORT

CMD ["sh", "-c", "vncserver :1 -geometry 1920x1080 -depth 24 && python gui/livestream_gui.py"]