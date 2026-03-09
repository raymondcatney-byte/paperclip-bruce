#!/bin/bash

echo "=== Paperclip Render Startup ==="
echo "HOST=$HOST"
echo "PORT=$PORT"
echo "PAPERCLIP_DEPLOYMENT_MODE=$PAPERCLIP_DEPLOYMENT_MODE"
echo "PAPERCLIP_DEPLOYMENT_EXPOSURE=$PAPERCLIP_DEPLOYMENT_EXPOSURE"

# Run migrations first
echo "=== Running migrations ==="
cd packages/db && npx drizzle-kit migrate
cd ../..

# Start server with all env vars set
echo "=== Starting server on 0.0.0.0:10000 ==="
cd server
export HOST=0.0.0.0
export PORT=10000
exec npx tsx src/index.ts
