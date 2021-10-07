#!/bin/bash

# Run each service up script
SCRIPT=$(sudo find services -iname service_up.sh)
for line in $(echo "$SCRIPT"); do
    echo ">> $line <<"
    DIR=$(echo "$line" | sed -e "s|/service_up.sh||g")
    cd "$DIR"
    ./service_up.sh
    cd ../..
done