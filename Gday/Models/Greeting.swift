//
//  Greeting.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/17/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import UIKit
import ObjectMapper
/*
 "greeting_id": "1",
 "gday_id": "1",
 "created_at": "09/11/2016",
 "type": "photo",
 "from_user": {
  "user_id": "1",
  "oauth_access_token": "123abc456def",
  "provider": "google",
  "name": "Juan Perez",
  "email": "mymail@domain.com",
  "picture_url": "https://plus.google.com/u/0/photos/108190374236568857248/albums/profile/6314784854716012578",
  "role": "iOS Developer",
  "site": "CO/BOG/CorpCenterr",
  "password": "aSrcsdasd3123Edad3E"
 },
 "to_user": {
  "user_id": "1",
  "oauth_access_token": "123abc456def",
  "provider": "google",
  "name": "Juan Perez",
  "email": "mymail@domain.com",
  "picture_url": "https://plus.google.com/u/0/photos/108190374236568857248/albums/profile/6314784854716012578",
  "role": "iOS Developer",
  "site": "CO/BOG/CorpCenterr",
  "password": "aSrcsdasd3123Edad3E"
 },
 "greeting_url": "https://marvelapp-live.storage.googleapis.com/serve/f91d97b60a954d1ea147cbc560b5aaba.jpg"
 }
*/

public enum GreetingType : String {
  case photo = "photo"
  case video = "video"
}

open class GreetingTypeTransform : TransformType {
  public typealias Object = GreetingType
  public typealias JSON = String
  
  public init() {}
  
  open func transformToJSON(_ value: GreetingType?) -> String? {
    
    guard let value = value else {
      return nil
    }
    
    return value.rawValue as String?
  }
  
  open func transformFromJSON(_ value: Any?) -> GreetingType? {
    
    guard let value = value as? String else {
      return nil
    }
    
    if value == GreetingType.video.rawValue {
      return GreetingType.video
    } else {
      return GreetingType.photo
    }
  }
}

//MARK: - Greeting
struct Greeting : Mappable {
  //MARK: - Structs & Enums
  struct JSONKey {
    static let greeting_id = "greeting_id"
    static let gday_id = "gday_id"
    static let created_at = "created_at"
    static let greetingType = "type"
    static let fromUser = "from_user"
    static let toUser = "to_user"
    static let greetingURL = "greeting_url"
  }
  
  //MARK: - Properties
  var greeting_id : String!
  var gday_id : String!
  var created_at : Date!
  var greetingType : GreetingType!
  var fromUser : User!
  var toUSer : User!
  var greetingURL : URL?
  
  //MARK: - Initializers
  init?(map: Map){
    guard let _ = map.JSON[JSONKey.greeting_id] as? String?,
      let _ = map.JSON[JSONKey.gday_id] as? String?,
      let _ = map.JSON[JSONKey.created_at] as? String?,
      let _ = map.JSON[JSONKey.greetingType] as? String?,
      let _ = map.JSON[JSONKey.fromUser] as? [String:Any]?,
      let _ = map.JSON[JSONKey.toUser] as? [String:Any]?else {
        return nil
    }
    
  }
  
  //MARK: - Mappable
  mutating func mapping(map: Map) {
    greeting_id <- map[JSONKey.greeting_id]
    gday_id <- map[JSONKey.gday_id]
    created_at <- (map[JSONKey.created_at], DateTransform())
    greetingType <- (map[JSONKey.greetingType], GreetingTypeTransform())
    fromUser <- map[JSONKey.fromUser]
    toUSer <- map[JSONKey.toUser]
    greetingURL <- (map[JSONKey.greetingURL], URLTransform())
  }
  
  
}
