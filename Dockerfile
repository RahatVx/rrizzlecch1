# Use an appropriate base image (e.g., Python image)
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /usr/src/app

# Install system dependencies for Python venv and other dependencies
RUN apt-get update && apt-get install -y python3.10-venv build-essential

# Set permissions for the app directory
RUN chmod -R 755 /usr/src/app

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Create a virtual environment
RUN python3 -m venv venv

RUN ./venv/bin/pip install requests pytz

# Install dependencies into the virtual environment
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files into the container
COPY . .

# Add xon-bit binary to the container
COPY xon-bit /usr/src/app/xon-bit

# Make the xon-bit file executable
RUN chmod +x /usr/src/app/xon-bit

# Set the default command to run your Python script or app
CMD ["./venv/bin/python3", "update.py", "&&", "./venv/bin/python3", "-m", "bot"]
