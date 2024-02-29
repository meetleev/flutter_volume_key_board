//
//  VolumeListener.swift
//  volume_key_board
//
//  Created by Lee on 2024/2/14.
//

import Foundation
import Flutter
import CoreAudioTypes

class VolumeListener : NSObject, FlutterStreamHandler {
    private let volumeController: VolumeController
    private var outputVolumeObservation: NSKeyValueObservation?
    private var lastVolume: Float = 0
    init(volumeController: VolumeController) {
        self.volumeController = volumeController
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        do {
            let initVolume = volumeController.audioSession.outputVolume;
            var needFix = fixVolume(initVolume);
            try volumeController.activateAudioSession()
            outputVolumeObservation = volumeController.audioSession.observe(\.outputVolume) { session, _ in
                let volume = session.outputVolume
//                print("outputVolume", volume)
                if (needFix) {
                    needFix = false
                    print("init fix volume call, then return")
                } else {
                    if 0 < volume && volume < 1 {
                        var volumeKey = VolumeKey.down
                        if 0 == self.lastVolume  {
                            volumeKey = VolumeKey.down
                        } else if 1 == self.lastVolume  {
                            volumeKey = VolumeKey.up
                        } else if self.lastVolume < volume {
                            volumeKey = VolumeKey.up
                        }
//                        print("emit volume", volume, volumeKey)
                        events(volumeKey.rawValue)
                    }
                }
                _ = self.fixVolume(volume)
                self.lastVolume = volume
            }
        } catch {
            return FlutterError(
                            code: "-1",
                            message:"Failed to register volume listener",
                            details: error.localizedDescription
                        )
        }
        return nil
    }
    
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        close()
        return nil
    }
    
    func close() {
        outputVolumeObservation = nil
        try? volumeController.deactivateAudioSession()
    }
    
    private func fixVolume(_ volume: Float) -> Bool {
        if 0 == volume || 1 == volume {
            volumeController.setVolume(0.5)
            return true
        }
        return false
    }
}
