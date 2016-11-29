//
//  PushFromCollectionViewTransitionAnimation.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/29/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import UIKit

class PushFromCollectionViewTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
  
  var presenting = false
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.35
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    if presenting {
      animatePush(transitionContext)
    } else {
      animatePop(transitionContext)
    }
  }
  
  func getCellImageView(_ viewController: UICollectionViewController) -> UIImageView {
    var indexPath = IndexPath()
    var cell = UICollectionViewCell()
    if (viewController.isMember(of: GdaysViewController.self)) {
      indexPath = (viewController as! GdaysViewController).lastSelectedIndexPath!
      cell = viewController.collectionView!.cellForItem(at: indexPath as IndexPath) as! GdayCell
      return (cell as! GdayCell).imageView
    }else if(viewController.isMember(of: GdayViewController.self)){
      let index : Int = Int((viewController as! GdayViewController).gdayCollectionView!.contentOffset.x/(viewController as! GdayViewController).gdayCollectionView!.frame.size.width)
      indexPath = IndexPath.init(row: index, section: 0)
      cell = (viewController as! GdayViewController).gdayCollectionView!.cellForItem(at: indexPath as IndexPath) as! GreetingCell
      return (cell as! GreetingCell).imageView
    }
    return UIImageView()
  }
  
  func animatePush(_ transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! GdaysViewController
    let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! GdayViewController
    
    toVC.view.setNeedsLayout()
    toVC.view.layoutIfNeeded()
    
    let fromImageView = getCellImageView(fromVC)
    let toImageView = getCellImageView(toVC)
    
    //Changed to work in iPhone 7 Simulator
    //http://stackoverflow.com/questions/40188089/swift-3-why-does-the-snapshot-from-snapshotview-appears-blank-in-iphone-7-plus
    //guard let snapshot = fromImageView.snapshotView(afterScreenUpdates: false) else { return }
    guard let snapshot = fromImageView.snapshotView() else { return }
    
    fromImageView.isHidden = true
    toImageView.isHidden = true
    
    let backdrop = UIView(frame: toVC.view.frame)
    backdrop.backgroundColor = toVC.view.backgroundColor
    container.addSubview(backdrop)
    backdrop.alpha = 0
    toVC.view.backgroundColor = UIColor.clear
    
    toVC.view.alpha = 0
    let finalFrame = transitionContext.finalFrame(for: toVC)
    var frame = finalFrame
    frame.origin.y += frame.size.height
    toVC.view.frame = frame
    container.addSubview(toVC.view)
    
    snapshot.frame = container.convert(fromImageView.frame, from: fromImageView)
    container.addSubview(snapshot)
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext)
      , animations: {
        
        backdrop.alpha = 1
        toVC.view.alpha = 1
        toVC.view.frame = finalFrame
        snapshot.frame = container.convert(toImageView.frame, from: toImageView)
        
    }, completion: { (finished) in
      
      toVC.view.backgroundColor = backdrop.backgroundColor
      backdrop.removeFromSuperview()
      
      fromImageView.isHidden = false
      toImageView.isHidden = false
      snapshot.removeFromSuperview()
      
      transitionContext.completeTransition(finished)
    })
  }
  
  func animatePop(_ transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! as! GdayViewController
    let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! as! GdaysViewController
    
    let fromImageView = getCellImageView(fromVC)
    let toImageView = getCellImageView(toVC)
    
    //Changed to work in iPhone 7 Simulator
    //http://stackoverflow.com/questions/40188089/swift-3-why-does-the-snapshot-from-snapshotview-appears-blank-in-iphone-7-plus
    //guard let snapshot = fromImageView.snapshotView(afterScreenUpdates: false) else { return }
    guard let snapshot = fromImageView.snapshotView() else { return }
    
    fromImageView.isHidden = true
    toImageView.isHidden = true
    
    let backdrop = UIView(frame: fromVC.view.frame)
    backdrop.backgroundColor = fromVC.view.backgroundColor
    container.insertSubview(backdrop, belowSubview: fromVC.view)
    backdrop.alpha = 1
    fromVC.view.backgroundColor = UIColor.clear
    
    let finalFrame = transitionContext.finalFrame(for: toVC)
    toVC.view.frame = finalFrame
    
    var frame = finalFrame
    frame.origin.y += frame.size.height
    container.insertSubview(toVC.view, belowSubview: backdrop)
    
    snapshot.frame = container.convert(fromImageView.frame, from: fromImageView)
    container.addSubview(snapshot)
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext)
      , animations: {
        
        backdrop.alpha = 0
        fromVC.view.frame = frame
        snapshot.frame = container.convert(toImageView.frame, from: toImageView)
        
    }, completion: { (finished) in
      
      fromVC.view.backgroundColor = backdrop.backgroundColor
      backdrop.removeFromSuperview()
      
      fromImageView.isHidden = false
      toImageView.isHidden = false
      snapshot.removeFromSuperview()
      
      transitionContext.completeTransition(finished)
    })
  }
}

public extension UIView {
  
  public func snapshotImage() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
    drawHierarchy(in: bounds, afterScreenUpdates: false)
    let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return snapshotImage
  }
  
  public func snapshotView() -> UIView? {
    if let snapshotImage = snapshotImage() {
      return UIImageView(image: snapshotImage)
    } else {
      return nil
    }
  }
}
