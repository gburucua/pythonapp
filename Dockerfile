# Use the official Python image as the base image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the Python requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Python application code into the container
COPY data_entry_app.py .

# Copy the templates folder into the container
COPY templates/ ./templates/

# Set the entrypoint command to run the Python application
CMD ["python", "data_entry_app.py"]

