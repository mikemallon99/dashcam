#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

git pull

mkdir _outputs

# -y auto accepts overwriting the file
# Im not sure what framerate & video size to use yet
# Not sure what the 1.25x thingy means in the output
# ffmpeg -f v4l2 -framerate 15 -video_size 640x480 -i /dev/video0 -c:v h264_v4l2m2m -b:v 2M -c:a copy -vf format=yuv420p $SCRIPT_DIR/_outputs/output.mkv -y
ffmpeg -hide_banner \
  -f v4l2 -input_format yuyv422 -framerate 15 -video_size 640x480 -i /dev/video0 \
  -vf format=nv12 \
  -c:v h264_v4l2m2m -b:v 3M -pix_fmt yuv420p \
  _outputs/output.mkv -y

