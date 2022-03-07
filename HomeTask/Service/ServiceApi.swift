//
//  ServiceApi.swift
//  HomeTask
//
//  Created by WebVajhegan on 3/6/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

import Foundation

class ServiceApi {
    
    static var shared = ServiceApi()
    
    func getListOfCoordinations(completion:@escaping(URLResponse,Data)->()){
        let url = URL(string: "https://api.jsonbin.io/b/5fa8ff8dbd01877eecdb898f")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["secret-key":"$2b$10$VE0tRqquld4OBl7LDeo9v.afsyRXFlXcQzmj1KpEB6K1wG2okzQcK"]
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            completion(response ?? URLResponse(),data!)
            }.resume()
    }
}
