//  ViewController.swift
//  Calculator
//
//  Created by PrashMaya on 7/27/17.
//  Copyright © 2017 Prashanth Yerramilli. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "π":
                display.text = String(Double.pi)
            case "√":
                let operand = Double(display.text!)
                display.text = String(sqrt(operand!))
            default:
                break
            }
        }
    }

    @IBAction func resetDisplay(_ sender: UIButton) {
        display.text = "0"
    }
}
