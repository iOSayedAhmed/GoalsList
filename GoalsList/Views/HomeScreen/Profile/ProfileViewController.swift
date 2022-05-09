//
//  ProfileViewController.swift
//  GoalsList
//
//  Created by Develop on 12/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
 
    var name :String?
    let db = Firestore.firestore()
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        usernameLabel.text = name ?? "NoName"
        
        print(name)
         loadData()
        print(Auth.auth().currentUser)
    }
    
    func loadData()  {
        db.collection("users").getDocuments { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            }else {
                guard let snap = snapshot else {return}
                for document in snap.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? "NoName"
                    self.name = name
                }
            }
        }
    }
    
    @IBAction func LogoutBtnClicked(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let vc = storyboard?.instantiateViewController(withIdentifier: "onboardVC") as! OnboardingViewController
            self.present(vc, animated: true, completion: nil)
        }catch let error {
            errorAlertShow(msg: error.localizedDescription)
        }
        
    }
    

}
