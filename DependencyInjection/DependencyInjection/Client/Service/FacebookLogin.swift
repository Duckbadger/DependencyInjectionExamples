//
//  FacebookLogin.swift
//  DependencyInjection
//
//  Created by Ken on 20/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import Foundation

class FacebookLogin: LoginService {
 
  let fbLoginService = FBLoginService()
  
  func login(withEmail email: String, password: String, loginHandler: LoginHandler) {
    fbLoginService.login(withEmail: email, password: password) { (result) -> Void in
      switch result {
      case .Success(let accessToken):
        loginHandler(result: .Success(accessToken: accessToken))
      case .Failure(let error):
        loginHandler(result: .Failure(error: error))
      }
    }
  }
  
}
