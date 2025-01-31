#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Variables
MEILISEARCH_BINARY_URL="https://github.com/meilisearch/meilisearch/releases/latest/download/meilisearch-linux-amd64"
INSTALL_FILE="/usr/local/bin/meilisearch"
DATABASE_PATH="/var/lib/meilisearch"
CONFIG_PATH="/etc/meilisearch"
USER="meilisearch"
SERVICE_FILE="/etc/systemd/system/meilisearch.service"
NGINX_LOCATION="/etc/nginx/sites-enabled/meilisearch.location"
LOG_FILE="/var/log/meilisearch.log"
DATETIME=$(date -d "2013-04-06" "+%s%N" | cut -b1-13)

# Step 1: Stop and remove service
echo "Stopping Meilisearch service"
systemctl stop meilisearch
systemctl disable meilisearch
rm $SERVICE_FILE
if test -f "$SERVICE_FILE"; then
    echo "$SERVICE_FILE not removed ... please check"
fi

systemctl daemon-reload
systemctl reset-failed

if test -d "$LOG_FILE"; then
  LOG_FILE_NEW="/var/log/meilisearch-$DATETIME.log"
  mv $LOG_FILE $LOG_FILE_NEW
  echo "Previous logfile copied to $LOG_FILE_NEW"
fi


# Step 2: Remove the Meilisearch service account
echo "Removing service account '$USER'..."
killall -u $USER
userdel $USER
#cut -d: -f1 /etc/passwd | grep 'meilisearch'
#groupdel $USER

# Step 3: Create the database folder
echo "Removing database folder at '$DATABASE_PATH'..."
rm -r $DATABASE_PATH
if test -d "$DATABASE_PATH"; then
    echo "$DATABASE_PATH not removed ... please check"
fi


# Step 4: Remove configuration file to etc/meilisearch
echo "Removing configuration folder at '$CONFIG_PATH'..."
rm -r $CONFIG_PATH
if test -d "$CONFIG_PATH"; then
    echo "$CONFIG_PATH not removed ... please check"
fi

# Step 5: Remove binary system service
echo "Removing binary at '$INSTALL_FILE'..."
rm $INSTALL_FILE
if test -f "$INSTALL_FILE"; then
    echo "$INSTALL_FILE not removed ... please check"
fi

## Step 6: Remove nginx location
echo "Removing Nginx location at '$NGINX_LOCATION'..."
rm $NGINX_LOCATION
if test -f "$NGINX_LOCATION"; then
    echo "$NGINX_LOCATION not removed ... please check"
fi

systemctl restart nginx

echo "Unistallation complete!"
