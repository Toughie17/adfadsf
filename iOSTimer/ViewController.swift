//
//  ViewController.swift
//  iOSTimer
//
//  Created by KimChoonSik on 2023/02/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var ramyunButton: UIButton!
    @IBOutlet weak var plankButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    weak var timer: Timer?
    var number: Int = Int(Numbers.zero.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = Text.select.rawValue
        slider.setValue(Float(Numbers.sliderCenter.rawValue), animated: true)
        setButton()
    }
    
    func setButton() {
        ramyunButton.layer.cornerRadius = CGFloat(Numbers.buttonCornerRadius.rawValue)
        plankButton.layer.cornerRadius = CGFloat(Numbers.buttonCornerRadius.rawValue)
        startButton.layer.cornerRadius = CGFloat(Numbers.buttonCornerRadius.rawValue)
        resetButton.layer.cornerRadius = CGFloat(Numbers.buttonCornerRadius.rawValue)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        number = Int(sender.value * Numbers.maximumSecond.rawValue)
        mainLabel.text = String(number) + Text.seconds.rawValue
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(Int(Numbers.one.rawValue)), target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
    }
    
    @objc func doSomethingAfter1Second() {
        if number > Int(Numbers.zero.rawValue) {
            number -= Int(Numbers.one.rawValue)
            slider.value = Float(number) / Numbers.maximumSecond.rawValue
            mainLabel.text = "\(number) 초"
        } else {
            number = Int(Numbers.zero.rawValue)
            mainLabel.text = Text.select.rawValue
            
            timer?.invalidate()
            AudioServicesPlayAlertSound(SystemSoundID(UInt32(Numbers.sound.rawValue)))
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        configureUI()
        number = Int(Numbers.zero.rawValue)
        timer?.invalidate()
    }
    
    @IBAction func ramyunButtonTapped(_ sender: UIButton) {
        mainLabel.text = Text.ramyunText.rawValue
        number = Int(Numbers.ramyun.rawValue)
    }
    
    @IBAction func plankButtonTapped(_ sender: UIButton) {
        mainLabel.text = Text.plankText.rawValue
        number = Int(Numbers.plank.rawValue)
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        mainLabel.text = Text.stopText.rawValue + "\(number) 초"
        timer?.invalidate()
    }
}
