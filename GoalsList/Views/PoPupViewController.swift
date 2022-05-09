//
//  PoPupViewController.swift
//  GoalsList
//
//  Created by Develop on 12/8/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import DropDown
import FirebaseFirestore

class PoPupViewController: UIViewController {
    @IBOutlet weak var goalTitleTextField: UITextField!
    @IBOutlet weak var goalCategoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var goalDescriptionTextField: UITextField!
    @IBOutlet weak var goalpriorityView: UIView!
    @IBOutlet weak var goalPriorityLabel: UILabel!
    
    // Configure Firebase FireStore
    var ref: DocumentReference? = nil
    let db = Firestore.firestore()
    
    let categoryMenu : DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "Work",
            "Personal",
            "Learnning"
        ]
        return menu
        
    }()
    
    let priorityMenu : DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "Important and Urgent",
            "Important but not Urgent",
            "Not Important and Urgent",
            "Not Important and not Urgent"
        ]
        return menu
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  categoryMenu
        categoryMenu.anchorView  = categoryView
        categoryMenu.bottomOffset = CGPoint(x: 0, y: goalCategoryLabel.frame.height)
        categoryMenu.topOffset = CGPoint(x: 0, y: -(goalCategoryLabel.frame.height))
        categoryMenu.direction = .bottom
        
        
        //   priorityMenu
        priorityMenu.anchorView  = goalpriorityView
        priorityMenu.bottomOffset = CGPoint(x: 0, y: goalPriorityLabel.frame.height)
        priorityMenu.topOffset = CGPoint(x: 0, y: -(goalPriorityLabel.frame.height))
        priorityMenu.direction = .bottom
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(categoryGestureClicked))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        categoryView.addGestureRecognizer(gesture)
        categoryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        let priorityGesture = UITapGestureRecognizer(target: self, action: #selector(PrioritygestureClicked))
        priorityGesture.numberOfTouchesRequired = 1
        priorityGesture.numberOfTapsRequired = 1
        goalpriorityView.addGestureRecognizer(priorityGesture)
        priorityMenu.translatesAutoresizingMaskIntoConstraints = false
        
        // DropDwonList for Category Field
        categoryMenu.selectionAction = {index , item in
            self.goalCategoryLabel.text = item
            self.goalCategoryLabel.textColor = .black
            print("selected : \(index)and title : \(item)")
        }
        // DropDwonList for Priority Field
        priorityMenu.selectionAction = {index, item in
            self.goalPriorityLabel.text = item
            self.goalPriorityLabel.textColor = .black
            print("Selected : \(index), item : \(item)")
        }
        
    }
    
    // MARK:- Functions
    /// function to check if All fields all filled or not
    func validateTextField() -> String?{
        if goalTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || goalDescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please Fill All Fields ..."
        }
        return nil
    }
    @objc  func categoryGestureClicked() {
        
        categoryMenu.show()
    }
    
    @objc  func PrioritygestureClicked() {
        
        priorityMenu.show()
    }
    
    
    
    
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        guard let goalCategory = goalCategoryLabel.text , let goalPriority = goalPriorityLabel.text, let title = goalTitleTextField.text, let desc = goalDescriptionTextField.text else {return}
        
         let error = validateTextField()
        // pass Data to fireStore
        
        if error == nil {
            // All Fields is filled
            ref = db.collection("goals").addDocument(data: [
                "title":title,
                "description":desc,
                "category":goalCategory,
                "priority":goalPriority
            ]){ error in
                if let err = error {
                    
                    print("Error to Save Data to FireStore : \(err.localizedDescription)")
                    
                }else {
                    //Success
                    print("\(String(describing: self.ref?.documentID))")
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        }else {
            errorAlertShow(msg: error ?? "Please Fill All Fields ...")
            
        }
        
    }
    
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
