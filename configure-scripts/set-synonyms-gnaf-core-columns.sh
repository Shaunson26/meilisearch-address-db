#!/usr/bin/bash

FILE="data/street-suffix-forms.json"

if [[ ! -f $FILE ]]; then
  echo "Error: File $FILE not found!"
  exit 1  # Exit the script if file is not found
fi

source "config-variables.env"

curl \
  -X PUT "http://$MEILI_HTTP_ADDR/indexes/addresses2/settings/synonyms" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary @"$FILE"
  
echo ""
