#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Variables
MEILISEARCH_BINARY_URL="https://github.com/meilisearch/meilisearch/releases/latest/download/meilisearch-linux-amd64"
INSTALL_PATH="/usr/local/bin/meilisearch"
DATABASE_PATH="/var/lib/meilisearch"
CONFIG_PATH="/etc/meilisearch"
USER="meilisearch"

# Step 1: Download and install the Meilisearch binary
echo "Downloading Meilisearch binary..."
curl -L $MEILISEARCH_BINARY_URL -o $INSTALL_PATH
if [ $? -ne 0 ]; then
  echo "Failed to download Meilisearch binary. Exiting."
  exit 1
fi

# Step 1: Download and install the Meilisearch binary
echo "Downloading Meilisearch binary..."
curl -L $MEILISEARCH_BINARY_URL -o $INSTALL_PATH
if [ $? -ne 0 ]; then
  echo "Failed to download Meilisearch binary. Exiting."
  exit 1
fi

echo "Setting executable permissions for Meilisearch binary..."
chmod 755 $INSTALL_PATH

# Step 2: Create the Meilisearch service account
echo "Creating service account '$USER'..."
if ! id -u $USER >/dev/null 2>&1; then
  useradd --system --no-create-home --shell /usr/sbin/nologin $USER
  echo "Service account '$USER' created successfully."
else
  echo "Service account '$USER' already exists."
fi

# Step 3: Create the database folder
echo "Creating database folder at '$DATABASE_PATH'..."
mkdir -p $DATABASE_PATH
chown $USER:$USER $DATABASE_PATH
chmod 755 $DATABASE_PATH
echo "Database folder set up successfully."

# Step 4: Move configuration file to etc/meilisearch
echo "Creating configuration folder at '$CONFIG_PATH'..."
mkdir -p $CONFIG_PATH
chown $USER:$USER $CONFIG_PATH
chmod 755 $CONFIG_PATH
cp config-files/config.toml $CONFIG_PATH
echo "Configuration folder set up successfully."

# Step 5: Setup system service
echo "Creating system service for meilisearch..."
cp  config-files/meilisearch.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable meilisearch
systemctl start meilisearch

# Step 6
chmod 755 configure-scripts/*.sh
chmod 755 maintenance-scripts/*.sh

# Step 7
cp config-files/meilisearch.location /etc/nginx/sites-enabled/

echo "Installation complete!"