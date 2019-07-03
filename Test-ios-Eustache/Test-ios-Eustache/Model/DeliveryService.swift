//
//  DeliveryService.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 02/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

let numberOfDataPerPages = 20

//Service to get the deliveries
func getDeliveries(withOffset offset: Int = 0, limit: Int = numberOfDataPerPages, completion: @escaping ((Result<[Delivery]>) -> Void)) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = APPURL.host
    urlComponents.path = APPURL.path
    
    urlComponents.queryItems = [
        URLQueryItem(name: "offset", value: String(offset)),
        URLQueryItem(name: "limit", value: String(limit))
    ]
    
    guard let url = urlComponents.url else { fatalError("error in component URL") }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        DispatchQueue.main.async {
            if let error = responseError {
                completion(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Delivery].self, from: jsonData)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data error from request"]) as Error
                completion(.failure(error))
            }
        }
    }
    
    task.resume()
}
