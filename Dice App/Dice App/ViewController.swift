//
//  ViewController.swift
//  Dice App
//
//  Created by Ugur Polat on 27.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dices: [UIImageView]!
    @IBOutlet weak var rollButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        rollButton.layer.cornerRadius = 20;
    }

    @IBAction func clickedRoll(_ sender: Any) {
        dices[0].image = UIImage(named: "dice-\(randomNumber())");
        dices[1].image = UIImage(named: "dice-\(randomNumber())");
    }
    
    func randomNumber() -> (Int) {
        let diceNumber:Int = Int.random(in: 1..<7)
        
        return diceNumber;
    }
}

