#!/bin/bash
set -e

echo "=== Paperclip Render Deploy ==="
echo "HOST=$HOST"
echo "PORT=$PORT"

# Run migrations
echo "=== Running migrations ==="
cd packages/db
npx drizzle-kit migrate
cd ../..

# Start server with tsx loader for workspace packages
echo "=== Starting server ==="
cd server

# Use tsx with explicit loader for TypeScript
exec npx tsx --loader tsx src/index.ts
