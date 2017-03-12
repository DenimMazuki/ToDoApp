//
//  APIClient.swift
//  ToDoApp
//
//  Created by Denim Mazuki on 3/11/17.
//  Copyright © 2017 Denim Mazuki. All rights reserved.
//

import Foundation

class APIClient {
    lazy var session: SessionProtocol = URLSession.shared
    
    func loginUser(withName username: String, password: String, completion: @escaping (Token?, Error?) -> Void) {
        
        let query = "username=\(username)&password=\(password)"
        
        guard let url = URL(string: "https://awesometodos.com/login?\(query)") else {
            fatalError()
        }
        
        session.dataTask(with: url) {
            (data, response, error) in
            
        }
        
    }
}

protocol SessionProtocol {
    
    func dataTask (with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

extension URLSession: SessionProtocol {
    
}
