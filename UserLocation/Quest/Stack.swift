//
//  Stack.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/16/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import Foundation
import UIKit


class Node<T>{
    let value: T
    var next: Node?
    init(value: T){
        self.value = value
    }
}
class Stack<T>{
    var top: Node<T>?
    
    func push( value: T){
        let oldTop = top
        top = Node(value: value)
        top?.next = oldTop
    }
    
    func pop() -> T?{
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
    
    func peek() ->T?{
        return top?.value
    }
}


struct User {
    let name: String
    let username: String
}
