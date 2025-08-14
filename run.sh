#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir $SCRIPT_DIR/_outputs

# -y auto accepts overwriting the file
# Im not sure what framerate & video size to use yet
# Not sure what the 1.25x thingy means in the output
ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 $SCRIPT_DIR/_outputs/output.mkv -y
