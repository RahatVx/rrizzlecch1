# Use the base image
FROM mysterysd/wzmlx:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Set permissions for the app directory (avoid using 777 for security reasons)
RUN chmod -R 755 /usr/src/app

# Copy the requirements file into the container
COPY requirements.txt .

# Install system dependencies (if any are needed)
# Uncomment and modify if necessary
# RUN apt-get update && apt-get install -y curl git

# Install Python dependencies inside a virtual environment to avoid issues with the global environment
RUN python3 -m venv venv

# Activate the virtual environment and install dependencies
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files into the container
COPY . .

# Ensure the necessary executable (like xon-bit) is installed in the container
# Uncomment and adjust according to what `xon-bit` requires, if it's a system-level tool:
# RUN apt-get update && apt-get install -y xon-bit

# Make the start.sh script executable
RUN chmod +x start.sh

# Set the default command to run the update.py script first, then run the bot module
CMD ["bash", "-c", "python3 update.py && python3 -m bot"]
