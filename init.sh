#!/bin/bash

if [ ! -f "server/server_linux" ]; then
    mkdir -p server

    # Get the latest version from GitHub API
    LATEST_RELEASE=$(curl -s https://api.github.com/repos/openhotel/openhotel/releases/latest)
    DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | grep -o "https://.*server_linux.zip" | head -n 1)
    VERSION=$(echo "$LATEST_RELEASE" | grep -o '"tag_name": "\([^"]*\)"' | cut -d'"' -f4)

    echo "Downloading OpenHotel Server version $VERSION..."

    curl -L -o server_linux.zip "$DOWNLOAD_URL"
    unzip server_linux.zip -d server
    rm server_linux.zip

    echo "Download completed! Server has been extracted to the server directory."

    # Give execution permissions to the server
    chmod +x server/server_linux
else
    echo "OpenHotel Server is already downloaded. Skipping download."
fi

# Replace environment variables in config.yml
envsubst < config.yml > server/config.yml

cd server && ./server_linux