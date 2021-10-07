#!/bin/bash

# Run each service down script
SCRIPT=$(sudo find services -iname service_down.sh)
for line in $(echo "$SCRIPT"); do
    echo ">> $line <<"
    DIR=$(echo "$line" | sed -e "s|/service_down.sh||g")
    cd "$DIR"
    ./service_down.sh
    cd ../..
done