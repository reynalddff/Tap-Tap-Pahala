//
//  TapTapManager.swift
//  Tap Tap Pahala
//
//  Created by Reynald Daffa Pahlevi on 04/05/21.
//

import Foundation
import AVFoundation

struct TapTapManager {
    var numberCounter = 0
    var isVibrate = true
    var isSound = true
    var player: AVAudioPlayer?
    
    let defaults = UserDefaults.standard
    
    mutating func increaseNumberCounter () {
        if isVibrate { tapWithVibrate() }
        if isSound { playSound() }
        
        numberCounter += 1
        defaults.set(numberCounter, forKey: "counter")
    }
    
    mutating func decreaseNumberCounter() {
        if numberCounter > 0 {
            numberCounter -= 1
            defaults.set(numberCounter, forKey: "counter")
        }
    }
    
    mutating func resetNumberConter () {
        self.numberCounter = 0
        self.defaults.set(self.numberCounter, forKey: "counter")
    }
    
    func tapWithVibrate() {
        HapticManagers.shared.vibrate(for: .success)
    }
    
    mutating func playSound() {
        let url = Bundle.main.url(forResource: "tap tap", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
