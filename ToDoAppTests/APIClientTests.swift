//
//  APIClientTests.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/11/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import XCTest
@testable import ToDoApp

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Login_UsesExpectedURL() {
        
        let sut = APIClient()
        
        let mockURLSession = MockURLSession()
        
        sut.session = mockURLSession
        
        let completion = {
            (token: Token?, error: Error?) in
        }
        
        sut.loginUser(withName: "dasdöm", password: "%&34", completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
        XCTAssertEqual(urlComponents?.path, "/login")
        
        
        let firstQuery = URLQueryItem(name: "username", value: "dasdöm")
        let secondQuery = URLQueryItem(name: "password", value: "%&34")
        var expectedComponents = URLComponents()
        
        expectedComponents.queryItems = [firstQuery, secondQuery]
        
        XCTAssertEqual((urlComponents?.queryItems)!, expectedComponents.queryItems!)
        
    }
    
}

extension APIClientTests {
    
    class MockURLSession: SessionProtocol {
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?)-> Void) -> URLSessionDataTask {
            
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
        
    }
    
    class MockTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init (data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
    
}








