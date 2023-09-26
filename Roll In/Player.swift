//
//  Player.swift
//  Roll In
//
//  Created by Ugur Polat on 26.09.2023.
//

import Foundation
import AVFoundation

class Player {
    var player : AVAudioPlayer!
    
    func playSound(soundTitle:String) {
        let url = Bundle.main.url(forResource: soundTitle, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
