// Autogenerated from Pigeon (v17.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// volume Key enums
enum VolumeKey: Int {
  case up = 0
  case down = 1
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol VolumeKeyBoardInterface {
  func addListener(completion: @escaping (Result<Void, Error>) -> Void)
  func removeListener(completion: @escaping (Result<Void, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class VolumeKeyBoardInterfaceSetup {
  /// The codec used by VolumeKeyBoardInterface.
  /// Sets up an instance of `VolumeKeyBoardInterface` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: VolumeKeyBoardInterface?) {
    let addListenerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volume_key_board.VolumeKeyBoardInterface.addListener", binaryMessenger: binaryMessenger)
    if let api = api {
      addListenerChannel.setMessageHandler { _, reply in
        api.addListener { result in
          switch result {
          case .success:
            reply(wrapResult(nil))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      addListenerChannel.setMessageHandler(nil)
    }
    let removeListenerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.volume_key_board.VolumeKeyBoardInterface.removeListener", binaryMessenger: binaryMessenger)
    if let api = api {
      removeListenerChannel.setMessageHandler { _, reply in
        api.removeListener { result in
          switch result {
          case .success:
            reply(wrapResult(nil))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      removeListenerChannel.setMessageHandler(nil)
    }
  }
}
