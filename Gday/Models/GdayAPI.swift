//
//  GdayAPI.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/17/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import Foundation


struct GdayAPI {
  
  static func listGdays(withDate date: Date, completion: @escaping ([Gday]) -> Void){
    GdaysRequest.listAllGdays(withDate: date, completion: { gdays in
      completion(gdays)
    })
  }
}
