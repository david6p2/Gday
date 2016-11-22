//
//  UIImageView+Network.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/22/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
  
  func setImage(withURL URL: URL, placeholderImage: UIImage?) {
    af_setImage(withURL: URL, placeholderImage: placeholderImage)
  }
}
