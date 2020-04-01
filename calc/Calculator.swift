//
//  Calculator.swift
//  calc
//
//  Created by Jin on 1/4/20.
//  Copyright © 2020 UTS. All rights reserved.
//

class Calculator {
    static func calculate(_operator: String, value_A: Int, value_B: Int) -> Int {
        switch MathExtras.Operators(rawValue: _operator) {
        case .Plus:
            //if overflow, return Int.min
            if value_A.addingReportingOverflow(value_B).overflow {return ExpressionValidator.handleError(textToShow: "Overflow detected (Addition)")}
            //else, return properly
            return value_A+value_B
        case .Minus:
            //if overflow, return Int.min
            if value_A.subtractingReportingOverflow(value_B).overflow {return ExpressionValidator.handleError(textToShow: "Overflow detected (Subtraction)")}
            //else, return properly
            return value_A-value_B
        case .Multiply:
            //if overflow, return Int.min
            if value_A.multipliedReportingOverflow(by: value_B).overflow {return ExpressionValidator.handleError(textToShow: "Overflow detected (Multiplication)")}
            //else, return properly
            return value_A*value_B
        case .Divide:
            //if divided by 0, return Int.min
            if value_B==0 {return ExpressionValidator.handleError(textToShow: "Division by zero was detected (Division operation)")}
            //else if overflow, return Int.min
            else if value_A.dividedReportingOverflow(by: value_B).overflow {return ExpressionValidator.handleError(textToShow: "Overflow detected (Division)")}
            //else, return properly
            return value_A/value_B
        case .Remainder:
            //if divided by 0, return Int.min
            if value_B==0 {return ExpressionValidator.handleError(textToShow: "Division by zero was detected (Remainder operation)")}
            //else if overflow, return Int.min
            else if value_A.remainderReportingOverflow(dividingBy: value_B).overflow {return ExpressionValidator.handleError(textToShow: "Overflow detected (Remainder)")}
            //else, return properly
            return value_A%value_B
        default:
            return ExpressionValidator.handleError(textToShow: "Internal Error: Operator identification Failed at calculation stage")
        }
    }
}
