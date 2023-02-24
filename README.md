# flutter_todo_phoenix

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Simultaneous Development on Linux and macOS (VM)

In my experience, the same directory cannot be used by both Linux and a macOS VM. Whichever OS runs `flutter pub get` messes it up for the other OS.

To fix this:
  - Use the `sync-with-remote-directory.sh` script in the `/scripts/` directory to create a mirror of this repo in a separate directory (the location of the remote directory is set by the script, you will probably want to override the default value).

  - Create a Samba share so that the directory can be accessed by the VM.
    - See the README in [my OSX-KVM helpers repo](https://github.com/arcanemachine/osx-kvm-stuff) for instructions on adding a Samba share and accessing it from macOS.
