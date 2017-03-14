//
//  ItemListViewControllerTest.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/2/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import ToDoApp

class ItemListViewControllerTests: XCTestCase {
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
        
        sut.itemManager.removeAll()
        
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
    
    func test_ViewWillAppear_ReloadsTableView() {
        
        let dataSource = ItemListDataProvider()
        dataSource.itemManager = ItemManager()
        
        let mockListVC = MockListViewController()
        mockListVC.tableView = sut.tableView
        mockListVC.tableView.dataSource = sut.tableView.dataSource
        mockListVC.dataProvider = sut.dataProvider
        
        mockListVC.beginAppearanceTransition(true, animated: true)
        mockListVC.endAppearanceTransition()
        
        XCTAssertTrue(mockListVC.didReload)
    }
    
    func test_ItemSelectedNotification_PushesDetailVC() {
        
        UIApplication.shared.keyWindow?.rootViewController = nil
        
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        
        
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController

        _ = sut.view
        
        NotificationCenter.default.post(name: NSNotification.Name("ItemSelectedNotification"), object: self, userInfo: ["index": 1])
        
        guard let detailViewController = mockNavigationController.pushedViewController as? DetailViewController else {
            XCTFail()
            return
        }
        
        guard let detailItemManager = detailViewController.itemInfo?.0 else {
            XCTFail()
            return
        }
        
        guard let index = detailViewController.itemInfo?.1 else {
            XCTFail()
            return
        }
        
        _ = detailViewController.view
        
        XCTAssertNotNil(detailViewController.titleLabel)
        XCTAssertTrue(detailItemManager === sut.itemManager)
        XCTAssertEqual(index, 1)
        
    }
    
}

extension ItemListViewControllerTests {
    
    class MockListViewController: ItemListViewController {
        var didReload = false
        
        override func viewWillAppear(_ animated: Bool) {
            didReload = true
            return super.viewWillAppear(animated)
        }
        
    }
    
    class MockNavigationController: UINavigationController {
        
        
        var pushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            
            super.pushViewController(viewController, animated: animated)
        }
        
    }
    
}
