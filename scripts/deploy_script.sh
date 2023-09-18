#!/bin/bash

# Set your AWS instance IP address and SSH key file
AWS_INSTANCE_IP="34.230.161.156"
SSH_KEY_FILE="C:\Users\Buruc\OneDrive\Escritorio\Projecto personal\gbkey.pem"

# Directory to sync (update this based on your project)
SOURCE_DIR="C:\Users\Buruc\OneDrive\Escritorio\Projecto personal\pythonapp\"

# SSH into the AWS instance and sync files
ssh -i "$SSH_KEY_FILE" ec2-user@"$AWS_INSTANCE_IP" "rsync -avz --delete $SOURCE_DIR /home/ec2-user/pythonapp"
