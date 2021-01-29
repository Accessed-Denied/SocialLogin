//
//  InstagramViewModel.swift
//  SocialLogin
//
//  Created by MACBOOK on 06/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import SainiUtils

protocol InstaDelegate {
    func didRecievedInstagramToken(response: InstagramTokenResponse)
}

struct InstagramViewModel {
    
    var delegate: InstaDelegate?
    
    func getInstagramToken(request: InstagramTokenRequest){
        GCD.USER.InstagramToken.async {
            APIManager.sharedInstance.I_AM_DAMN_COOL(params: request.toJSON(), api: API.USER.InstagramToken, Loader: false, isMultipart: false) { (response) in
                if response != nil{                             //if response is not empty
                    do {
                        let success = try JSONDecoder().decode(InstagramTokenResponse.self, from: response!) // decode the response into success model
                        print(success)
                        self.delegate?.didRecievedInstagramToken(response: success)
                    }
                    catch let err {
                        log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                    }
                }
            }
        }
    }
}
