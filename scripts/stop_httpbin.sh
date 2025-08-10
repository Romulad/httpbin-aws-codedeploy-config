#!/bin/bash
set -e

# Stop and remove httpbin container if running
if [ "$(sudo docker ps -q -f name=httpbin)" ]; then
    sudo docker stop httpbin || true
    sudo docker rm httpbin || true
else
    echo "No running httpbin container found."
fi
