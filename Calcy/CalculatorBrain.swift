//
//  CalculatorBrain.swift
//  Calcy
//
//  Created by Mitul Manish on 2/07/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    private typealias binaryOperationSignature = (Double,Double) -> Double
    private typealias unaryOperationSignature = (Double) -> Double
    
    private var opearations: [String : Operation] = [
        "π"     : Operation.Constant(M_PI),
        "e"     : Operation.Constant(M_E),
        "√"     : Operation.UnaryOperation(sqrt),
        "±"     : Operation.UnaryOperation({ -$0 }),
        "%"     : Operation.UnaryOperation({ 0.01 * $0 }),
        "sin"   : Operation.UnaryOperation(sin),
        "cos"   : Operation.UnaryOperation(cos),
        "tan"   : Operation.UnaryOperation(tan),
        "log"   : Operation.UnaryOperation(log),
        "×"     : Operation.BinaryOperation({ $0 * $1 }),
        "÷"     : Operation.BinaryOperation({ $0 / $1 }),
        "+"     : Operation.BinaryOperation({ $0 + $1 }),
        "−"     : Operation.BinaryOperation({ $0 - $1 }),
        "C"     : Operation.Clear,
        "="     : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation(unaryOperationSignature)
        case BinaryOperation(binaryOperationSignature)
        case Clear
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        
        if let operation = opearations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Clear:
                accumulator = 0.0
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending = PendingBinaryOperationInfo?()
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: binaryOperationSignature
        var firstOperand: Double
    }
    
    var result: Double {
        get { return accumulator }
    }
    
}
