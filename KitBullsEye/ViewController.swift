//
//  ViewController.swift
//  KitBullsEye
//
//  Created by Harei Waja on 6/9/20.
//  Copyright © 2020 Harei Waja. All rights reserved.

import UIKit

class ViewController: UIViewController {
    var targetValue = 0
    var currentValue = 0
    var score = 0
    var round = 1
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound() {
        currentValue = 50
        targetValue = Int.random(in: 1...100)
        slider.value = Float(currentValue)
        updateLabels()
        round += 1
    }
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
                         trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
                         trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        // Do any additional setup after loading the view.
        startNewGame()
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect Hit!"
            points += 100
        } else if difference < 5 {
            title = "Almost Had It"
            if difference == 1 {
               points += 50
            }
        }else if difference < 10 {
            title = "Pretty Close"
        }else {
            title = "Not Even Close"
        }
        score += points
        
        
        let message = "You scored: \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            _ in self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        
    }
}

