#!/usr/bin/env bash

TOTAL=$(python google.py     \
        | grep sessions      \
        | awk '{ print $2 }' \
        | python -c "import sys; print(sum(int(l) for l in sys.stdin))")

curl -g -X PUT -H "Authorization: bearer $WRIKE_TOKEN"     \
               -d "description=Developers Touched: $TOTAL" \
                  "https://www.wrike.com/api/v3/tasks/IEAA3JYPKQFTCENH"
