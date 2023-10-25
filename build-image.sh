#!/bin/bash

# ----------------------------------------
# Script Name:        Build Docker Image
# Description:        This script is designed to build a Docker image with
#                     specified configurations and error-handling mechanisms.
# Author:             TheScriptGuy (https://github.com/TheScriptGuy)
# Date last modified: 2023-10-25
# Version:            1.1
# ----------------------------------------

# Variables
REPOSITORY=""
IMAGE_TAG_NAME="generate-url-requests"
IMAGE_TAG_VERSION="1.0"

# -----------------
# DO NOT EDIT BELOW
# -----------------

# Check the REPOSITORY variable and set the IMAGE_TAG accordingly
if [ "$REPOSITORY" == "" ]; then
    IMAGE_TAG="$IMAGE_TAG_NAME:$IMAGE_TAG_VERSION"
else
    IMAGE_TAG="$REPOSITORY/$IMAGE_TAG_NAME:$IMAGE_TAG_VERSION"
fi

# Display the IMAGE_TAG
echo "Image tag is set to: $IMAGE_TAG"

# Check if the 'certs' directory exists
if [ ! -d "certs" ]; then
    echo "Error: certs directory does not exist."
    exit 1
fi

# Check if there are any *.crt files in the 'certs' directory
CERT_FILES=$(find certs -type f \( -name "*.crt" -o -name "*.pem" \) | wc -l)
if [ "$CERT_FILES" -eq 0 ]; then
    echo "Error: No *.crt or *.pem files found in the certs directory."
    exit 1
fi

# Check if the Dockerfile exists
if [ ! -f Dockerfile ]; then
    echo "Error: Dockerfile does not exist."
    exit 1
fi

# Build the docker image
docker build --no-cache -t $IMAGE_TAG -f Dockerfile .
