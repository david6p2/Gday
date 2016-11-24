//
//  GreetingCell.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/24/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import UIKit

class GreetingCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  
  var pullAction : ((_ offset : CGPoint) -> Void)?
  var tappedAction : (() -> Void)?
  
  
}
