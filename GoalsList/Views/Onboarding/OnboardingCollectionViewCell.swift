//
//  OnboardingCollectionViewCell.swift
//  GoalsList
//
//  Created by Develop on 11/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

  static  let identifier  = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var slideLabel: UILabel!
    
    @IBOutlet weak var slideTextView: UILabel!
    
    
    func Setup(_ slide : OnboardingSlide) {
        slideLabel.text = slide.title
        slideTextView.text = slide.descretion
        slideImageView.image = slide.image
        
    }
}
    
