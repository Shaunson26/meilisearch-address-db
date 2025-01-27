#!/usr/bin/bash

FILE="data/address-columns-nsw-full.csv"

echo "Expecting files $FILE in this directory"
echo "Expecting field: id as the primaryKey"

if [[ ! -f $FILE ]]; then
  echo "Error: File $FILE not found!"
  exit 1  # Exit the script if file is not found
fi

source "config-files/config-variables.env"

curl \
  -X POST "http://$MEILI_HTTP_ADDR/indexes/addresses/documents?primaryKey=id" \
  -H 'Content-Type: text/csv' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary @"$FILE"

echo ""
