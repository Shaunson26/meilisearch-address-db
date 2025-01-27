#!/usr/bin/bash

# Relative to project directory
FILE="data/street-suffix-forms.json"

if [[ ! -f "$FILE" ]]; then
  echo "Error: File $FILE not found!"
  exit 1  # Exit the script if file is not found
fi

source "config-files/config-variables.env"

echo $MEILI_HTTP_ADDR
  
