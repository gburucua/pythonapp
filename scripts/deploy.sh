#!/bin/bash

# Set AWS instance IP address and other variables
AWS_INSTANCE_IP="34.230.161.156"
DOCKER_IMAGE_NAME="pythonapp"
DOCKER_IMAGE_TAG="latest"

# Container name to use
CONTAINER_NAME="pythonapp"

# Authenticate with Docker Hub
# echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin


# SSH into your AWS instance and deploy the updated image
ssh -i ~/.ssh/id_rsa ec2-user@$AWS_INSTANCE_IP "

 # Stop and remove the container if it exists
    if docker ps -a --format '{{.Names}}' | grep -Eq '^$CONTAINER_NAME\$'; then
        echo 'Stopping and removing existing container...'
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
    fi

  # Authenticate with Docker Hub
  echo \"${DOCKER_PASSWORD}\" | docker login -u \"${DOCKER_USERNAME}\" --password-stdin

  # Pull the Docker image
  docker pull gburucua/pythonapp:latest

  # Run the Docker container
  docker run -d -p 5000:5000 --name pythonapp gburucua/pythonapp:latest

  # Remove old Docker images to free up space
  docker image prune -af
  "



