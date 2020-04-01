//
//  Calculator.swift
//  calc
//
//  Created by Jin on 1/4/20.
//  Copyright © 2020 UTS. All rights reserved.
//

class Calculator {
    static func calculate(_operator: String, value_A: Int, value_B: Int) -> Int {       //FROM NODE.TRAVERSE()
        let result: (partialValue: Int, overflow: Bool)             //tuple which is returned from ~~ReportinOverflow functions
        switch MathExtras.Operators(rawValue: _operator) {          //convert String type of operator to MathExtras.Operators
                                                                        //Note: if using generic types in array is found, please go to NodeConverter, infix2Postfix()
        case .Plus:                                                                                 //if addition
            result = value_A.addingReportingOverflow(value_B)                                           //first, calculate ignoring overflow
            if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected")}       //if overflow, emit error
            return result.partialValue                                                                  //else, return properly
        case .Minus:                                                                                //if subtraction
            result = value_A.subtractingReportingOverflow(value_B)                                      //first, calculate ignoring overflow
            if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected")}       //if overflow, emit error
            return result.partialValue                                                                  //else, return properly
        case .Multiply:                                                                             //if multiplication
            result = value_A.multipliedReportingOverflow(by: value_B)                                   //first, calculate ignoring overflow
            if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected")}       //if overflow, emit error
            return result.partialValue                                                                  //else, return properly
        case .Divide:                                                                               //if division
            if value_B==0 {ExpressionValidator.handleError(textToShow: "Division by zero")}             //first, if divided by 0, return Int.min
            else {                                                                                      //else
                result = value_A.dividedReportingOverflow(by: value_B)                                      //calculate ignoring overflow
                if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected")}       //if overflow, emit error
                return value_A/value_B                                                                      //else, return properly
            }
        case .Remainder:                                                                            //if remainder
            if value_B==0 {ExpressionValidator.handleError(textToShow: "Division by zero")}             //first, if divided by 0, return Int.min
            else{                                                                                       //else
                result = value_A.remainderReportingOverflow(dividingBy: value_B)                            //calculate ignoring overflow
                if result.overflow {ExpressionValidator.handleError(textToShow: "Overflow detected")}       //if overflow, emit error
                return value_A%value_B                                                                      //else, return properly
            }
        default:
            ExpressionValidator.handleError(textToShow: "Internal Error: Operator identification Failed at calculation stage")
        }
        return Int.min
    }
}
