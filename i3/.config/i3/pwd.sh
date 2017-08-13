#!/bin/sh

WHEREAMI=$(cat /tmp/whereami)

termite -d "$WHEREAMI"
