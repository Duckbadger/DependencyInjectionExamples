//
//  DependencyInjectionTests.swift
//  DependencyInjectionTests
//
//  Created by Ken on 19/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import XCTest
@testable import DependencyInjection

class MockValidLoginService: LoginService {
  func login(withEmail email: String, password: String, loginHandler: LoginHandler) {
    loginHandler(result: .Success(accessToken: "12345"))
  }
}

class MockInvalidLoginService: LoginService {
  func login(withEmail email: String, password: String, loginHandler: LoginHandler) {
    loginHandler(result: .Failure(error: LoginError.AuthenticationError))
  }
}

class DependencyInjectionTests: XCTestCase {
  
  let email = "Ken@DependencyInjection.co"
  let tokenManager = TokenManager()
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    let appDomain = NSBundle.mainBundle().bundleIdentifier!
    NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
    super.tearDown()
  }
  
  func testValidLogin() {
    let loginManager = LoginManager(loginService: MockValidLoginService())
    
    let wait = expectationWithDescription("wait")
    loginManager.login(withEmail: email, password: "b4dg3rz4Lyf") { [weak self] (success, error) in
      XCTAssert(success == true)
      XCTAssert(error == nil)
      XCTAssert(self!.tokenManager.loadTokenForUser(self!.email) != nil)
      wait.fulfill()
    }
    
    waitForExpectationsWithTimeout(5) { error in XCTAssert(error == nil) }
  }
  
  func testInvalidLogin() {
    let loginManager = LoginManager(loginService: MockInvalidLoginService())
    
    let wait = expectationWithDescription("wait")
    loginManager.login(withEmail: email, password: "b4dg3rz4Lyf") { [weak self] (success, error) in
      XCTAssert(success == false)
      XCTAssert(error as? LoginError == .AuthenticationError)
      XCTAssert(self!.tokenManager.loadTokenForUser(self!.email) == nil)
      wait.fulfill()
    }
    
    waitForExpectationsWithTimeout(5) { error in XCTAssert(error == nil) }
  }
  
}
