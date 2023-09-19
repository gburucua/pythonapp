#!/bin/bash

# Set AWS instance IP address and other variables
#AWS_INSTANCE_IP="34.230.161.156"
DOCKER_IMAGE_NAME="pythonapp"
DOCKER_IMAGE_TAG="latest"
REPOSITORY_NAME="pythonapp"

# Set the SSH private key from the GitHub secret
echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

#Docker login
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

# Build the Docker image
#docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG .
docker build -t $DOCKER_USERNAME/$REPOSITORY_NAME .

# Push the Docker image to a registry (e.g., Docker Hub)
docker push $DOCKER_USERNAME/$REPOSITORY_NAME

# SSH into your AWS instance and deploy the updated image
#ssh -i ~/.ssh/id_rsa ec2-user@$AWS_INSTANCE_IP <<EOF
#  docker pull $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG
#  docker stop pythonapp
#  docker rm pythonapp
#  docker run -d -p 80:80 --name pythonapp $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG
#EOF
