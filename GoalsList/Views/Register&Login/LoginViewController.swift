//
//  LoginViewController.swift
//  GoalsList
//
//  Created by Develop on 11/7/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var createProfileBtn: UIButton!
    @IBOutlet weak var emailTxtFaild: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxtFaild.customTextField(textfeild: emailTxtFaild, placeholder: "Email", .lightGray)
        passwordTxtField.customTextField(textfeild: passwordTxtField, placeholder: "Password", .lightGray)
        createProfileBtn.createLineUnderView(width:15)
        
        
        //        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        //
        
        
        
        
    }
    //MARK:- Functions
    func presentHomeScreen() {
        let vc = storyboard?.instantiateViewController(identifier: "tabBar") as! TabBarController
        present(vc, animated: true, completion: nil)
    }
    func validateFields() -> String? {
        if emailTxtFaild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" &&
            passwordTxtField.text!.count >= 6
        {
            return "Please Fill all fields "
        }
        return nil
        
    }
    
    //MARK:- IBActions 
    
    @IBAction func dontHaveAccount(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signinBtnClicked(_ sender: UIButton) {
        
        // Validate all fields
        let error = validateFields()
        if error != nil {
            self.errorAlertShow(msg: error!)
            print(error!)
        }else {
            // create Clean variable
            guard let email = emailTxtFaild.text?.trimmingCharacters(in: .whitespacesAndNewlines) , let password = passwordTxtField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else{return}
            // Sign in user here
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    guard let err = error?.localizedDescription else {return}
                    self.errorAlertShow(msg: err)
                    print(" faild to sign in user />>>>>>",err)
                    
                }else {
                    // transetion to home Screen
                    self.presentHomeScreen()
                    
                }
            }
            
            
        }
    }
    
    
    
    @IBAction func googleSigninBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func createProfileBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
//MARK:- Extension
extension LoginViewController {
    
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

