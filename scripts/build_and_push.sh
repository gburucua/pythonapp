#!/bin/bash

# Set AWS instance IP address and other variables
#AWS_INSTANCE_IP="34.230.161.156"
DOCKER_IMAGE_NAME="pythonapp"
DOCKER_IMAGE_TAG="latest"
REPOSITORY_NAME="pythonapp"


# Set the SSH private key path
SSH_PRIVATE_KEY_PATH="$HOME/.ssh/id_rsa"

# Ensure the SSH key exists
if [ ! -f "$SSH_PRIVATE_KEY_PATH" ]; then
    echo "SSH private key not found at: $SSH_PRIVATE_KEY_PATH"
    exit 1
fi

# Set appropriate permissions for the SSH private key
chmod 600 "$SSH_PRIVATE_KEY_PATH"


#Docker login
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

# Build the Docker image
docker build -t gburucua/pythonapp:latest .

# Push the Docker image to a registry (e.g., Docker Hub)
docker push gburucua/pythonapp:latest


# SSH into your AWS instance and deploy the updated image
#ssh -i ~/.ssh/id_rsa ec2-user@$AWS_INSTANCE_IP <<EOF
#  docker pull $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG
#  docker stop pythonapp
#  docker rm pythonapp
#  docker run -d -p 80:80 --name pythonapp $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG
#EOF
