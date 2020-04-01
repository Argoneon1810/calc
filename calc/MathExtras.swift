//
//  MathExtras.swift
//  calc
//
//  Created by Jin on 1/4/20.
//  Copyright © 2020 UTS. All rights reserved.
//

class MathExtras {
    enum Priority: Int, Comparable{     //Priority Enumerator for operators to follow the rules of arithmatics
        case Medium = 1
        case Less = 0
        
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
        case Multiply = "x"
        case Divide = "/"
        case Plus = "+"
        case Minus = "-"
        case Remainder = "%"
        init?(rawValue: String) {
            switch rawValue {
            case "+": self = .Plus
            case "-": self = .Minus
            case "x": self = .Multiply
            case "/": self = .Divide
            case "%": self = .Remainder
            default: return nil
            }
        }
        func getRaw() -> String {
            return self.rawValue
        }
    }
    
    static func getPriority(sign: Operators) -> Priority {
        switch sign {
        case .Multiply, .Divide, .Remainder:
            return Priority.Medium
        case .Plus, .Minus:
            return Priority.Less
        }
    }
}
