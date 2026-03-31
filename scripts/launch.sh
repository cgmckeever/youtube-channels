#!/bin/bash

cd "$(dirname "$0")/.."

if [ ! -f config/config.js ]; then
  echo "config/config.js not found. Run ./scripts/setup.sh first."
  exit 1
fi

python3 -m http.server 8080 &
SERVER_PID=$!

echo "Server running on http://localhost:8080 (PID: $SERVER_PID)"
open http://localhost:8080

trap "kill $SERVER_PID 2>/dev/null" EXIT
wait $SERVER_PID
