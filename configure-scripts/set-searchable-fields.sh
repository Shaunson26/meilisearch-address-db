#!/usr/bin/bash

source "config-files/config-variables.env"

# Limit searchable fields
curl \
  -X PUT "http://$MEILI_HTTP_ADDR/indexes/addresses/settings/searchable-attributes" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary '[
	"NUMBER_FIRST",
	"STREET_NAME",
	"LOCALITY_NAME",
	"POSTCODE"
	]'

echo ""
