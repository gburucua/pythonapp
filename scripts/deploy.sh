#!/bin/bash

# Set AWS instance IP address and other variables
AWS_INSTANCE_IP="34.230.161.156"
DOCKER_IMAGE_NAME="pythonapp"
DOCKER_IMAGE_TAG="latest"

# Authenticate with Docker Hub
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

# SSH into your AWS instance and deploy the updated image
ssh -i ~/.ssh/id_rsa ec2-user@$AWS_INSTANCE_IP <<EOF
  docker pull gburucua/pythonapp:latest
  docker stop gburucua/pythonapp:latest
  docker rm gburucua/pythonapp:latest
  docker run -d -p 5000:5000 --name pythonapp gburucua/pythonapp:latest
EOF
