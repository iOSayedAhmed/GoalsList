//
//  AllGoalsListsViewController.swift
//  GoalsList
//
//  Created by Develop on 11/9/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class GoalsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var Goals = [GoalModel]()
   // var ref : DocumentReference? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "GoalsTableViewCell", bundle: nil), forCellReuseIdentifier: "goalsCell")
        
        self.title = "GoalsList"
       // loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    //MARK:- Functions
   
    
    func loadData() {
        db.collection("goals").getDocuments(){ snapshot,error in
            if let err = error {
                print("\(err.localizedDescription)")
            }else {
                //success
                guard let snap = snapshot else{return}
                for document in snap.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? "Title"
                    let desc = data["description"] as? String ?? "description"
                    let category = data["category"] as? String ?? "category"
                    let priority = data["priority"] as? String ?? "priority"
                    let documentID = document.documentID
                    
                    
                    let newGoal = GoalModel(title: title, description: desc, category: category, priority: priority,documentID:documentID)
                    
                    self.Goals.append(newGoal)
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
            
        }
        
    }
    
    func deleteDocumentFromFirestore() {
        db.collection("goals").document().delete { (error) in
            
        
       }

    
    }
    
}
//MARK:- Extension TableView dataSource
extension GoalsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalsCell") as! GoalsTableViewCell
        cell.configureCell(goal: Goals[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("========>:\(indexPath)")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        vc.goals = Goals[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    // add swipeable tableView
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, boolValue) in
            print("====== > Deleted ")
            self.Goals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.deleteDocumentFromFirestore()
            self.tableView.reloadData()
           // self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let edit = UIContextualAction(style: .destructive, title: "Edit") { (action, view, boolValue) in
            print("=====> Editing")
            
        }
        edit.backgroundColor = .orange
        
        let swipeAction = UISwipeActionsConfiguration(actions: [delete , edit])
        return swipeAction
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
//            print(index)
//        }
//        return[delete]
//    }
    
    
    
}

