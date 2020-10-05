//
//  InstagramTokenRequest.swift
//  SocialLogin
//
//  Created by MACBOOK on 06/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

struct InstagramTokenRequest:Encodable {
    let client_id = "1060027197813287"
    let client_secret = "1fa47f5322c8601e0d5edf84c34483cc"
    let grant_type = "authorization_code"
    let redirect_uri = "https://socialsizzle.heroku.com/auth/"
    let code:String
}
