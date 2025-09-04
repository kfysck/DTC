#!/bin/bash

DIR="./"

find "$DIR" -type f \( -name "*.h" -o -name "*.cc" -o -name "*.c" \) | while read -r file; do
    if grep -qP '[\x{4e00}-\x{9fff}]' "$file" 2>/dev/null; then
        echo "==== $file ===="
        grep -nP '[\x{4e00}-\x{9fff}]' "$file" 2>/dev/null
        echo
    fi
done

