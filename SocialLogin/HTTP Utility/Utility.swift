//
//  Utility.swift
//  SocialLogin
//
//  Created by MACBOOK on 06/10/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation
import Toaster
import UIKit

func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}

//MARK:- Toast
func displayToast(_ message:String)
{
    let toast = Toast(text: NSLocalizedString(message, comment: ""))
    toast.show()
}

//MARK:- toJson
func toJson(_ dict:[String:Any]) -> String{
    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString!
}

//MARK: - getCurrentTimeStampValue
func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}
