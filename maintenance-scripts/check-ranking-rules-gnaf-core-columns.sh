#!/usr/bin/bash

source "config-variables.env"

curl \
  -X GET "http://$MEILI_HTTP_ADDR/indexes/addresses2/settings/ranking-rules" \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" 

echo ""
