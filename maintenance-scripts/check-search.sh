#!/usr/bin/bash
source "config-files/config-variables.env"

curl \
  -X POST "http://$MEILI_HTTP_ADDR/indexes/addresses/search" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary '{ "q": "12 Durack Pl Casula", "limit": 5 }'
  
echo ""

