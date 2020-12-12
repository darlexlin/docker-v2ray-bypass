#!/bin/bash
/usr/bin/v2ray -config /etc/v2ray/config.json
echo "--- v2ray started ---"
tail -f /dev/null
