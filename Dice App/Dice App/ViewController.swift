//
//  ViewController.swift
//  Dice App
//
//  Created by Ugur Polat on 27.09.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var dices: [UIImageView]!
    @IBOutlet weak var rollButton: UIButton!
    var player:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rollButton.layer.cornerRadius = 20;
    }
    
    @IBAction func clickedRoll(_ sender: Any) {
        dices[0].image = UIImage(named: "dice-\(randomNumber())");
        dices[1].image = UIImage(named: "dice-\(randomNumber())");
        playSound()
    }
    
    func randomNumber() -> (Int) {
        let diceNumber:Int = Int.random(in: 1..<7)
        
        return diceNumber;
    }
    
    func playSound(){
            let url = Bundle.main.url(forResource: "dice-rolling-on-table", withExtension: "wav")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    
    
    
}

