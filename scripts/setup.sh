#!/bin/bash

CONFIG_DIR="$(dirname "$0")/../config"

# Find client secret JSON
CLIENT_JSON=$(ls "$CONFIG_DIR"/client_secret_*.json 2>/dev/null | head -1)

if [ -z "$CLIENT_JSON" ]; then
  echo "Error: No client_secret_*.json found in $CONFIG_DIR"
  echo "Download it from Google Cloud Console > Credentials > OAuth 2.0 Client ID"
  exit 1
fi

CLIENT_ID=$(python3 -c "import json; print(json.load(open('$CLIENT_JSON'))['web']['client_id'])")

echo "Found client ID: $CLIENT_ID"
echo
read -p "Enter your YouTube Data API key: " API_KEY

if [ -z "$API_KEY" ]; then
  echo "Error: API key is required"
  exit 1
fi

cat > "$CONFIG_DIR/config.js" <<EOF
const CONFIG = {
  apiKey: '${API_KEY}',
  clientId: '${CLIENT_ID}',
  defaultPlaybackSpeed: 2.0,
  openInBrowser: false,
};
EOF

echo
echo "config/config.js created successfully"
