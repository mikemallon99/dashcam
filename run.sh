#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

git pull

mkdir _outputs

# -y auto accepts overwriting the file
# Im not sure what framerate & video size to use yet
# Not sure what the 1.25x thingy means in the output
# ffmpeg -f v4l2 -framerate 15 -video_size 640x480 -i /dev/video0 -b:v 1M _outputs/output.mkv -y

# this seems to work the best for now, minimizes cpu usage cuz were not doing any re-encoding
ffmpeg -f v4l2 -input_format mjpeg -video_size 1280x720 -framerate 30 \
  -i /dev/video0 \
  -c:v copy -f matroska _outputs/output.mkv -y

