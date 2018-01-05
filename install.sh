#!/usr/bin/env bash

# Check what system we're running on.
if [ "$(uname)" == "Darwin" ]; then
  echo "Detected operating system: macOS"
  install/macos.sh
  install/common.sh
fi

if [ "$(uname)" == "Linux" ]; then
  echo "Detected operating system: Linux"
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Detected Linux distribution: $NAME $VERSION_ID"
    if [ "$NAME" == "Ubuntu" ]; then
      install/ubuntu.sh
      install/common.sh
    else
      echo "ERROR: Your Linux distribution is not supported. Installation aborted." >&2
    fi
  else
    echo -e "ERROR: Could not determine Linux distribution. Installation aborted." >&2
  fi
fi
