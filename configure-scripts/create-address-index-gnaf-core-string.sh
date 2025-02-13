#!/usr/bin/bash

source "config-variables.env"

curl \
  -X POST "http://$MEILI_HTTP_ADDR/indexes" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary '{
    "uid": "addresses",
    "primaryKey": "id"
  }'

echo ""
