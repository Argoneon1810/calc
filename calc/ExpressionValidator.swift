//
//  ExpressionValidator.swift
//  calc
//
//  Created by Jin on 20/03/2020.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class ExpressionValidator {
    let ERROR: String = "Invalid Input: ";                  //for my convenience
    
    func even(number: Int) -> Bool {                        //function which returns true if given number is an even number
        if number%2 == 0 {return true}
        return false
    }

    func validate(original: [String]) -> [String]{          //function to initially check for an obvious mal-inputs
        if original.isEmpty {                                   //if given arguments were actually nothing
            ExpressionValidator.handleError(textToShow: ERROR+"No arguments received")
        }
        else if even(number: original.count) {                  //if given argumnets' number is even (supposedly odd if valid)
            ExpressionValidator.handleError(textToShow: ERROR+"Insufficient number of arguments")
        }
        return original
    }
    
    static func handleError(textToShow: String){
        print(textToShow)
        exit(-1)
    }
}
