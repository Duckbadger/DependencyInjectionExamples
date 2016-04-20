//
//  DependencyInjectionTests.swift
//  DependencyInjectionTests
//
//  Created by Ken on 19/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import XCTest
@testable import DependencyInjection

class DependencyInjectionTests: XCTestCase {
  
  let loginManager = LoginManager()
  
  override func setUp() {
    super.setUp()
  }
  
  func testValidLogin() {
    let wait = expectationWithDescription("wait")
    loginManager.login(withEmail: "Ken@DependencyInjection.co", password: "b4dg3rz4Lyf") { (success, error) in
      XCTAssert(success == true)
      XCTAssert(error == nil)
      wait.fulfill()
    }
    
    waitForExpectationsWithTimeout(5) { error in XCTAssert(error == nil) }
  }
  
  func testInvalidLogin() {
    let wait = expectationWithDescription("wait")
    loginManager.login(withEmail: "Ken@DependencyInjection.co", password: "b4dg3rz4Lyf") { (success, error) in
      XCTAssert(success == false)
      XCTAssert(error as? FBLoginError == FBLoginError.AuthenticationError)
      wait.fulfill()
    }
    
    waitForExpectationsWithTimeout(5) { error in XCTAssert(error == nil) }
  }
  
}
