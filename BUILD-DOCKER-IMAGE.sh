#!/bin/bash

################################################################################

# Set the Docker IMAGE name from a project name (first argument).
# If no argument is given, use the current user name as the project name.
if [ ! -z $PROJECT_NAME ]; then
  PROJECT=$PROJECT_NAME
  IMAGE="${PROJECT}_paligemma"
elif [ ! -z $1 ]; then
  PROJECT=$1
  IMAGE="${PROJECT}_paligemma"
else 
  PROJECT="common"
  IMAGE="${PROJECT}_paligemma"
fi
export HOSTNAME=$(hostname)
export IMAGE=$IMAGE # Export the IMAGE name for docker compose to coherently set IMAGE name.
echo "$0: PROJECT=${PROJECT}"
echo "$0: IMAGE=${IMAGE}"


# If image with the same name exists, exit.
EXISTING_IMAGE_ID=`docker images -q ${IMAGE}`
if [ ! -z "${EXISTING_IMAGE_ID}" ]; then
  echo "The image name ${IMAGE} already in use. Use the existig image or create another image with different name if needed." 1>&2
  echo ${EXISTING_IMAGE_ID}
  exit 1
fi

################################################################################

# Build the Docker image with the Nvidia GL library.
echo "starting build"
docker-compose -p ${PROJECT} -f ./docker/docker-compose.yml build