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
        case equals
    }
    
    private var operations : Dictionary<String, Operation> =
        [
            "π" : Operation.constant(Double.pi),
            "e": Operation.constant(M_E),
            "cos" : Operation.unaryOperation(cos),
            "√" : Operation.unaryOperation(sqrt),
            "×" : Operation.binaryOperation({$0 * $1}),
            "+" : Operation.binaryOperation({$0 + $1}),
            "÷" : Operation.binaryOperation({$0 / $1}),
            "-" : Operation.binaryOperation({$0 - $1}),
            "±" : Operation.unaryOperation({-$0}),
            "=" : Operation.equals
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
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        // With an ! it will unwrap it, but if it's just a question mark then if it's set then it will unwrap, else it will just ignore it
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            // No longer are we in the middle of pending binary operation
            pendingBinaryOperation = nil
        }
    }
            
    private var pendingBinaryOperation : PendingBinaryOperation?
    
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
