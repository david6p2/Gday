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
  
  /*override func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
    //1
    switch kind {
    //2
    case UICollectionElementKindSectionHeader:
      //3
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: "FlickrPhotoHeaderView",
                                                                       for: indexPath) as! FlickrPhotoHeaderView
      headerView.label.text = searches[(indexPath as NSIndexPath).section].searchTerm
      return headerView
    default:
      //4
      assert(false, "Unexpected element kind")
    }
  }*/
  
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
    
    //let url = URL(string: "https://lh3.googleusercontent.com/aSs3pvEoLsw7hMpgQvZeC8J8ydTVhcDJqX0-MFrspBiOTNR29d6bH6Fm-__jnTCaNFxCzhqv=w1920-h1080-no")!
    //let url = URL(string: "https://lh3.googleusercontent.com/C3FucKbkh-Cw_jV4PAxckjk-530jKK7aCZgqTvaRlEfMG3A6dZylx-1HZycgfvD40wvSmXeu8A=w1920-h1080-no")!
    //cell.imageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "placeholder-user"))
    
    return cell
  }
  
  
/*
  override func collectionView(_ collectionView: UICollectionView,
                               moveItemAt sourceIndexPath: IndexPath,
                               to destinationIndexPath: IndexPath) {
    
    var sourceResults = searches[(sourceIndexPath as NSIndexPath).section].searchResults
    let flickrPhoto = sourceResults.remove(at: (sourceIndexPath as NSIndexPath).row)
    searches[(sourceIndexPath as NSIndexPath).section].searchResults = sourceResults
    
    var destinationResults = searches[(destinationIndexPath as NSIndexPath).section].searchResults
    destinationResults.insert(flickrPhoto, at: (destinationIndexPath as NSIndexPath).row)
    searches[(destinationIndexPath as NSIndexPath).section].searchResults = destinationResults
  }*/
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
