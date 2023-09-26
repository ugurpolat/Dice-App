//
//  BoardViewController.swift
//  Roll In
//
//  Created by Ugur Polat on 24.09.2023.
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var segmentContoller: UISegmentedControl!
    @IBOutlet weak var diceImg_1: UIImageView!
    @IBOutlet weak var diceImg_2: UIImageView!
    @IBOutlet weak var playerLbl: UILabel!
    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var gameDice_1: UIImageView!
    @IBOutlet weak var gamePlayerLbl: UILabel!
    @IBOutlet weak var gameDice_2: UIImageView!
    var player = Player()
    var timer = Timer()
    let delay = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeImageRadius(image: self.diceImg_1)
        makeImageRadius(image: self.diceImg_2)
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        player.playSound(soundTitle: "shakeDice")
    }
    
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            viewRound.isHidden = false
            gameView.isHidden = true
            playerLbl.text = "Player"
        }
    }
    
    @IBAction func rollButtonClicked(_ sender: UIButton) {
        
        player.playSound(soundTitle: "shakeDice")
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
            sender.alpha = 1.0
            let randomDice_1 = self.diceRoll()
            let randomDice_2 = self.diceRoll()
            
            self.diceImg_1.image = self.diceRoll(number: randomDice_1)
            self.diceImg_2.image = self.diceRoll(number: randomDice_2)
            
            let result = (randomDice_1 > randomDice_2) ?  "Player-1" : "Player-2"
            self.playerLbl.text = result
            
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: self.delay, target: self, selector: #selector(self.delayedAction), userInfo: nil, repeats: false)
        }
        
        
        
    }
    
    @IBAction func butonRollGameClicked(_ sender: UIButton) {
        
        player.playSound(soundTitle: "shakeDice")
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.15) {
            sender.alpha = 1.0
            let randomDice_1 = self.diceRoll()
            let randomDice_2 = self.diceRoll()
            
            self.gameDice_1.image = self.diceRoll(number: randomDice_1)
            self.gameDice_2.image = self.diceRoll(number: randomDice_2)
            
            let result = (self.gamePlayerLbl.text == "Player-1") ?  "Player-2" :  "Player-1"
            
            self.gamePlayerLbl.text = result
        }
        
    }
    
    @objc func delayedAction() {
        segmentContoller.selectedSegmentIndex = 1
        gamePlayerLbl.text = playerLbl.text
        viewRound.isHidden = true
        gameView.isHidden = false
    }
    
    func makeImageRadius(image : UIImageView) {
        image.layoutIfNeeded()
        image.layer.cornerRadius = image.frame.height / 10.0
        image.layer.masksToBounds = true
    }
    
    func diceRoll()->Int {
        let randomNumber = Int.random(in: 1..<7)
        return randomNumber
    }
    
    func diceRoll(number : Int)->UIImage {
        let diceImg = UIImage(named: "dice-\(number)")
        return diceImg!
    }
    
}

