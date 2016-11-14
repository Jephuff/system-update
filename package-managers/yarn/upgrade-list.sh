#!/bin/bash
yarn global ls --depth=0 2>/dev/null | grep "^info" | awk '{print($2)}' | tr "@" " " | while read name current therest; do
    if [[ $name != \"* ]]; then
        latest=$(yarn info $name | grep -o "latest: [^,]*\'" | grep -o "[0-9.]\{5,\}")
        if [ "$latest" != "" ]; then
            echo "$name" "$current" "$latest"
        fi
    fi
done
