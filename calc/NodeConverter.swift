//
//  ExpressionConverter.swift
//  calc
//
//  Created by Jin on 20/03/2020.
//  Copyright © 2020 UTS. All rights reserved.
//

class NodeConverter {
    func infix2postfix(expression: [String]) -> [String] {
        var operators: [MathExtras.Operators] = [MathExtras.Operators]()          //array to store operators temporarily
        var postfixedExpression: [String] = [String]()      //array to store postfixed expression temporarily
        
        for node: String in expression {                    //loop for String Array Length
            if let sign = MathExtras.Operators(rawValue: node) {       //when this iteration's expression node was an operator
                let optionalOperator: MathExtras.Operators? = operators.popLast()  //optional const to check if oprs String Array has a value within already
                let new = MathExtras.getPriority(sign: sign)                       //priority of current iteration's operator
                
                if let old = optionalOperator {                         //when oprs was not empty
                    if MathExtras.getPriority(sign: old) >= new {                      //when new operator is lessly or equally prioritised than old one
                        postfixedExpression.append(old.getRaw())                //put old one to returning array
                        operators.append(sign)                                  //and store new one to oprs
                    } else {                                                //when new operator is morely prioritised than old one
                        operators.append(old)                                   //put old one back to oprs
                        operators.append(sign)                                  //and store new one too into oprs   (They will be out later)
                    }
                } else {                                        //when oprs was empty (possibly it was the first iteration, or just coincidence)
                    operators.append(sign)                      //store new one into oprs array directly
                }
            } else {                                        //when this iteration's expression node was a number
                if Int(node) != nil {                           //if non-operator expression is a number
                    postfixedExpression.append(node)                //store number (in String) to returning array
                }
                else { return [String]() }                      //For error handling
            }
        }
        
        //Preparation of array since I need it to be popped in LIFO order
        operators.reverse()
        
        //Add every operators to expression (Postfix)
        for opr: MathExtras.Operators in operators {
            postfixedExpression.append(opr.getRaw())
        }
        
        //Return final result
        return postfixedExpression
    }
    
    func postfix2NodeTree(expression: [String]) -> Node {
        if expression.isEmpty { return Node() } //For Error Handling
        
        var stack: [Node] = [Node]()                //temporary array for storing nodes created throughout iteration
        var node: Node                              //temporary node for each iteration's conversion
        
        for current: String in expression {         //loop for the string array length
            if MathExtras.Operators(rawValue: current) != nil {    //if current String value was an operator
                node = Node(value: current)                 //create operator node
                if let templeft = stack.popLast() {node.add(child: templeft)}   //add childnode left
                else {                                                          //Error Handling
                    print(ExpressionValidator.handleError(textToShow: "Expected number by an operator, but it could not be found"))
                }
                if let tempright = stack.popLast() {node.add(child: tempright)} //add childnode right
                else {                                                          //Error Handling
                    print(ExpressionValidator.handleError(textToShow: "Expected number by an operator, but it could not be found"))
                }
            } else {                                    //if current String value was a number (MAY INCLUDE UNIARY OPERATOR)
                node = Node(value: current)                 //create number node
            }
            stack.append(node)                          //whichever the node was, add it to array
        }
        
        //when every iteration is done, array must be holding only one node which is the root node
        if let toReturn: Node = stack.popLast() {return toReturn}
        else {return Node()}
    }
}
