//
//  Router.swift
//  Gday
//
//  Created by David Andres Cespedes on 11/18/16.
//  Copyright © 2016 David Andres Cespedes. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
  //case createUser(parameters: Parameters)
  //case readUser(username: String)
  //case updateUser(username: String, parameters: Parameters)
  //case destroyUser(username: String)
  
  //Gdays Collection
  case readGdays(date: Date?)
  
  static let baseURLString = "https://private-9ed5d-gday1.apiary-mock.com/v1"
  
  var method: HTTPMethod {
    switch self {
    case .readGdays:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .readGdays(let date):
      //return "/gdays/\(date)"
      return "/gdays"
    }
  }
  
  // MARK: URLRequestConvertible
  
  func asURLRequest() throws -> URLRequest {
    let url = try Router.baseURLString.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    
    //switch self {
    //case .createUser(let parameters):
    //  urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    //case .updateUser(_, let parameters):
    //  urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
    //default:
    //  break
    //}
    
    return urlRequest
  }
}
