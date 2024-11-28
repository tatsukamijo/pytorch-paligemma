#!/bin/bash

# Set the Docker container name from a project name (first argument).
# If no argument is given, use the current user name as the project name.
if [ ! -z "$PROJECT_NAME" ]; then
  PROJECT=$PROJECT_NAME
elif [ ! -z "$1" ]; then
  PROJECT=$1
else 
  PROJECT="common"
fi
export PROJECT  # Ensure this is exported for Docker Compose to pick it up
CONTAINER="${PROJECT}_paligemma"
export CONTAINER # Export the container name for docker compose to coherently set container name.
echo "$0: PROJECT=${PROJECT}"
echo "$0: CONTAINER=${CONTAINER}"

# Check if the container is already running
if [ $(docker ps -q -f name=^${CONTAINER}$) ]; then
    echo "Container ${CONTAINER} is already running."
else
    echo "Starting container ${CONTAINER}."
    # Run the Docker container in the background.
    # Any changes made to './docker/docker-compose.yml' will recreate and overwrite the container.
    docker-compose -p ${PROJECT} -f ./docker/docker-compose.yml up -d
fi

# Display GUI through X Server by granting full access to any external client.
xhost +

# Enter the Docker container with a Bash shell.
docker exec -it ${CONTAINER} bash
