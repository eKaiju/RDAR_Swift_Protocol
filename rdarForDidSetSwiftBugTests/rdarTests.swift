//
//  rdarForDidSetSwiftBugTests.swift
//  rdarForDidSetSwiftBugTests
//
//  Created by Oleo, Pierre on 2015-09-15.
//  Copyright © 2015 La Presse. All rights reserved.
//

import XCTest
@testable import rdarForDidSetSwiftBug

class rdarForDidSetSwiftBugTests: XCTestCase {

    func testDirectClassWithUnwrap() {
        let validator = DidSetValidator()
        let classDidSetCount = validator.classDidSetCount
        validator.validateDirectClassWithUnwrap()
        XCTAssertTrue(classDidSetCount == validator.classDidSetCount, "validator.protocolDidSetCount should not change")
    }

    func testDirectClassWithOptional() {
        let validator = DidSetValidator()
        let classDidSetCount = validator.classDidSetCount
        validator.validateDirectClassWithOptional()
        XCTAssertTrue(classDidSetCount == validator.classDidSetCount, "validator.protocolDidSetCount should not change")
    }

    func testProtocolImplementationWithUnwrap() {
        let validator = DidSetValidator()
        let protocolDidSetCount = validator.protocolDidSetCount
        validator.validateProtocolImplementationWithUnwrap()
        XCTAssertTrue(protocolDidSetCount == validator.protocolDidSetCount, "validator.protocolDidSetCount should not change")
    }

    //MARK: Test that fails
    // Test that Fails due to the bug in didSet
    func testProtocolImplementationWithOptional() {
        let validator = DidSetValidator()
        let protocolDidSetCount = validator.protocolDidSetCount
        validator.validateProtocolImplementationWithOptional()
        XCTAssertTrue(protocolDidSetCount == validator.protocolDidSetCount, "validator.protocolDidSetCount should not change")
    }

}
