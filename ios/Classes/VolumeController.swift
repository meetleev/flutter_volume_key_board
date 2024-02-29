//
//  VolumeController.swift
//  volume_key_board
//
//  Created by Lee on 2024/2/14.
//

import Foundation
import AVFoundation
import MediaPlayer

class VolumeController {
    private let volumeView: MPVolumeView = .init()
    let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    init () {
        showSystemUI(false)
    }
    
    func activateAudioSession() throws {
        try audioSession.setActive(true)
    }
    
    func deactivateAudioSession() throws {
        try audioSession.setActive(false)
    }
    
    func resumeAudioSession() throws {
        try activateAudioSession()
    }
    
    func showSystemUI(_ show: Bool) {
        if show {
            volumeView.removeFromSuperview()
        } else {
            volumeView.frame = CGRect(x: -1000, y: -1000, width: 1, height: 1)
            /*if #available(iOS 16, *) {
                volumeView.subviews.first(where: {$0 is UIButton})?.isHidden = true
            } else {
                volumeView.showsRouteButton = false
            }*/
            UIApplication.shared.delegate!.window!?.rootViewController?.view.addSubview(volumeView)
        }
    }
    
    func setVolume(_ volume: Double) {
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.async {
            slider?.value = Float(volume);
        }
    }
    
    func getVolume() -> Double {
        do {
            try activateAudioSession()
            return Double(audioSession.outputVolume)
        } catch {
        }
        return 0
    }
}
