#! /usr/bin/env bash

# Store the UID and GID in a sourceable env file for later usep
echo -e "OUTPUT_UID=$OUTPUT_UID\nOUTPUT_GID=$OUTPUT_GID" > /tmp/env

# Watch for scanner button presses
scanbd -d2 -f
