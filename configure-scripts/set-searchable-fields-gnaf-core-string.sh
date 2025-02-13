#!/usr/bin/bash

source "config-variables.env"

# Limit searchable fields
curl \
  -X PUT "http://$MEILI_HTTP_ADDR/indexes/addresses/settings/searchable-attributes" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary '[
	"ADDRESS_LABEL"
	]'

echo ""
