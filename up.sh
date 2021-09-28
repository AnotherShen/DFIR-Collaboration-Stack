#!/bin/bash

# Run each service up script
UP=$(find services -iname service_up.sh)
for line in $(echo "$UP"); do
    echo ">> $line <<"
    ./$line
done