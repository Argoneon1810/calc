//
//  MathExtras.swift
//  calc
//
//  Created by Jin on 1/4/20.
//  Copyright © 2020 UTS. All rights reserved.
//

class MathExtras {
    enum Priority: Int, Comparable{     //Priority Enumerator for operators to follow the rules of arithmatics
        case Medium = 1                     //if necessary, priority magnitude can be varied
        case Less = 0
                                            //...or added (e.g. ^ operator)
        //Override Operators
        static func < (a: Priority, b: Priority) -> Bool {      //to compare each priority
            return a.rawValue < b.rawValue
        }
        static func > (a: Priority, b: Priority) -> Bool {      //...
            return a.rawValue > b.rawValue
        }
        static func <= (a: Priority, b: Priority) -> Bool {     //...
            return a.rawValue <= b.rawValue
        }
        static func >= (a: Priority, b: Priority) -> Bool {     //...
            return a.rawValue >= b.rawValue
        }
    }
    
    enum Operators: String {            //Enumerators for operators (for extensibility purpose)
        case Multiply = "x"                 //if necessary, operator text can be varied
        case Divide = "/"
        case Plus = "+"
        case Minus = "-"
        case Remainder = "%"                //...or operator itself can be added as extension
        
        init?(rawValue: String) {           //swap string to Operators
            switch rawValue {
            case "+": self = .Plus
            case "-": self = .Minus
            case "x": self = .Multiply
            case "/": self = .Divide
            case "%": self = .Remainder
            default: return nil             //check NodeConverter to see how this is used
            }
        }
        func getRaw() -> String {           //swap Operators to string (Operators.rawValue works, but as an optional value)
            return self.rawValue
        }
        func getPriority() -> Priority {    //if any operator is added, please refer here
            switch self {
            case .Multiply, .Divide, .Remainder:
                return Priority.Medium
            case .Plus, .Minus:
                return Priority.Less
            }
        }
    }
}
