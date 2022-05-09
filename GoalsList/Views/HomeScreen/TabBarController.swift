//
//  TabBarController.swift
//  GoalsList
//
//  Created by Develop on 12/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate{

    private let addButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.setImage(UIImage(named: "8"), for: .normal)
        //button.backgroundColor = .black
        button.setBackgroundImage(UIImage(named: "8"), for: .normal)
        button.tintColor = .link
        button.addTarget(self, action: #selector(addBtnClicked( _ :)), for: .touchUpInside)
        return button
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.barTintColor = #colorLiteral(red: 0.02704546583, green: 0.176808325, blue: 0.4949238579, alpha: 1)
        tabBar.tintColor = .white
        view.addSubview(addButton)
        addConstrains()
        
//createButton()
    }
    
    private func addConstrains(){
        var constraints = [NSLayoutConstraint]()
        // Add Constrains
        constraints.append(addButton.widthAnchor.constraint(equalToConstant: 60))
        constraints.append(addButton.heightAnchor.constraint(equalToConstant: 60))
        constraints.append(addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(addButton.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.topAnchor, constant: 25))

        

        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
       
        
    }


    @objc func addBtnClicked(_ sender:UIButton) {

        let vc = storyboard?.instantiateViewController(identifier: "popup") as! PoPupViewController
        present(vc, animated: true, completion: nil)
    }

}
