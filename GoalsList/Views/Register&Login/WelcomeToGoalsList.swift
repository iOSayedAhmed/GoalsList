//
//  LoginAndRegisterViewController.swift
//  GoalsList
//
//  Created by Develop on 11/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeToGoalsList: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
            }
  

    @IBAction func signupBtnClicked(_ sender: UIButton) {
        showSignUpScreen()
      
    }
    
    @IBAction func signinBtnClicked(_ sender: UIButton) {
        showSignInScreen()
        
    }
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension WelcomeToGoalsList {
    
    func showSignUpScreen() {
        if let signupVC = storyboard?.instantiateViewController(identifier: "signupVC") as? RegisterViewController {
            present(signupVC, animated: true, completion: nil)
        }
    }
    
    func showSignInScreen() {
        if let signinVC = storyboard?.instantiateViewController(identifier: "signinVC") as? LoginViewController {
            present(signinVC, animated: true, completion: nil)
        }
    }
}



