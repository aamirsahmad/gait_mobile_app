//
//  gait_mobile_appTests.swift
//  gait_mobile_appTests
//
//  Created by Ekram Bhuiyan on 2020-09-04.
//

import XCTest
import Runner

class gait_mobile_appTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAccProcessor() throws {
        // 1. given
         let guess = 5
         var guess2 =
         XCTAssertEqual(guess, 5, "Score computed from guess is wrong")
    }
    
    
}
