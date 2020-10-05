//
//  InstagramVC.swift
//  SocialLogin
//
//  Created by MACBOOK on 22/09/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import UIKit
import WebKit

class InstagramVC: UIViewController {
    
    var instagramApi = InstagramApi.shared
    private var instaVM: InstagramViewModel = InstagramViewModel()

    @IBOutlet weak var webView: WKWebView!{
        didSet {
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: - configUI
    private func configUI() {
        instaVM.delegate = self
        
        instagramApi.authorizeApp { (url) in
            print(url)
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url!))
            }
        }
    }
}

//MARK: - WKNavigationDelegate
extension InstagramVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //Get user id and token
        let request = navigationAction.request
        if let authorizedCode = self.instagramApi.getTokenFromCallbackURL(request: request){
            print(authorizedCode)
            instaVM.getInstagramToken(request: InstagramTokenRequest(code: authorizedCode))
        }
        decisionHandler(.allow)
    }
}

//MARK: - InstaDelegate
extension InstagramVC: InstaDelegate{
    func didRecievedInstagramToken(response: InstagramTokenResponse) {
        print(response)
    }
}
