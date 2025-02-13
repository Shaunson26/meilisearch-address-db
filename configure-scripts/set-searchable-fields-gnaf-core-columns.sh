#!/usr/bin/bash

source "config-variables.env"

# Limit searchable fields
curl \
  -X PUT "http://$MEILI_HTTP_ADDR/indexes/addresses2/settings/searchable-attributes" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $MEILI_MASTER_KEY" \
  --data-binary '[
"ADDRESS_SITE_NAME",
"BUILDING_NAME",
"FLAT_TYPE",
"FLAT_NUMBER",
"LEVEL_TYPE",
"LEVEL_NUMBER",
"NUMBER_FIRST",
"NUMBER_LAST",
"LOT_NUMBER",
"STREET_NAME",
"STREET_TYPE",
"STREET_SUFFIX",
"LOCALITY_NAME",
"STATE",
"POSTCODE"
	]'

echo ""
