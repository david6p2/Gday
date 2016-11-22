//
//  GdaysRequest.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/18/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct GdaysRequest {
  
  private struct JSONKey {
    static let date = "date"
  }
  
  static func listAllGdays(withDate date: Date, completion: @escaping ([Gday]) -> Void){
    Alamofire.request(Router.readGdays(date: Date.init()))
      .validate()
      .responseArray{ (response: DataResponse<[Gday]>) in
        switch response.result {
        case .success:
          guard let gdays = response.result.value else {
            print("Invalid Gdays information received from service")
            completion([Gday]())
            return
          }
          //print("This are the Gdays: \(gdays)")
          completion(gdays)
          
        case .failure(let error):
          print(response.request ?? "NO URL")
          print(" This is the error: \(error)")
          return
        }
      }
  }
  
}
