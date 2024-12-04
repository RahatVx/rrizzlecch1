FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN python3 venv wzmlxenv

COPY requirements.txt .
RUN wzmlxenv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
