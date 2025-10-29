# secure_deploy_script

## Overview
`secure_deploy.sh` is a Bash script that automates the secure deployment of a Python service behind Nginx with SSL encryption. The script handles SSL certificate generation, Nginx configuration, and Dockerized service deployment, ensuring a reliable and secure setup for development or production environments.

## Features
- Generates self-signed SSL certificates using OpenSSL (if not already present).
- Configures Nginx with SSL for secure HTTPS access.
- Builds and runs Python services inside Docker containers.
- Automates deployment steps, including stopping and removing old containers.
- Logs progress and exits on errors to ensure safe execution.

## Usage
1. Make the script executable:
   ```bash
   chmod +x secure_deploy.sh
   ```
2. Run the script from the project root: `sudo ./secure_deploy.sh`

# Requirements

- Linux or UNIX-based system
- Bash shell
- Docker installed and running
- Python 3
- Nginx installed
- OpenSSL installed
- Git installed (optional if tracking changes)

## Notes

- Adjust paths, Docker image names, and ports as needed for your environment.
- Designed for automated, repeatable deployments with minimal manual intervention.
- Exits immediately on error (set -e) to avoid partial or inconsistent deployments.
