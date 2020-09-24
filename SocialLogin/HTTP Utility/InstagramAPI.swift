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
    
    //MARK: - getFormBody
    private func getFormBody(_ parameters: [[String : String]], _ boundary: String) -> Data {
      var body = ""
      let error: NSError? = nil
      for param in parameters {
        let paramName = param["name"]!
        body += " — \(boundary)\r\n"
        body += "Content-Disposition:form-data; name=\"\(paramName)\""
        if let filename = param["fileName"] {
          let contentType = param["content-type"]!
            var fileContent: String = ""
          do {
            fileContent = try String(contentsOfFile: filename, encoding: String.Encoding.utf8)
          }catch {
            print(error)
          }
          if (error != nil) {
            print(error!)
          }
            body += "; filename=\"\(filename)\"\r\n"
            body += "Content-Type: \(contentType)\r\n\r\n"
          body += fileContent
        } else if let paramValue = param["value"] {
            body += "\r\n\r\n\(paramValue)"
        }
      }
      return body.data(using: .utf8)!
    }
    
    //MARK: - getTestUserIDAndToken
    func getTestUserIDAndToken(request: URLRequest, completion: @escaping (InstagramTestUser) -> Void){
      guard let authToken = getTokenFromCallbackURL(request: request)   else {
        return
      }
      let headers = [
        "content-type": "multipart/form-data; boundary=\(boundary)"
      ]
      let parameters = [
        [
          "name": "app_id",
          "value": instagramAppID
        ],
        [
          "name": "app_secret",
          "value": app_secret
        ],
        [
          "name": "grant_type",
          "value": "authorization_code"
        ],
        [
          "name": "redirect_uri",
          "value": redirectURI
        ],
        [
          "name": "code",
          "value": authToken
        ]
      ]
        var request = URLRequest(url: URL(string:   BaseURL.displayApi.rawValue + Method.access_token.rawValue)!)
      let postData = getFormBody(parameters, boundary)
        request.httpMethod = "POST"
      request.allHTTPHeaderFields = headers
      request.httpBody = postData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) in
          if (error != nil) {
            print(error!)
          } else {
            do { let jsonData = try JSONDecoder().decode(InstagramTestUser.self, from: data!)
              print(jsonData)
              completion(jsonData)
            } catch let error as NSError {
              print(error)
            }
          }
        })

      dataTask.resume()
    }
    
    func postApiData<T:Decodable>(requestUrl: URLRequest, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        guard let authToken = getTokenFromCallbackURL(request: requestUrl)   else {
          return
        }
        let headers = [
          "content-type": "multipart/form-data; boundary=\(boundary)"
        ]
        let parameters = [
          [
            "name": "app_id",
            "value": instagramAppID
          ],
          [
            "name": "app_secret",
            "value": app_secret
          ],
          [
            "name": "grant_type",
            "value": "authorization_code"
          ],
          [
            "name": "redirect_uri",
            "value": redirectURI
          ],
          [
            "name": "code",
            "value": authToken
          ]
        ]
        let postData = getFormBody(parameters, boundary)
        var urlRequest = URLRequest(url: URL(string:   BaseURL.displayApi.rawValue + Method.access_token.rawValue)!)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = postData
        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

            if(data != nil && data?.count != 0)
            {
                do {

                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
}
