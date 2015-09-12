//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Tamer ElMetwally on 9/11/15.
//  Copyright © 2015 TaYmuR. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    enum OPeration: String {
        case Divide = "/"
        case Multiply = "*"
        case subtract = "-"
        case Add = "+"
        
        case Empty = "Empty"
        case Clear = ""
        
        
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var lftValStr = ""
    var rightValStr = ""
    var currentOperation: OPeration = OPeration.Empty
    var result = ""
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
     let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        
        playSound()
        
        func clear() {
            lftValStr = runningNumber
            runningNumber = ""
            outputLbl.text = "0.0"
            processOperation(OPeration.Clear)

            
        }
        
        
    }

    @IBAction func  numberPressed(btn: UIButton!){
       playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDevidePress(sender: AnyObject) {
        processOperation(OPeration.Divide)
        
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(OPeration.Multiply)
        
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(OPeration.subtract)
        
        
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(OPeration.Add)
        
        
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
        
        
    }
    func processOperation(op: OPeration) {
        playSound()
        if currentOperation != OPeration.Empty {
            // run some code
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == OPeration.Multiply {
                    result = "\(Double(lftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == OPeration.Divide {
                    result = "\(Double(lftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == OPeration.subtract {
                    result = "\(Double(lftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == OPeration.Add {
                    result = "\(Double(lftValStr)! + Double(rightValStr)!)"
                    
                }
                lftValStr = result
                outputLbl.text = result
                
                
            }
            
            currentOperation = op
            
            
        } else {
            // this is the first time an operator has been pressed
            lftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
    }
    func playSound() {
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
        
    }
    
    
}

