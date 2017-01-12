#!/bin/bash
brew outdated --verbose | while read name therest; do
    current=$(echo $therest | grep -o "[0-9.]*)")
    latest=$(echo $therest | grep -o "[0-9.]*$")
    current=${current#"("}
    current=${current%")"}
    echo "$name" "$current" "$latest"
done
