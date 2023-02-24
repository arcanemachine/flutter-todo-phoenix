#!/bin/bash

# This script syncs the project to a remote directory. It is intended to allow
# development to occur on Linux while syncing to a Samba share that is
# accessible to macOS. It fixes an issue caused when each platform tries to
# install its own copy of the Dart dependencies when running `flutter pub get`.

# change to project root directory
cd $(dirname "$0")/../

# set remote directory
remote_directory="/mnt/samba-shares/flutter_todo_phoenix"

# use entr to watch for changes in the local directory and sync them to the
# remote directory
until ag -l --hidden | entr -d rsync -avu --delete "." $remote_directory --exclude 'build/*' --exclude '.dart_tool/*' --exclude 'ios/*'; do sleep 1; done
