#!/bin/bash
brew outdated --verbose | while read name current dir latest therest; do
    current=${current#"("}
    current=${current%")"}
    echo "$name" "$current" "$latest"
done
