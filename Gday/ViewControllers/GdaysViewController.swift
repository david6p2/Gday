//
//  GdaysViewController.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/17/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import UIKit

final class GdaysViewController: UICollectionViewController {
  
  // MARK: - Properties
  fileprivate let reuseIdentifier = "GdayCell"
  fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
  fileprivate var gdays = [Gday]()
  fileprivate let gdayAPI = GdayAPI()
  fileprivate let itemsPerRow: CGFloat = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewController()
  }
  
  //MARK: - Setup
  private func setupViewController() {
    
    GdayAPI.listGdays(withDate: Date(), completion: { gdays in
      self.gdays = gdays
      self.title = "GDays"
      self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
      self.navigationController?.navigationBar.barTintColor = UIColor.gray
      self.collectionView?.reloadData()
      
      print("This are the gdays: \(gdays)")
      print("This is the Gday Type: \(gdays[0].gdayType) and User: \(gdays[0].user.name) and GreetingType: \(gdays[0].greetings?[0].greetingType) and Picture URL: \(gdays[1].thumbnailURL)")
    })
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "ShowGdayGreetings" {
      let destinationVC: GdayViewController = segue.destination as! GdayViewController
      if let indexPathRow = self.collectionView?.indexPathsForSelectedItems?[0].row {
        destinationVC.gday = self.gdays[indexPathRow]
      }
    }
  }

}




// MARK: - Private
private extension GdaysViewController {
  func gdayForIndexPath(_ indexPath: IndexPath) -> Gday{
    return gdays[(indexPath as NSIndexPath).row]
  }
  
}

// MARK: - UICollectionViewDataSource
extension GdaysViewController {
  //1
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  //2
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return gdays.count
  }
  
  //3
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! GdayCell
    
    let gday = gdayForIndexPath(indexPath)
    
    cell.backgroundColor = UIColor.lightGray
    cell.gdayTypeLabel.text = gday.gdayType.rawValue.capitalized
    cell.userNameLabel.text = gday.user.name
    cell.userRoleLabel.text = gday.user.role
    
    //cell.activityIndicator.stopAnimating()
    
    //guard indexPath == largePhotoIndexPath else {
    //  cell.imageView.image = flickrPhoto.thumbnail
    //  return cell
    //}
    
    //guard flickrPhoto.largeImage == nil else {
    //  cell.imageView.image = flickrPhoto.largeImage
    //  return cell
    //}
    if let imageURL = gday.thumbnailURL {
      cell.imageView.setImage(withURL: imageURL, placeholderImage: UIImage(named: "placeholder-user"))
    }
    return cell
  }
  
  /*
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
    let pageViewController =
      GdayViewController(collectionViewLayout: pageViewControllerLayout(), currentIndexPath:indexPath, withGday: gdayForIndexPath(indexPath))
    navigationController!.pushViewController(pageViewController, animated: true)
  }
 
  
  func pageViewControllerLayout () -> UICollectionViewFlowLayout {
    let flowLayout = UICollectionViewFlowLayout()
    let itemSize  = self.navigationController!.isNavigationBarHidden ?
      CGSize(width: screenWidth, height: screenHeight+20) : CGSize(width: screenWidth, height: screenHeight-navigationHeaderAndStatusbarHeight)
    flowLayout.itemSize = itemSize
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.scrollDirection = .horizontal
    return flowLayout
  }
 */
  
  
}


// MARK: - UICollectionViewDelegateFlowLayout
extension GdaysViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
