//
//  DetailViewControllerTests.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/11/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import ToDoApp
import CoreLocation


class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        _ = sut.view
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_HasTitleLabel() {
        
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasMapView() {
        
        XCTAssertNotNil(sut.mapView)
    }
    
    func test_SettingItemInfo_SetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
        
        let location = Location(name: "Foo", coordinate: coordinate)
        let item = ToDoItem(title: "Bar", itemDescription: "Baz", timestamp: 1456150025, location: location)
        
        let itemManager = ItemManager()
        itemManager.add(item)
        
        sut.itemInfo = (itemManager, 0)
        
        // Force viewWillAppear
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Foo")
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
        
        
    }
    
    
}
