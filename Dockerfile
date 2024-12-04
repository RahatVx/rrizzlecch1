# Use an appropriate base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /usr/src/app

# Install dependencies for venv and build tools
RUN apt-get update && apt-get install -y python3.10-venv build-essential

# Copy requirements and install dependencies
COPY requirements.txt .
RUN python3 -m venv venv
RUN ./venv/bin/pip install requests pytz
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Add xon-bit binary to the container (correct path assumed)
COPY bin/xon-bit /usr/src/app/xon-bit

# Make xon-bit executable
RUN chmod +x /usr/src/app/xon-bit

# Default command to run the application
CMD ["./venv/bin/python3", "update.py", "&&", "./venv/bin/python3", "-m", "bot"]
