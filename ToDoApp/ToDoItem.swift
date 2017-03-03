//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 2/28/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    
    if (lhs.location != rhs.location) {
        return false
    }
    
    if (lhs.itemDescription != rhs.itemDescription) {
        return false
    }
    
    if (lhs.title != rhs.title) {
        return false
    }
    
    return true
}
