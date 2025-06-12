#!/bin/bash

# Define variables for paths and remote details
REMOTE_USER="az24148"
REMOTE_HOST="bp1-login.acrc.bris.ac.uk"
REMOTE_PATH="/user/work/az24148/Abil/studies/lim2024"
TEMP_FOLDER="/tmp/Abil"
LOCAL_PATH="/mnt/c/users/az24148/Documents/PhD/Projects/Abil/Abil/studies/lim2024"

# Define an array of items to exclude
EXCLUDE_LIST=("data/env_data.nc")

# Create a clean temporary folder
mkdir -p $TEMP_FOLDER

# Construct rsync exclude arguments
EXCLUDE_ARGS=""
for EXCLUDE_ITEM in "${EXCLUDE_LIST[@]}"; do
    EXCLUDE_ARGS+="--exclude=$EXCLUDE_ITEM "
done

# Copy folder from the remote server to the temporary location, applying the exclusions
rsync -av --progress $EXCLUDE_ARGS $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/ $TEMP_FOLDER/

# Move the temporary folder's content to the local destination
rsync -av --progress $TEMP_FOLDER/ $LOCAL_PATH/

# If copy is successful, remove the temporary folder
if [ $? -eq 0 ]; then
    rm -rf $TEMP_FOLDER
    echo "Files successfully transferred and temporary folder removed."
else
    echo "File transfer failed. Temporary folder retained for debugging."
fi
