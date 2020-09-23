//
//  InstagramResponse.swift
//  SocialLogin
//
//  Created by MACBOOK on 22/09/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

struct InstagramTestUser: Codable {
  var access_token: String
  var user_id: Int
}
struct InstagramUser: Codable {
  var id: String
  var username: String
}
