//
//  Test_ios_EustacheTests.swift
//  Test-ios-EustacheTests
//
//  Created by jeremy eustache on 03/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import XCTest
@testable import Test_ios_Eustache

class Test_ios_EustacheTests: XCTestCase {

    var sut: URLSession!
    
    override func setUp() {
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
       sut = nil
    }

    func testWSGetsHTTPStatusCode200() {
       
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APPURL.host
        urlComponents.path = APPURL.path
        
        let url = urlComponents.url
        
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
    }
    
    func testWSCallCompletes() {
        // given
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = APPURL.host
        urlComponents.path = APPURL.path
        
        let url = urlComponents.url
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }


    func testPerformanceExample() {
        self.measure {
            // TODO
        }
    }

}
