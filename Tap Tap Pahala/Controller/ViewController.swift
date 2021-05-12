//
//  ViewController.swift
//  Tap Tap Pahala
//
//  Created by Reynald Daffa Pahlevi on 02/05/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var tapTapManager = TapTapManager()

    @IBOutlet weak var uiViewBackgroundGradient: UIView!
    @IBOutlet weak var buttonTapCounter: UIButton!
    @IBOutlet weak var textLabelWelcome: UILabel!
    
    @IBOutlet weak var uiMinusButton: UIButton!
    @IBOutlet weak var uiResetButton: UIButton!
    @IBOutlet weak var uiVibrateButton: UIButton!
    @IBOutlet weak var uiSoundButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientViewBackground()
        updateTextLabel()
        displayButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateTextLabelAfterRemoveAppBG()
    }
    
    func gradientViewBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let firstColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        let secondColor = UIColor(red: 91/255, green: 109/255, blue: 129/255, alpha: 1.0)
        
        gradientLayer.colors = [
            firstColor.cgColor,
            secondColor.cgColor
        ]
        
        uiViewBackgroundGradient.layer.addSublayer(gradientLayer)
    }
    
    func updateTextLabel() {
        if (tapTapManager.numberCounter == 0) {
            buttonTapCounter.setTitle("", for: .normal)
            textLabelWelcome.text = "Tap here to start dzhikir"
        }
        
        buttonTapCounter.setTitleColor(.white, for: .normal)
    }
    
    func updateTextLabelAfterRemoveAppBG() {
        tapTapManager.numberCounter = tapTapManager.defaults.integer(forKey: "counter")
        tapTapManager.isSound = tapTapManager.defaults.bool(forKey: "sound")
        tapTapManager.isVibrate = tapTapManager.defaults.bool(forKey: "vibrate")
        
        if tapTapManager.numberCounter == 0 {
            buttonTapCounter.setTitle("", for: .normal)
            textLabelWelcome.text = "Tap here to start dzhikir"
        } else {
            textLabelWelcome.isHidden = true
        }
        
        buttonTapCounter.setTitle(String(tapTapManager.numberCounter), for: .normal)
    }
    
    func displayButton() {
        uiMinusButton.buttonActionCustom(systemName: "minus", color: UIColor.white)
        uiResetButton.buttonActionCustom(systemName: "arrow.counterclockwise", color: UIColor.white)
        
        let vibrate = tapTapManager.defaults.bool(forKey: "vibrate")
        let sound = tapTapManager.defaults.bool(forKey: "sound")
        
        if vibrate {
            uiVibrateButton.buttonActionCustom(systemName: "iphone.radiowaves.left.and.right", color: UIColor.systemYellow)
        } else if !vibrate {
            uiVibrateButton.buttonActionCustom(systemName: "iphone.radiowaves.left.and.right", color: UIColor.white)        }
        
        if sound {
            uiSoundButton.buttonActionCustom(systemName: "speaker", color: UIColor.systemYellow)
        } else if !sound {
            uiSoundButton.buttonActionCustom(systemName: "speaker", color: UIColor.white)
        }
    }

//    counter + 1
    @IBAction func pressedCounterButton(_ sender: UIButton) {
        textLabelWelcome.isHidden = true
        
        tapTapManager.increaseNumberCounter()
        
        buttonTapCounter.setTitle(String(tapTapManager.numberCounter), for: .normal)
        buttonTapCounter.titleLabel?.font = .systemFont(ofSize: 48, weight: .semibold)
    }
    
//    reset counter = 0
    @IBAction func pressedResetButton(_ sender: UIButton) {
        if tapTapManager.numberCounter > 0 {
            showActionSheet()
        }
    }
    
//    decrease counter dhikir
    @IBAction func pressedDecreaseButton(_ sender: UIButton) {
        tapTapManager.decreaseNumberCounter()
        buttonTapCounter.setTitle(String(tapTapManager.numberCounter), for: .normal)
        buttonTapCounter.titleLabel?.font = .systemFont(ofSize: 48, weight: .semibold)
    }
    
    @IBAction func pressedBtnVibrate(_ sender: UIButton) {
        if tapTapManager.isVibrate {
            uiVibrateButton.buttonActionCustom(systemName: "iphone.radiowaves.left.and.right", color: UIColor.white)
            tapTapManager.isVibrate = false
            tapTapManager.defaults.set(tapTapManager.isVibrate, forKey: "vibrate")
        } else if !tapTapManager.isVibrate {
            uiVibrateButton.buttonActionCustom(systemName: "iphone.radiowaves.left.and.right", color: UIColor.systemYellow)
            tapTapManager.isVibrate = true
            tapTapManager.defaults.set(tapTapManager.isVibrate, forKey: "vibrate")
        }
    }
    
    
    @IBAction func pressedBtnSound(_ sender: UIButton) {
        if tapTapManager.isSound {
            uiSoundButton.buttonActionCustom(systemName: "speaker", color: UIColor.white)
            tapTapManager.isSound = false
            tapTapManager.defaults.set(tapTapManager.isSound, forKey: "sound")
        } else if !tapTapManager.isSound {
            uiSoundButton.buttonActionCustom(systemName: "speaker", color: UIColor.systemYellow)
            tapTapManager.isSound = true
            tapTapManager.defaults.set(tapTapManager.isSound, forKey: "sound")
        }
    }
    
    func showActionSheet() {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let resetAction = UIAlertAction(title: "Reset Dhikir", style: .destructive) { action -> Void in
            self.tapTapManager.resetNumberConter()
            self.buttonTapCounter.setTitle(String(self.tapTapManager.numberCounter), for: .normal)
            self.buttonTapCounter.titleLabel?.font = .systemFont(ofSize: 48, weight: .semibold)
            print("tapped destructive")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        optionMenu.addAction(resetAction)
        optionMenu.addAction(cancelAction)

        present(optionMenu, animated: true)

    }
}

extension UIButton {
    func buttonActionCustom(systemName sfSymbol: String, color tintColor: UIColor) {
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular, scale: .large)
        let icon = UIImage(systemName: sfSymbol, withConfiguration: iconConfig)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        self.backgroundColor = .white.withAlphaComponent(0.2)
        self.layer.cornerRadius = 8
        self.setTitleColor(.white, for: .normal)
        self.setImage(icon, for: .normal)
    }
}

