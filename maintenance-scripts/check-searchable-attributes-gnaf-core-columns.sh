#!/usr/bin/bash

source "config-variables.env"

# Get searchable fields
curl \
  -X GET "http://$MEILI_HTTP_ADDR/indexes/addresses2/settings/searchable-attributes" \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" 

echo ""
