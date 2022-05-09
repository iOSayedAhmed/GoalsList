//
//  GoalsTableViewCell.swift
//  GoalsList
//
//  Created by Develop on 12/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var category: UILabel!
   
    @IBOutlet weak var priority: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configureCell(goal:GoalModel) {
        title.text = goal.title
        category.text = goal.category
        priority.text = goal.priority
            
    }
    
}
