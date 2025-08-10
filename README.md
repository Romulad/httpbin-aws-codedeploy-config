# httpbin AWS CodeDeploy

This repo contains everything needed to deploy the [kennethreitz/httpbin](https://hub.docker.com/r/kennethreitz/httpbin) Docker image to an EC2 instance using AWS CodeDeploy.

## Structure
- `appspec.yml`: CodeDeploy specification file
- `scripts/start_httpbin.sh`: Starts the httpbin Docker container
- `scripts/stop_httpbin.sh`: Stops the httpbin Docker container

## Usage
1. Upload the content of this repo as a zip to your S3 bucket for CodeDeploy.
2. Create a CodeDeploy deployment using this bundle.

The service will be available on port 80.
