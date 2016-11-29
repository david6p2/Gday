//
//  GdayViewController.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/24/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import Foundation
import UIKit

let greetingPageViewCellIdentify = "greetingPageViewCellIdentify"

class GdayViewController : UICollectionViewController, UINavigationControllerDelegate {
  
  @IBOutlet var gdayCollectionView: UICollectionView!
  
  var gday : Gday? = nil
  var pullOffset = CGPoint.zero
  
  init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: IndexPath){
    super.init(collectionViewLayout:layout)
    let collectionView :UICollectionView = self.collectionView!;
    collectionView.isPagingEnabled = true
    collectionView.register(GreetingCell.self, forCellWithReuseIdentifier: greetingPageViewCellIdentify)
    //collectionView.setToIndexPath(indexPath)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad(){
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.delegate = self
  }
  
  // MARK: - UINavigationControllerDelegate
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationControllerOperation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if operation == .pop {
      let animator = PushFromCollectionViewTransitionAnimation()
      animator.presenting = false
      return animator
    } else {
      return nil
    }
  }
  
  
  
  
}

// MARK: - Private
private extension GdayViewController {
  func greetingForIndexPath(_ indexPath: IndexPath) -> Greeting{
    return (gday?.greetings![(indexPath as NSIndexPath).row])!
    
  }
  
}

// MARK: - UICollectionViewDataSource
extension GdayViewController {
  
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int{
    return (self.gday?.greetings?.count)!;
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    let collectionCell: GreetingCell = collectionView.dequeueReusableCell(withReuseIdentifier: greetingPageViewCellIdentify, for: indexPath) as! GreetingCell
    if let imageURL = self.greetingForIndexPath(indexPath).greetingURL {
      collectionCell.imageView.setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder-user"))
    }
    collectionCell.tappedAction = {}
    collectionCell.pullAction = { offset in
      
    }
    collectionCell.setNeedsLayout()
    return collectionCell
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GdayViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return self.navigationController!.isNavigationBarHidden ?
      CGSize(width: screenWidth, height: screenHeight+20) : CGSize(width: screenWidth, height: screenHeight-navigationHeaderAndStatusbarHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
