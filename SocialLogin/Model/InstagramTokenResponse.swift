//
//  InstagramTokenResponse.swift
//  SocialLogin
//
//  Created by MACBOOK on 06/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

struct InstagramTokenResponse: Codable {
    let accessToken: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case userID = "user_id"
    }
}

struct InstagramUser:Codable{
    let id,username: String
}
