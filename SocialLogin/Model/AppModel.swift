//
//  AppModel.swift
//  SocialLogin
//
//  Created by MACBOOK on 06/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

//MARK: - AppModel
class AppModel: NSObject {
    static let shared = AppModel()
    var isSocialLogin: Bool = Bool()
    var fcmToken: String = ""
    var accessToken = ""
}
