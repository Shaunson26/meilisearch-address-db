#!/usr/bin/bash

source "config-files/config-variables.env"

# Get searchable fields
curl \
  -X GET "http://$MEILI_HTTP_ADDR/indexes/addresses/settings/searchable-attributes" \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" 

echo ""