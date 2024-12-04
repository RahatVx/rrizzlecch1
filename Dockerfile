FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod -R 755 /usr/src/app

COPY requirements.txt .

RUN python3 -m venv venv

RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod +x start.sh

CMD ["bash", "start.sh"]
