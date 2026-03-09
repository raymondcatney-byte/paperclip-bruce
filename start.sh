#!/bin/bash
set -e

echo "=== Starting Paperclip on Render ==="
echo "HOST=$HOST"
echo "PORT=$PORT"

# Create config directory
mkdir -p /opt/render/.paperclip/instances/default

# Create config.json with proper host
cat > /opt/render/.paperclip/instances/default/config.json << 'EOF'
{
  "$meta": {
    "version": 1,
    "updatedAt": "2026-03-09T00:00:00Z",
    "source": "onboard"
  },
  "database": {
    "mode": "postgres"
  },
  "server": {
    "deploymentMode": "local_trusted",
    "exposure": "private",
    "host": "0.0.0.0",
    "port": 10000
  },
  "logging": {
    "mode": "file"
  }
}
EOF

echo "=== Config created ==="
cat /opt/render/.paperclip/instances/default/config.json

# Run migrations
echo "=== Running database migrations ==="
cd packages/db
npx drizzle-kit migrate
cd ../..

# Start server with explicit env vars and capture output
echo "=== Starting server ==="
export HOST=0.0.0.0
export PORT=10000
export NODE_ENV=production
cd server

# Run with unbuffered output and capture errors
exec npx tsx src/index.ts 2>&1
