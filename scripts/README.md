# Scripts for CodeDeploy

- `start_httpbin.sh`: Installs Docker if needed, starts the httpbin container, checks health, and handles errors.
- `stop_httpbin.sh`: Stops and removes the httpbin container safely.

No other scripts are required for deployment. All error handling and edge cases are managed in these two scripts.
