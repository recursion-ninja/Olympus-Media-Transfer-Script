#!/bin/bash
#
# Copy files automatically from the camera
#
# configuration
DIRECTORY="/Users/${USER}/Media/Photo/Olympus-Camera"
IP=192.168.0.10
BASE_URL="http://${IP}/DCIM/100OLYMP"

# constants
MANIFEST="pictures.html"
DIR_IMAGE="Images"
DIR_VIDEO="Videos"

# Initialize the environment
set -e
cd "`dirname \"$0\"`"
mkdir -p "${DIRECTORY}/${DIR_IMAGE}"
mkdir -p "${DIRECTORY}/${DIR_VIDEO}"

if ! [ -d "${DIRECTORY}" ]; then
  echo "Cannot access share directory. Exiting."
  exit 1
fi

if ! ping -c 1 "${IP}"; then
  echo "Cannot reach ${IP}. Exiting."
  exit 2
fi

# Get directory contents containing the media manifest
wget --quiet -O "${MANIFEST}" "${BASE_URL}"

# enumerate image_names
image_names="`cat \"${MANIFEST}\" | grep -oE '[^, ]*\.JPG'`"
image_count=`echo "${image_names}" | wc -l`

video_names="`cat \"${MANIFEST}\" | grep -oE '[^, ]*\.MOV'`"
video_count=`echo "${video_names}" | wc -l`


# Transfer all images
printf "Located %d image(s) and %d videos for transfer." "${image_count}" "${video_count}"

counter=0
printf "Transfering images files:\n"
for img in ${image_names}; do
  ((counter++))
  printf "\t[%3d/%3d]: ${img} ... " "${counter}" "${image_count}"
  if wget --quiet --continue -O "${DIRECTORY}/${DIR_IMAGE}/${img}" "${BASE_URL}/${img}"; then
    printf "ok\n"
  else
    printf "fail\n"
  fi
done


# Transfer all videos
counter=0
printf "Transfering videos files:\n"
for vid in ${video_names}; do
  ((counter++))
  printf "\t[%3d/%3d]: ${vid} ... " "${counter}" "${video_count}"
  if wget --quiet --continue -O "${DIRECTORY}/${DIR_VIDEO}/${vid}" "${BASE_URL}/${vid}"; then
    printf "ok\n"
  else
    printf "fail\n"
  fi
done

printf "\nDone!\n"
