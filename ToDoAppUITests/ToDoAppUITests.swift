//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Denim Mazuki on 3/14/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest

class ToDoAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_SavingAnItemAddsAnItemToList() {
        
        let app = XCUIApplication()
        app.navigationBars["ToDoApp.ItemListView"].buttons["Add"].tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Meeting")
        
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("02/22/2016")
        
        let locationNameTextField = app.textFields["Location"]
        locationNameTextField.tap()
        locationNameTextField.typeText("Office")
        
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("Infinite Loop 1, Cupertino")
        
        let descriptionTextField = app.textFields["Description"]
        descriptionTextField.tap()
        descriptionTextField.typeText("Bring iPad")
        
        
        app.buttons["Save"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Meeting"].exists)
        XCTAssertTrue(app.tables.staticTexts["02/22/2016"].exists)
        XCTAssertTrue(app.tables.staticTexts["Office"].exists)
    }
    
    
    
    
    
    
    
    
    
    
}
