//
//  detroitLabsChallengeUITests.swift
//  detroitLabsChallengeUITests
//
//  Created by may on 2018-06-08.
//  Copyright © 2018 sohaeb. All rights reserved.
//

import XCTest

class detroitLabsChallengeUITests: XCTestCase {
        

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        let firstButton = tabBarsQuery.buttons["First"]
        firstButton.tap()
        tabBarsQuery.buttons["Item"].tap()
        firstButton.tap()
        
    }
    
}
