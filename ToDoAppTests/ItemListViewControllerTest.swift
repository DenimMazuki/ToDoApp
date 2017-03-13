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
    var addButton: UIBarButtonItem?
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        sut = viewController as! ItemListViewController
        
        _ = sut.view
        
        addButton = sut.navigationItem.rightBarButtonItem
        
        UIApplication.shared.keyWindow?.rootViewController = sut
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
    
    func test_ItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        let target = addButton?.target
        XCTAssertEqual(target as? UIViewController, sut)
    }
    
    func test_AddItem_PresentsAddItemViewController() {
        
        XCTAssertNil(sut.presentedViewController)
        
        XCTAssertNotNil(addButton)
        
        guard let action = addButton?.action else {
            XCTFail()
            return
        }
        
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
        
        let inputViewController = sut.presentedViewController as! InputViewController
        
        XCTAssertNotNil(inputViewController.titleTextField)
    }
    
    func testItemListVC_SharesItemManagerWithInputVC() {
        
        XCTAssertNotNil(addButton)
        
        guard let action = addButton?.action else {
            XCTFail()
            return
        }
        
        
        sut.performSelector(onMainThread: action, with: addButton, waitUntilDone: true)
        
        guard let inputViewController = sut.presentedViewController as? InputViewController else {
            XCTFail()
            return
        }
        XCTAssertTrue(sut.itemManager === inputViewController.itemManager)
    }
    
    func test_ViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
    }
    
}
