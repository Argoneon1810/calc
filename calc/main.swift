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

let texts: [String] = args
if ExpressionValidator().validate(original: texts) != [] {      //if given texts (String Array) meets the equation validity
    let nodeConverter: NodeConverter = NodeConverter()     //(class instance to be used for next lines)
    print(                                                      //print result recieved through argument
        Node().traverse(                                            //String will be returned after Node Tree traversing is finished
            root: nodeConverter.postfix2NodeTree(                               //Node will be returned if the given postfix expression (String Array) is valid
                expression: nodeConverter.infix2postfix(expression: texts)          //String Array will be returned, ordered in postfix expression if the given infix is valid
            )
        )
    )
}
