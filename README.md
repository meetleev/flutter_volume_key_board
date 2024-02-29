# volume_key_board

[![Pub](https://img.shields.io/pub/v/volume_key_board.svg?style=flat-square)](https://pub.dev/packages/volume_key_board)
[![support](https://img.shields.io/badge/platform-android%20|%20ios%20-blue.svg)](https://pub.dev/packages/volume_key_board)

A Flutter plugin to listen for volume key press events on Android and iOS platforms.

## Features

- Listen for volume up and volume down key press events.
- Works on both Android and iOS platforms.
- Android implemented with Dart natively.

## Installation

To use this plugin, add `volume_key_board` as a dependency in your `pubspec.yaml` file.

## Usage

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  volume_key_board: <latest_version>
```

```dart
import 'package:volume_key_board/volume_key_board.dart';

/// addListener
VolumeKeyBoard.instance.addListener(( event) {
    if (event == VolumeKey.up) {
    } else if (event == VolumeKey.down) {
    }
});

/// removeListener
VolumeKeyBoard.instance.removeListener();
```

