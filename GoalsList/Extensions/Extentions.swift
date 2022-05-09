//
//  Extentions.swift
//  GoalsList
//
//  Created by Develop on 11/7/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit

extension UIViewController {
    func errorAlertShow(msg:String) {
           let Alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
           Alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           present(Alert, animated: true, completion: nil)
       }
}


//MARK:- Create custom Textfield 
class customTextField: UITextField {
    
    // Create Line Under TextField
    // can use AwekeFronNib instead of LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        let line = CALayer()
        line.frame = CGRect(x: 0.0, y: self.bounds.height, width: self.bounds.width, height: 2)
        line.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(line)
        
    }
    
}


class Functions: UIViewController {
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
 
