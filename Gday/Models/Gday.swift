//
//  Gday.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/17/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import UIKit
import ObjectMapper
/*
 "gday_id": "1",
 "created_at": "09/11/2016",
 "gday_start_date": "09/11/2016",
 "gday_finish_date": "09/11/2016",
 "type": "birthday",
 */
public enum GdayType : String {
  case birthday = "birthday"
  case kudos = "kudos"
}

open class GdayTypeTransform : TransformType {
  public typealias Object = GdayType
  public typealias JSON = String
  
  public init() {}
  
  open func transformToJSON(_ value: GdayType?) -> String? {
    
    guard let value = value else {
      return nil
    }
    
    return value.rawValue as String?
  }
  
  open func transformFromJSON(_ value: Any?) -> GdayType? {
    
    guard let value = value as? String else {
      return nil
    }
    
    if value == GdayType.kudos.rawValue {
      return GdayType.kudos
    } else {
      return GdayType.birthday
    }
  }
}

struct Gday : Mappable  {
  
  //MARK: - Structs & Enums
  struct JSONKey {
    static let thumbnailURL = "user.picture_url"
    static let largeImageURL = "user.picture_url"
    static let gdayId = "gday_id"
    static let created_at = "created_at"
    static let gday_start_date = "gday_start_date"
    static let gday_finish_date = "gday_finish_date"
    static let gdayType = "type"
    static let user = "user"
    static let greetings = "greetings"
  }
  
  //MARK: - Properties
  var gdayId : String!
  var created_at : Date!
  var gday_start_date : Date!
  var gday_finish_date : Date!
  var gdayType : GdayType!
  var user : User!
  var greetings : [Greeting]?
  var thumbnailURL : URL?
  var largeImageURL : URL?
  
  
  //MARK: - Initializers
   init?(map: Map) {
    guard let _ = map.JSON[JSONKey.gdayId] as? String?,
      let _ = map.JSON[JSONKey.created_at] as? String?,
      let _ = map.JSON[JSONKey.gday_start_date] as? String?,
      let _ = map.JSON[JSONKey.gday_finish_date] as? String?,
      let _ = map.JSON[JSONKey.gdayType] as? String?,
      let _ = map.JSON[JSONKey.user] as? [String:Any]? else {
        return nil
    }
  }
  
  //MARK: - Mappable
  mutating func mapping(map: Map) {
    gdayId <- map[JSONKey.gdayId]
    created_at <- (map[JSONKey.created_at], DateTransform())
    gday_start_date <- (map[JSONKey.gday_start_date], DateTransform())
    gday_finish_date <- (map[JSONKey.gday_finish_date], DateTransform())
    gdayType <- (map[JSONKey.gdayType], GdayTypeTransform())
    user <- map[JSONKey.user]
    greetings <- map[JSONKey.greetings]
    thumbnailURL <- (map[JSONKey.thumbnailURL], URLTransform())
    largeImageURL <- (map[JSONKey.largeImageURL], URLTransform())
  }
  
  //MARK: - Image Retriving Methods
  func imageURLForGday(_ gday:Gday) -> URL? {
    if let urlString = gday.user.picture_url {
      if let url =  URL(string: urlString) {
        return url
      }
    }
    return nil
  }
  
  /*func loadLargeImage(_ completion: @escaping (_ gday:Gday, _ error: NSError?) -> Void) {
    guard let loadURL = gdayImageURL("b") else {
      DispatchQueue.main.async {
        completion(self, nil)
      }
      return
    }
    
    let loadRequest = URLRequest(url:loadURL)
    
    URLSession.shared.dataTask(with: loadRequest, completionHandler: { (data, response, error) in
      if let error = error {
        DispatchQueue.main.async {
          completion(self, error as NSError?)
        }
        return
      }
      
      guard let data = data else {
        DispatchQueue.main.async {
          completion(self, nil)
        }
        return
      }
      
      let returnedImage = UIImage(data: data)
      self.largeImage = returnedImage
      DispatchQueue.main.async {
        completion(self, nil)
      }
    }).resume()
  }
  
  func sizeToFillWidthOfSize(_ size:CGSize) -> CGSize {
    
    guard let thumbnail = thumbnail else {
      return size
    }
    
    let imageSize = thumbnail.size
    var returnSize = size
    
    let aspectRatio = imageSize.width / imageSize.height
    
    returnSize.height = returnSize.width / aspectRatio
    
    if returnSize.height > size.height {
      returnSize.height = size.height
      returnSize.width = size.height * aspectRatio
    }
    
    return returnSize
  }*/
  
}

func == (lhs: Gday, rhs: Gday) -> Bool {
  return lhs.gdayId == rhs.gdayId
}
