#!/usr/bin/bash
source "config-variables.env"
curl -X GET "http://$MEILI_HTTP_ADDR/health"
echo ""
