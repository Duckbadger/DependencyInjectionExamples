//
//  LoginManager.swift
//  DependencyInjection
//
//  Created by Ken on 19/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import Foundation

typealias LoginHandler = (success: Bool, error: ErrorType?) -> Void

class LoginManager {
  
  let tokenManager = TokenManager()
  let loginService = FBLoginService()

  func login(withEmail email: String, password: String, handler: LoginHandler) {
    loginService.login(email, password: password) { [weak self] (result) -> Void in
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
