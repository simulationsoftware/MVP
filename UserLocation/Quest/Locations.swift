//
//  Locations.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/10/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import Foundation

public class Locations {
    var latitude: Double
    var longitude: Double
    var next: Locations?
    weak var previous: Locations?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

    class LinkedList: Sequence{
    fileprivate var head: Locations?
    private var tail: Locations?
    
    func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(self)
    }
    
    
    struct LinkedListIterator: IteratorProtocol {
        let linkedList: LinkedList
        var current: Locations?
        init(_ linkedList: LinkedList) {
            self.linkedList = linkedList
            self.current = linkedList.head
        }
        mutating func next() -> Locations? {
            guard let thisCurrent = current else { return nil }
            current = thisCurrent.next
            return thisCurrent
        }
    }

    
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Locations?{
        return head
    }
    
    public var last: Locations? {
        return tail
    }
    
    
    public func append(latitude: Double, longitude: Double){
        let newLocation = Locations(latitude: latitude, longitude: longitude)
        
        if let tailNode = tail{
            newLocation.previous = tailNode
            tailNode.next = newLocation
        }
        else {
            head = newLocation
        }
        
        tail = newLocation
        
    }
        
    func printList() {
            var current: Locations? = head
            //assign the next instance
            while (current != nil) {
                print("latitude: \(current?.latitude), longitude: \(current?.longitude)")
                current = current?.next
            }
        }
        

    func removeAll() {
            head = nil
            tail = nil
        }
}



