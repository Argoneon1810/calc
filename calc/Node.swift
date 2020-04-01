//
//  Node.swift
//  calc
//
//  Created by Jin on 20/03/2020.
//  Copyright © 2020 UTS. All rights reserved.
import Foundation

class Node {
    var value: String
    var children: [Node] = [Node]()
    weak var parent: Node? // add the parent property
    
    init(){
        value = ""
    }
    init(value: String) {
      self.value = value
    }

    func add(child: Node) {
      children.append(child)
      child.parent = self
    }
    
    func traverse(root: Node) -> Int {
        if root.value == "" {           //For Error Handling
            return ExpressionValidator.handleError(textToShow: "Inappropriate value was provided")
        }
        
        switch root.children.count {
        case 0:                         //if the node owns no child (==value node)
                                            //return value if there is no error (it can bear unary operator as well)
            return Int(root.value) ?? (ExpressionValidator.handleError(textToShow: "Number was expected, but it could not be found"))
        case 2:                         //if the node own two children (==operator node)
            let childLeft: Int = traverse(root: root.children[1])       //Because of LIFO of stack, the left is the latter and the right is the prior
            let childRight: Int = traverse(root: root.children[0])
            return Calculator.calculate(_operator: root.value, value_A: childLeft, value_B: childRight)
        default:                        //For Error Handling
            return ExpressionValidator.handleError(textToShow: "Internal Error")
        }
    }
}
