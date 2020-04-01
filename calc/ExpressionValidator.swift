//
//  ExpressionValidator.swift
//  calc
//
//  Created by Jin on 20/03/2020.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class ExpressionValidator {
    let ERROR: String = "Invalid Input: ";
    
    func even(number: Int) -> Bool {
        if number%2 == 0 {return true}
        return false
    }

    func validate(original: [String]) -> [String]{
        if original.isEmpty {                               //if given arguments were actually nothing
            print(ERROR+"No arguments received")
            exit(-1)
        }
        else if even(number: original.count) {              //if given argumnets' number is even (supposedly odd if valid)
            print(ERROR+"Insufficient number of arguments")
            exit(-1)
        }
        else {
            return original
        }
    }
    
    static func handleError(textToShow: String) -> Int{
        print(textToShow)
        exit(-1)
    }
}
