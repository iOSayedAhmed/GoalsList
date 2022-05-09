//
//  DetailsViewController.swift
//  GoalsList
//
//  Created by Develop on 12/8/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabl: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    var goals : GoalModel!
    
    /*
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Details"
        label.contentMode = .center
        label.textColor = .black
        label.backgroundColor = .brown
        
        return label
    }()
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(titlelabel)
       // addConstraints()
    
      //  self.navigationController?.title = "details"
        titleLabl.text = goals.title
        descTextView.text = goals.description
        categoryLabel.text = goals.category
        priorityLabel.text = goals.priority
    
    }
    
    /*
    var constraints = [NSLayoutConstraint]()
    
    func addConstraints() {
        //Add
        constraints.append(titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(titlelabel.topAnchor.constraint(equalTo: , constant: 20))
        constraints.append(titlelabel.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(titlelabel.heightAnchor.constraint(equalToConstant: 50))
        
        
        //Activate
        NSLayoutConstraint.activate(constraints)
    }
    */
    

   

}
