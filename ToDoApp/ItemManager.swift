//
//  ItemManager.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/1/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    var toDoCount: Int {
        return toDoItems.count
    }
    var doneCount: Int {
        return doneItems.count
    }
    private var toDoItems: [ToDoItem] = []
    private var doneItems: [ToDoItem] = []
    
    var toDoPathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
            fatalError()
        }
        
        return documentURL.appendingPathComponent("toDoItems.plist")
    }
    
    var donePathURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
            fatalError()
        }
        
        return documentURL.appendingPathComponent("done.plist")
    }
    
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: .UIApplicationWillResignActive, object: nil)
        
        if let nsToDoItems = NSArray(contentsOf: toDoPathURL) {
            
            for dict in nsToDoItems {
                
                if let toDoItem = ToDoItem(dict: dict as! [String:Any]) {
                    toDoItems.append(toDoItem)
                }
                
            }
        }
        
        if let nsDoneItems = NSArray(contentsOf: donePathURL) {
            
            for dict in nsDoneItems {
                
                if let doneItem = ToDoItem(dict: dict as! [String:Any]) {
                    doneItems.append(doneItem)
                }
                
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    func add(_ item: ToDoItem) {
        if (!toDoItems.contains(item)) {
            toDoItems.append(item)
        }
    }
    
    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func uncheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
    
    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
    
    
    func save() {
        
        let nsToDoItems = toDoItems.map{ $0.plistDict
        }
        
        let nsDoneItems = doneItems.map{
            $0.plistDict
        }
        
        
        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: nsToDoItems, format: PropertyListSerialization.PropertyListFormat.xml, options: PropertyListSerialization.WriteOptions(0))
            
            try plistData.write(to: toDoPathURL, options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
        
        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: nsDoneItems, format: PropertyListSerialization.PropertyListFormat.xml, options: PropertyListSerialization.WriteOptions(0))
            
            try plistData.write(to: donePathURL, options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
        
    }
}
