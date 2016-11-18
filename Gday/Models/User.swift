//
//  User.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/17/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import UIKit
import ObjectMapper
/*
 "user_id": "1",
 "oauth_access_token": "123abc456def",
 "provider": "google",
 "name": "Juan Perez",
 "email": "mymail@domain.com",
 "picture_url": "https://plus.google.com/u/0/photos/108190374236568857248/albums/profile/6314784854716012578",
 "role": "iOS Developer",
 "site": "CO/BOG/CorpCenterr",
 "password": "aSrcsdasd3123Edad3E"
*/

//MARK: - User
struct User : Mappable {
  
  //MARK: - Structs & Enums
  struct JSONKey {
    static let user_id = "user_id"
    static let oauth_access_token = "oauth_access_token"
    static let provider = "provider"
    static let name = "name"
    static let email = "email"
    static let picture_url = "picture_url"
    static let role = "role"
    static let site = "site"
    static let password = "password"
  }
  
  //MARK: - Properties
  
  var user_id : String!
  var oauth_access_token : String?
  var provider : String?
  var name : String!
  var email : String!
  var picture_url : String?
  var role : String!
  var site : String!
  var password : String?
  
  //MARK: - Initializers
  init?(map: Map){
    guard let _ = map.JSON[JSONKey.user_id] as? String?,
      let _ = map.JSON[JSONKey.name] as? String?,
      let _ = map.JSON[JSONKey.email] as? String?,
      let _ = map.JSON[JSONKey.role] as? String?,
      let _ = map.JSON[JSONKey.site] as? String? else {
        return nil
    }
    
  }
  
  //MARK: - Mappable
  mutating func mapping(map: Map) {
    user_id <- map[JSONKey.user_id]
    oauth_access_token <- map[JSONKey.oauth_access_token]
    provider <- map[JSONKey.provider]
    name <- map[JSONKey.name]
    email <- map[JSONKey.email]
    picture_url <- map[JSONKey.picture_url]
    role <- map[JSONKey.role]
    site <- map[JSONKey.site]
    password <- map[JSONKey.password]
  }
}
