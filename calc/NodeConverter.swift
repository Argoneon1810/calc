//
//  ExpressionConverter.swift
//  calc
//
//  Created by Jin on 20/03/2020.
//  Copyright © 2020 UTS. All rights reserved.
//

class NodeConverter {
    func infix2postfix(expression: [String]) -> [String] {
        var operators: [MathExtras.Operators] = [MathExtras.Operators]()        //where operators are stored temporarily
        var postfixedExpression: [String] = [String]()                          //where result will be constructed gradually
        var debugIsNumber: Bool = true                                          //used when given text is neither an operator nor a number
        for string: String in expression {                                      //loop for given array of texts
            if Int(string) != nil {                                                 //if current iteration is a number
                postfixedExpression.append(string)                                      //add that directly to the returning array
            }
            else {                                                                  //if current iteration is something else
                if let newSign = MathExtras.Operators(rawValue: string) {               //if current iteration is an operator
                    if let lastSign: MathExtras.Operators = operators.popLast() {           //if array of operators had a remaining value
                        if lastSign.getPriority() >= newSign.getPriority() {                    //if new one has lower priority than old due rules of arithmatics
                            postfixedExpression.append(lastSign.getRaw())                           //release old one to returning array
                            operators.append(newSign)                                               //and store new one temporarily
                        }
                        else {                                                                  //if new one has higher prioirity than old
                            operators.append(lastSign)                                              //store both to operator stack temporarily
                            operators.append(newSign)
                        }
                    }
                    else {                                                                  //if array of operators didnt have anything left
                        operators.append(newSign)                                               //store current operator temporarily
                    }
                }
                else {                                                                  //if current iteration is neither a number nor an operator
                    if debugIsNumber {ExpressionValidator.handleError(textToShow: "Invalid number: " + string)} //if it was a number's turn
                    else {ExpressionValidator.handleError(textToShow: "Unknown operator: " + string)}           //if it was an operator's turn
                }
            }
            debugIsNumber = !debugIsNumber                                          //error message differentialtion purpose
        }
        operators.reverse()                                                     //as temporarily stored operators in array has to be released LIFO order, reverse it
        for opr: MathExtras.Operators in operators {                            //loop for length of operators
            postfixedExpression.append(opr.getRaw())                                //and append it to returning array
        }
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
