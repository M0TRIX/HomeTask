//
//  CheckResponseTestCase.swift
//  HomeTaskTests
//
//  Created by WebVajhegan on 3/8/22.
//  Copyright © 2022 WebVajhegan. All rights reserved.
//

@testable import HomeTask

import XCTest

class CheckResponseTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        testCheckResponseWithForbidden()
        testCheckResponseWithNotSuccess()
        testCheckResponseWithInvalidResponse()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCheckResponseWithForbidden(){
        ServiceApi.shared.getListOfCoordinations { (response, data) in
            let result = ServiceValidator.checkResposnse(response: response, data: data)
            XCTAssertEqual(result, ServiceError.FORBIDDEN)
        }
    }
    
    func testCheckResponseWithNotSuccess(){
        ServiceApi.shared.getListOfCoordinations { (response, data) in
            let result = ServiceValidator.checkResposnse(response: response, data: data)
            XCTAssertNotEqual(result, ServiceError.SUCCESS)
        }
    }
    
    func testCheckResponseWithInvalidResponse(){
        ServiceApi.shared.getListOfCoordinations { (response, data) in
            let result = ServiceValidator.checkResposnse(response: response, data: data)
            XCTAssertNotNil(result)
        }
    }
}
