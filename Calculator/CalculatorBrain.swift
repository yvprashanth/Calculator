//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by PrashMaya2 on 7/29/17.
//  Copyright © 2017 Prashanth Yerramilli. All rights reserved.
//

import Foundation

func multiply(input1: Double, input2: Double) -> Double{
    return input1 * input2
}

struct CalculatorBrain {
    
    // Accumulated Result
    private var accumulator : Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
    }
    
    private var operations : Dictionary<String, Operation> =
        [
            "π" : Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "√" : Operation.unaryOperation(sqrt),
            "×" : Operation.binaryOperation(multiply)
        ]
    
    mutating func performOperation(_ symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                }
                break
            }
        }
    }
    
    private var pbo : PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function : (Double, Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
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
