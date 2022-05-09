//
//  RegisterViewController.swift
//  GoalsList
//
//  Created by Develop on 11/7/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var googleSignupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.customTextField(textfeild: nameTextField, placeholder: "Name", .lightGray)
        emailTextField.customTextField(textfeild: emailTextField, placeholder: "Email", .lightGray)
        passwordTextField.customTextField(textfeild: passwordTextField, placeholder: "Password", .lightGray)
        signinBtn.createLineUnderView(width: 70)
        
        
    }
    
    
    // MARK:- Functions
    func presentHomeScreen() {
        let vc = storyboard?.instantiateViewController(identifier: "tabBar") as! TabBarController
        present(vc, animated: true, completion: nil)
    }
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
    func ValidateFiels() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordTextField.text!.count >= 6
        {
            return "Please fill all fields ...  "
        }
        return nil
    }
    
    
    
    
    //MARK:- IBActions
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        // validate all fields
        let error = ValidateFiels()
        if error != nil{
            print(">>>>>>>>>>",error!)
            errorAlertShow(msg: error as! String)
        }else {
            //Create Cleaned Variable from fields
            
            guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            
            // create users
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    guard let error = err?.localizedDescription else {return}
                    // there was error
                    self.errorAlertShow(msg: error)
                    print(">> error 2",error)
                   
                }else {
                    // Create user successfuly , Now Store the user data in Firestore
                    guard let userID = result?.user.uid else {return}
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":name,"uid":userID]) { (error) in
                        if error != nil {
                            //couldn't Save name and userID in store
                            print("Error to Save Data in store ... ")
                        }
                    }
                    // transition to home screen
                    
                    self.presentHomeScreen()
                    
                }
            }
        }
        
        
    }
    
    @IBAction func googleSignupBtnClicked(_ sender: UIButton) {
    }
    
    @IBAction func alreadyHaveAccount(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
       
    }
    @IBAction func signinBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
