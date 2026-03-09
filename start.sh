#!/bin/bash

echo "=== Starting Paperclip on Render ==="
echo "HOST=$HOST"
echo "PORT=$PORT"

# Create config directory
mkdir -p /opt/render/.paperclip/instances/default

# Create config.json with proper host - use Render's hostname detection
RENDER_HOST="0.0.0.0"

# Check if we can detect the render host
if [ -n "$RENDER_EXTERNAL_HOSTNAME" ]; then
  echo "Detected RENDER_EXTERNAL_HOSTNAME: $RENDER_EXTERNAL_HOSTNAME"
fi

cat > /opt/render/.paperclip/instances/default/config.json << EOF
{
  "\$meta": {
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
    "port": 10000,
    "serveUi": false
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
cd packages/db && npx drizzle-kit migrate
cd ../..

# Start server with explicit env vars
echo "=== Starting server ==="
export HOST="0.0.0.0"
export PORT="10000"
export NODE_ENV="production"
export PAPERCLIP_MIGRATION_PROMPT="never"
export PAPERCLIP_OPEN_ON_LISTEN="false"

cd server

# Run server with full error output and don't exit on error
echo "Running: npx tsx src/index.ts"
npx tsx src/index.ts &
SERVER_PID=$!

# Wait a bit for server to start
echo "Waiting for server to start (PID: $SERVER_PID)..."
sleep 5

# Check if server is still running
if kill -0 $SERVER_PID 2>/dev/null; then
  echo "Server is running on PID $SERVER_PID"
  # Keep the script running
  wait $SERVER_PID
else
  echo "Server failed to start or exited quickly"
  wait $SERVER_PID
  EXIT_CODE=$?
  echo "Server exited with code: $EXIT_CODE"
  exit $EXIT_CODE
fi
