//
//  InstagramAPI.swift
//  SocialLogin
//
//  Created by MACBOOK on 22/09/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import Foundation

class InstagramApi {
    
    static let shared = InstagramApi()
    private let instagramAppID = "1060027197813287"
    private let redirectURI = "https://socialsizzle.heroku.com/auth/"
    private let app_secret = "1fa47f5322c8601e0d5edf84c34483cc"
    private let scope = "user_profile,user_media"
    private let responseType = "code"
    private let boundary = "boundary=\(NSUUID().uuidString)"
    private init () {}
    
    //MARK: - BaseURL
    private enum BaseURL: String {
        case displayApi = "https://api.instagram.com/"
    }
    
    //MARK: - Method
    private enum Method: String {
        case authorize = "oauth/authorize"
        case access_token = "oauth/access_token"
    }
    
    //MARK: - authorizeApp
    func authorizeApp(completion: @escaping (_ url: URL?) -> Void ) {
        let urlString = "\(BaseURL.displayApi.rawValue)\(Method.authorize.rawValue)?app_id=\(instagramAppID)&redirect_uri=\(redirectURI)&scope=\(scope)&response_type=\(responseType)"
        let request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let response = response {
                print(response)
                completion(response.url)
            }
        })
        task.resume()
    }
    
    //MARK: - getTokenFromCallbackURL
    func getTokenFromCallbackURL(request: URLRequest) -> String? {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.starts(with: "\(redirectURI)?code=") {
            print("Response uri:",requestURLString)
            if let range = requestURLString.range(of: "\(redirectURI)?code=") {
                let authorization = String(requestURLString[range.upperBound...].dropLast(2))
                return authorization
            }
        }
        return nil
    }
}
