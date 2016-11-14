#!/bin/bash
pip list --outdated 2>/dev/null | while read name current dash text latest therest; do
    echo "$name" "$current" "$latest"
done