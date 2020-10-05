//
//  AppDelegate.swift
//  SocialLogin
//
//  Created by MACBOOK on 22/09/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import IQKeyboardManagerSwift
import SainiUtils

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    //MARK: - sharedDelegate
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK:- Loader
     func showLoader()
     {
         removeLoader()
         window?.isUserInteractionEnabled = false
         activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
         activityLoader.type = .ballPulse
         activityLoader.color = UIColor.gray
         window?.addSubview(activityLoader)
         activityLoader.startAnimating()
     }
     
     func removeLoader()
     {
         window?.isUserInteractionEnabled = true
         if activityLoader == nil
         {
             return
         }
         activityLoader.stopAnimating()
         activityLoader.removeFromSuperview()
         activityLoader = nil
     }
     
}

