//
//  API_Helper.swift
//  SocialLogin
//
//  Created by MACBOOK on 06/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

struct API{
    struct USER {
        static let InstagramToken = "https://api.instagram.com/oauth/access_token"
    }
}

struct GCD {
    struct USER {
         static let InstagramToken = DispatchQueue(label: "com.app.InstagramToken", qos: DispatchQoS.utility, attributes: DispatchQueue.Attributes.concurrent) //1
    }
    
    
}
