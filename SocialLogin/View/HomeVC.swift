//
//  HomeVC.swift
//  SocialLogin
//
//  Created by MACBOOK on 22/09/20.
//  Copyright © 2020 SukhmaniKaur. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let STORYBOARD = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - signUpWithInstagramBtnIsPressed
    @IBAction func signUpWithInstagramBtnIsPressed(_ sender: UIButton) {
        let vc = STORYBOARD.instantiateViewController(withIdentifier: "InstagramVC") as! InstagramVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - signUpWithGoogleBtnIsPressed
    @IBAction func signUpWithGoogleBtnIsPressed(_ sender: UIButton) {
    }
    
    //MARK: - signUpWithFacebookBtnIsPressed
    @IBAction func signUpWithFacebookBtnIsPressed(_ sender: UIButton) {
    }
    
    //MARK: - signUpWithAppleBtnIsPressed
    @IBAction func signUpWithAppleBtnIsPressed(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
