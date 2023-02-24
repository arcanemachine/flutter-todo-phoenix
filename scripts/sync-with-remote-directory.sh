#!/bin/bash

# This script syncs the project to a remote directory. It is intended to allow
# development to occur on Linux while syncing to a Samba share that is
# accessible to macOS. It fixes an issue caused when each platform tries to
# install its own copy of the Dart dependencies when running `flutter pub get`.

# change to project root directory
cd $(dirname "$0")/../

# set remote directory
remote_directory="/mnt/samba-shares/flutter_todo_phoenix"

if [ "$1" != "" ]; then
  # set custom remote directory using first positional argument
  $remote_directory="$1"
fi

# use entr to watch for changes in the local directory and sync them to the
# remote directory
until find . | entr -d rsync -avu --delete "." $remote_directory --exclude 'build/*' --exclude '.dart_tool/*' --exclude '.flutter-plugins/*' --exclude '.flutter-plugins-dependencies/*'; do sleep 1; done
