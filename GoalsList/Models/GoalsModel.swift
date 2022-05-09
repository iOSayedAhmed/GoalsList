//
//  GoalsModel.swift
//  GoalsList
//
//  Created by Develop on 12/11/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import Foundation

protocol documentSerilizable {
    init?(dictionary:[String:Any])
}

struct GoalModel {
    var title:String
    var description:String
    var category:String
    var priority:String
    var documentID : String
    
//    var dictionary : [String:Any]{
//        return [
//            "title":title,
//            "description":description,
//            "category":category,
//            "priority":priority
//        ]
//
//
//    }
    
}
 
