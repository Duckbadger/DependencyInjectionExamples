//
//  FBLoginService.swift
//  DependencyInjection
//
//  Created by Ken on 19/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import Foundation

enum FBLoginError: ErrorType {
  case FacebookNotAuthorised
  case AuthenticationError
}

enum FBRequestResult {
  case Success(accessToken: String)
  case Failure(error: ErrorType)
}

typealias FBLoginHandler = (result: FBRequestResult) -> Void

class FBLoginService {
  
  func login(email: String, password: String, handler: FBLoginHandler) {
    handler(result: .Failure(error: FBLoginError.FacebookNotAuthorised))
  }
  
}
