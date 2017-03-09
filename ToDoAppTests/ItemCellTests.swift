//
//  ItemCellTests.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/7/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import ToDoApp

class ItemCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        tableView = controller.tableView
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HasNameLabel() {

        XCTAssertNotNil(cell.titleLabel)
    }
    
    func test_HasLocationLabel() {
        
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func test_HasDateLabel() {
        
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func test_ConfigCell_SetsLabelText() {
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
        
        cell.configCell(with: item)
        
        XCTAssertEqual(cell.titleLabel.text, "Foo")
        XCTAssertEqual(cell.locationLabel.text, "Bar")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            return UITableViewCell()
        }
        
    }
}
