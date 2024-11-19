# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for OpenCV and other requirements
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the application code and model into the container
COPY . /app

# Ensure the model directory exists
RUN mkdir -p /app/model

# Explicitly copy the model file if not already included in the above COPY
COPY best.pt /app/model/best.pt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port your app runs on
EXPOSE 8080

# Run app.py when the container launches
CMD ["python", "app.py"]
