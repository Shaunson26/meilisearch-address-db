#!/usr/bin/bash
source "config-files/config-variables.env"
curl \
  -X GET "http://$MEILI_HTTP_ADDR/tasks" \
  -H "Authorization: Bearer $MEILI_MASTER_KEY"
echo ""
