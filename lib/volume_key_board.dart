import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:volume_key_board/src/messages.g.dart';

export 'package:volume_key_board/src/messages.g.dart' show VolumeKey;

class VolumeKeyBoard {
  static const EventChannel _volumeEventChannel =
      EventChannel('volume_key_board/volume_event');
  final VolumeKeyBoardInterface _volumeKeyBoardInterface =
      VolumeKeyBoardInterface();

  VolumeKeyBoard._();

  static VolumeKeyBoard get instance => VolumeKeyBoard._();

  /// Volume Listener Subscription
  StreamSubscription<VolumeKey>? _volumeListener;

  /// Use android because android is called twice.
  int _volumePressIdx = 0;

  /// Used to monitor android volume button presses
  Function(VolumeKey value)? _volumeCallBack;

  /// This method listen to the system volume. The volume value will be generated when the volume was changed.
  Future<void> addListener(Function(VolumeKey value)? onData) async {
    if (null != _volumeListener) {
      removeListener();
    }
    if (Platform.isIOS) {
      await _volumeKeyBoardInterface.addListener();
      _volumeListener =
          _volumeEventChannel.receiveBroadcastStream().map((event) {
        return VolumeKey.values[event as int];
      }).listen(onData);
    } else if (Platform.isAndroid) {
      _volumeCallBack = onData;
      HardwareKeyboard.instance.addHandler(_androidVolumeKey);
    }
  }

  /// This method for canceling volume listener
  Future<void> removeListener() async {
    if (Platform.isIOS) {
      await _volumeListener?.cancel();
      await _volumeKeyBoardInterface.removeListener();
      _volumeListener = null;
    } else if (Platform.isAndroid) {
      HardwareKeyboard.instance.removeHandler(_androidVolumeKey);
      _volumeCallBack = null;
    }
  }

  bool _androidVolumeKey(KeyEvent event) {
    if (PhysicalKeyboardKey.audioVolumeUp == event.physicalKey ||
        PhysicalKeyboardKey.audioVolumeDown == event.physicalKey) {
      if (0 == _volumePressIdx % 2) {
        _volumePressIdx++;
        _volumeCallBack?.call(
            PhysicalKeyboardKey.audioVolumeUp == event.physicalKey
                ? VolumeKey.up
                : VolumeKey.down);
      } else {
        _volumePressIdx--;
      }
      return true;
    }
    return false;
  }
}
