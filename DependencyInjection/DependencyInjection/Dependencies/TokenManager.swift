//
//  TokenManager.swift
//  DependencyInjection
//
//  Created by Ken on 19/04/2016.
//  Copyright © 2016 Ken Boucher. All rights reserved.
//

import Foundation

class TokenManager {
  
  func saveToken(accessToken: String, forUser user: String) {
    NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "\(user.hash)")
    NSUserDefaults.standardUserDefaults().synchronize()
  }

  func loadTokenForUser(user: String) -> String? {
    return NSUserDefaults.standardUserDefaults().objectForKey("\(user.hash)") as? String
  }
  
}
