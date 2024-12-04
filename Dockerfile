FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt-get update && apt-get install -y python3.10-venv
COPY requirements.txt .
RUN python3 -m venv venv
RUN ./venv/bin/pip install requests pytz
RUN ./venv/bin/pip install requests
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod +x start.sh

CMD ["bash", "-c", "source /usr/src/app/venv/bin/activate && python3 update.py && python3 -m bot"]
