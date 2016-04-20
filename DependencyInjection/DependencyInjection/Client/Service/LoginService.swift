//
//  LoginService.swift
//  DependencyInjection
//
//  Created by Ken on 20/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import Foundation

protocol LoginService {
  func login(withEmail email: String, password: String, loginHandler: LoginHandler)
}

enum LoginError: ErrorType {
  case AuthenticationError
}

enum RequestResult {
  case Success(accessToken: String)
  case Failure(error: ErrorType)
}

typealias LoginHandler = (result: RequestResult) -> Void
