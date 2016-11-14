#!/bin/bash
npm -g outdated | tail -n +2 | while read name current wanted latest therest; do
    echo "$name" "$current" "$latest"
done