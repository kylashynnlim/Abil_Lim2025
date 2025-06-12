#!/bin/bash

# Define variables for paths and remote details
LOCAL_PATH="/mnt/c/users/az24148/Documents/PhD/Projects/Abil/Abil/studies/lim2024"
TEMP_FOLDER="/tmp/Abil"

REMOTE_USER="az24148"
REMOTE_HOST="bp1-login.acrc.bris.ac.uk"
REMOTE_PATH="/user/work/az24148/Abil/studies/lim2024"

# Define an array of items to exclude
EXCLUDE_LIST=(
    "data/env_data.nc"
    "posts/") 

# Create a clean temporary folder
mkdir -p $TEMP_FOLDER

# Construct rsync exclude arguments
EXCLUDE_ARGS=""
for EXCLUDE_ITEM in "${EXCLUDE_LIST[@]}"; do
    EXCLUDE_ARGS+="--exclude=$EXCLUDE_ITEM "
done

# Copy folder to the temporary location, applying the exclusions
rsync -av --progress $EXCLUDE_ARGS $LOCAL_PATH/ $TEMP_FOLDER/

# Copy the temporary folder to the remote server
scp -r $TEMP_FOLDER/ $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

# If copy is successful, remove the temporary folder
if [ $? -eq 0 ]; then
    rm -rf $TEMP_FOLDER
    echo "Files successfully transferred and temporary folder removed."
else
    echo "File transfer failed. Temporary folder retained for debugging."
fi
