//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

//main.swift takes a role of the entry point of this program
//please visit either:
    //Node:                 Node of Node Tree Data Structure
    //NodeConverter:        Convert String Array to Node Tree (infix notation -> postfix notation -> Node Tree)
    //Calculator:           Performs arithmatics
    //MathExtras:           Holds Enums of Operators and Priority between them
    //ExpressionValidator:  1) Early verification of inputs. 2) Prints Rich Error (exits & prints(

if ExpressionValidator().validate(original: args) != [] {      //if given texts (String Array) meets the equation validity
    let nodeConverter: NodeConverter = NodeConverter()              //(class instance to be used for next lines)
    print(                                                          //print result recieved through argument
        Node().traverse(                                                //String will be returned after Node Tree traversing is finished
            root: nodeConverter.postfix2NodeTree(                           //Node will be returned if the given postfix expression (String Array) is valid
                expression: nodeConverter.infix2postfix(expression: args)      //String Array will be returned, ordered in postfix expression if the given infix is valid
            )
        )
    )
}
