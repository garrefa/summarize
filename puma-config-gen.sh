#!/bin/bash

XCCONFIG_PATH="./Client/Configuration/PumaBrowserSecrets.xcconfig"
filename=$(basename $XCCONFIG_PATH)

if [[ -f $XCCONFIG_PATH ]];then
    echo "Error: $filename exists, delete before continuing"
    echo "file path: $XCCONFIG_PATH"
    exit 1
fi

echo "This script will a file for Puma Browser specific configs"
echo
echo "Enter your OPEN_AI_API_KEY:"
read -s apikey

echo "OPEN_AI_API_KEY = $apikey" >> $XCCONFIG_PATH 
echo "Config file created at: $XCCONFIG_PATH"

