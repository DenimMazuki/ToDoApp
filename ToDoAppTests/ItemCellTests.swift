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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HasNameLabel() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        
        tableView?.dataSource = dataSource
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.titleLabel)
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
