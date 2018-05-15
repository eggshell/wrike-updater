#!/bin/bash

set -xe

TOTAL=$(python /root/deploy/scripts/google.py     \
        | grep sessions                           \
        | awk '{ print $2 }'                      \
        | python -c "import sys; print(sum(int(l) for l in sys.stdin))")

curl -g -X PUT -H "Authorization: bearer $WRIKE_TOKEN"     \
               -d "description=Developers Engaged: $TOTAL" \
                  "https://www.wrike.com/api/v3/tasks/$TASK_ID"
