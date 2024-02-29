import Flutter
import UIKit

public class VolumeKeyBoardPlugin: NSObject, FlutterPlugin, VolumeKeyBoardInterface {
  
    private var volumeController: VolumeController?
    private var volumeListener: VolumeListener?
    private var volumeEventChannel: FlutterEventChannel
    
    init(_ registrar: FlutterPluginRegistrar) {
        volumeEventChannel = FlutterEventChannel(name: "volume_key_board/volume_event", binaryMessenger: registrar.messenger())
    }

    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = VolumeKeyBoardPlugin(registrar)
        VolumeKeyBoardInterfaceSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }
    
    func addListener(completion: @escaping (Result<Void, Error>) -> Void) {
        if nil == volumeController {
            volumeController = VolumeController()
            volumeListener = VolumeListener(volumeController: volumeController!)
        }
        volumeEventChannel.setStreamHandler(volumeListener)
        completion(.success(()));
    }
    
    func removeListener(completion: @escaping (Result<Void, Error>) -> Void) {
        volumeEventChannel.setStreamHandler(nil)
        volumeListener?.close()
        volumeListener = nil
        volumeController = nil
        completion(.success(()));
    }
}
