//
//  ViewController.swift
//  GoalsList
//  Created by Develop on 11/6/21.
//  Copyright © 2021 Develop. All rights reserved.
//

import UIKit
import FirebaseAuth

class OnboardingViewController: UIViewController {
    //  @IBOutlet weak var collectionView:UICollectionView()
    @IBOutlet  weak var nextBtn : UIButton!
     @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var slides : [OnboardingSlide] = []
    var timer = Timer()
    var currentPage : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [OnboardingSlide(title: "organize your tasks easily.", descretion: "with to do can add elements and tags to find and complete your tasks efficiently", image: #imageLiteral(resourceName: "second")) , OnboardingSlide(title: "organize your tasks easily.", descretion: "with to do can add elements and tags to find and complete your tasks efficiently", image: #imageLiteral(resourceName: "first")),OnboardingSlide(title: "organize your tasks easily.", descretion: "with to do can add elements and tags to find and complete your tasks efficiently", image: #imageLiteral(resourceName: "third"))]
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.autoSlide), userInfo: nil, repeats: true)
        }
        
    }
    
    
    // to make onboarding screen auto slide
    @objc func autoSlide(){
      
        if(pageControl.currentPage < (slides.count - 1)){
            let index = IndexPath.init(item: currentPage, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            currentPage += 1
        }else {
            currentPage = 0
            let index = IndexPath.init(item: currentPage, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
 
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        let vc = WelcomeToGoalsList()
               vc.modalPresentationStyle = .fullScreen
                   present(vc, animated: true)
        
    }
    
    
    @IBAction func skipBtnClicked(_ sender: UIButton) {
        
//        let vc = WelcomeToGoalsList()
//        vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
    }
    
}
//MARK:- CollectionView Delegate and DataSource

extension OnboardingViewController :UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.Setup(self.slides[indexPath.row])
       // cell.getStartedBtn.isHidden = false
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        pageControl.currentPage  = Int(scrollView.contentOffset.x) / Int(collectionView.frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(collectionView.frame.width)
    }
}

