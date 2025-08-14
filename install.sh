#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf $SCRIPT_DIR/dashcam.service /etc/systemd/system/dashcam.service
