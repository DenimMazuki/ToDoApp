//
//  ItemListViewControllerTest.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/2/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import ToDoApp

class ItemListViewControllerTest: XCTestCase {
    var sut: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        sut = viewController as! ItemListViewController
        
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
}
