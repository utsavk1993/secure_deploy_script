#!/bin/bash
# secure_deploy.sh
# Set up SSL, Nginx, and deploy Python service in Docker

set -e

# Step 1: Generate SSL certificate using OpenSSL if not exists
SSL_DIR="/etc/ssl/myservice"
mkdir -p $SSL_DIR
if [ ! -f "$SSL_DIR/myservice.crt" ]; then
    echo "Generating self-signed SSL certificate..."
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout $SSL_DIR/myservice.key \
        -out $SSL_DIR/myservice.crt \
        -subj "/C=US/ST=State/L=City/O=Company/OU=IT/CN=localhost"
fi

# Step 2: Configure Nginx with SSL
echo "Configuring Nginx..."
NGINX_CONF="/etc/nginx/sites-available/myservice"
cat > $NGINX_CONF <<EOL
server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate $SSL_DIR/myservice.crt;
    ssl_certificate_key $SSL_DIR/myservice.key;

    location / {
        proxy_pass http://127.0.0.1:8000;
    }
}
EOL

ln -sf $NGINX_CONF /etc/nginx/sites-enabled/myservice
nginx -s reload

# Step 3: Build and run Python service in Docker
echo "Deploying Python service..."
docker stop myservice || true
docker rm myservice || true
docker build -t python_service:latest .
docker run -d --name myservice -p 8000:8000 python_service:latest

echo "Secure deployment complete!"
