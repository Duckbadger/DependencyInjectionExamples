//
//  LoginManager.swift
//  DependencyInjection
//
//  Created by Ken on 19/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import Foundation

typealias Completion = (success: Bool, error: ErrorType?) -> Void

class LoginManager {
  
  let tokenManager = TokenManager()
  let loginService = FBLoginService()

  init(loginService: LoginService = FacebookLogin()) {
    self.loginService = loginService
  }
  
  func login(withEmail email: String, password: String, handler: Completion) {
    loginService.login(withEmail: email, password: password) { [weak self] (result) -> Void in
      switch result {
      case .Success(let accesstoken):
        self?.tokenManager.saveToken(accesstoken, forUser: email)
        handler(success: true, error: nil)
      case .Failure(let error):
        handler(success: false, error: error)
      }
    }
  }
  
}
