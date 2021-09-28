#!/bin/bash

# Run each service down script
DOWN=$(find services -iname service_down.sh)
for line in $(echo "$DOWN"); do
    echo ">> $line <<"
    ./$line
done