#!/bin/bash

# Run the influx setup command and capture any output and error
output=$(influx setup --host http://influxdb:8086 --bucket hypermarket --org InfluxData --password ArcPassword123!! --username admin --token secret-token --force 2>&1)

# If the command was successful, print the output and exit
if [ $? -eq 0 ]; then
    echo "$output"
    exit 0
fi

# If the command failed, check if it's because the instance is already set up
if echo "$output" | grep -q "Error: instance has already been set up"; then
    echo "InfluxDB is already set up."
    exit 0
else
    # If the command failed for any other reason, print the output and exit with a failure status
    echo "$output"
    exit 1
fi