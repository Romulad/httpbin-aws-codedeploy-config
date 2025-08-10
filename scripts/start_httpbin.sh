#!/bin/bash

set -e

# Ensure Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing..."
    if command -v yum &> /dev/null; then
        sudo yum update -y
        sudo amazon-linux-extras install docker -y || sudo yum install docker -y
        sudo service docker start
        sudo usermod -a -G docker ec2-user
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update -y
        sudo apt-get install -y docker.io
        sudo systemctl start docker
        sudo usermod -aG docker ec2-user
    else
        echo "Unsupported OS. Please install Docker manually."
        exit 1
    fi
fi

# Start Docker if not running
if ! pgrep -x "dockerd" > /dev/null; then
    echo "Starting Docker service..."
    sudo service docker start || sudo systemctl start docker
fi

# Stop any running httpbin container
if [ "$(sudo docker ps -q -f name=httpbin)" ]; then
    echo "Stopping existing httpbin container..."
    sudo docker stop httpbin || true
    sudo docker rm httpbin || true
fi

# Pull latest image
sudo docker pull kennethreitz/httpbin

# Start httpbin container
sudo docker run -d --name httpbin -p 80:80 kennethreitz/httpbin || {
    echo "Failed to start httpbin container. Checking for port conflicts..."
    if lsof -Pi :80 -sTCP:LISTEN -t >/dev/null ; then
        echo "Port 80 is in use. Please free the port and retry."
        exit 2
    fi
    exit 1
}

# Health check
for i in {1..10}; do
    sleep 2
    if curl -s http://localhost:80 | grep -q 'httpbin'; then
        echo "httpbin is running."
        exit 0
    fi
done
echo "httpbin did not start successfully. Check Docker logs."
sudo docker logs httpbin
exit 3
