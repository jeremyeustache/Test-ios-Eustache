//
//  Test_ios_EustacheUITests.swift
//  Test-ios-EustacheUITests
//
//  Created by jeremy eustache on 03/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import XCTest

class Test_ios_EustacheUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testRefreshButtonWhenNoConnection() {
        let refreshButton = XCUIApplication().buttons["Refresh"]
        refreshButton.tap()
    }
    

}
