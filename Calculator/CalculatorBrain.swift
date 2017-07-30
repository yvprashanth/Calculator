//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by PrashMaya2 on 7/29/17.
//  Copyright © 2017 Prashanth Yerramilli. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    // Accumulated Result
    private var accumulator : Double?
    
    mutating func performOperation(_ mathematicalSymbol: String){
        switch mathematicalSymbol {
        case "π":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        default:
            break
        }
    }
    
    mutating func setOperand(_ operand : Double)
    {
        accumulator = operand
    }

    var result : Double? {
        get {
            return accumulator
        }
    }
}
