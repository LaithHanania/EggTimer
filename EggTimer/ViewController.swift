//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var counter : Int? = nil
    var timer = Timer()
    var hardness = "Soft"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        titleLabel.text = "How do you like your eggs?"
        hardness = sender.currentTitle!
        counter = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if counter! > 0 {
            progress.progress = Float(1 - (Double(counter!) / Double(eggTimes[hardness]!)))
            print("\(counter!) seconds to the end of the world")
            counter! -= 1
        } else {
            timer.invalidate()
            titleLabel.text = "Done"
            progress.progress = 1
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
            player = try! AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player!.play()

        }
    }
    

}
