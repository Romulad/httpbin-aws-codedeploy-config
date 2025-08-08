#!/bin/bash
set -e

# Stop and remove httpbin container if running
if [ "$(docker ps -q -f name=httpbin)" ]; then
    docker stop httpbin || true
    docker rm httpbin || true
else
    echo "No running httpbin container found."
fi
