#!/bin/bash
set -x  # Enable debug mode

echo "=== Server Wrapper ==="
echo "HOST=$HOST"
echo "PORT=$PORT"
echo "PWD=$PWD"

# Ensure we're in the server directory
cd /opt/render/project/src/server || exit 1

echo "=== Starting server with tsx ==="
exec npx tsx src/index.ts
