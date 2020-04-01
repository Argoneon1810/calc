//
//  Calculator.swift
//  calc
//
//  Created by Jin on 1/4/20.
//  Copyright © 2020 UTS. All rights reserved.
//

class Calculator {
    static func calculate(_operator: String, value_A: Int, value_B: Int) -> Int {
        let result: (partialValue: Int, overflow: Bool)             //tuple which is returned from ~~ReportinOverflow functions
        switch MathExtras.Operators(rawValue: _operator) {          //
        case .Plus:
            //first, calculate ignoring overflow
            result = value_A.addingReportingOverflow(value_B)
            //if overflow, emit error
            if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected (Addition)")}
            //else, return properly
            return result.partialValue
        case .Minus:
            //first, calculate ignoring overflow
            result = value_A.subtractingReportingOverflow(value_B)
            //if overflow, emit error
            if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected (Subtraction)")}
            //else, return properly
            return result.partialValue
        case .Multiply:
            //first, calculate ignoring overflow
            result = value_A.multipliedReportingOverflow(by: value_B)
            //if overflow, emit error
            if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected (Multiplication)")}
            //else, return properly
            return result.partialValue
        case .Divide:
            //first, if divided by 0, return Int.min
            if value_B==0 {ExpressionValidator.handleError(textToShow: "Division by zero was detected (Division operation)")}
            //else
            else {
                //calculate ignoring overflow
                result = value_A.dividedReportingOverflow(by: value_B)
                //if overflow, emit error
                if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected (Division)")}
                //else, return properly
                return value_A/value_B
            }
        case .Remainder:
            //first, if divided by 0, return Int.min
            if value_B==0 {ExpressionValidator.handleError(textToShow: "Division by zero was detected (Remainder operation)")}
            //else
            else{
                //calculate ignoring overflow
                result = value_A.remainderReportingOverflow(dividingBy: value_B)
                //if overflow, emit error
                if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected (Remainder)")}
                //else, return properly
                return value_A%value_B
            }
        default:
            ExpressionValidator.handleError(textToShow: "Internal Error: Operator identification Failed at calculation stage")
        }
        return Int.min
    }
}
