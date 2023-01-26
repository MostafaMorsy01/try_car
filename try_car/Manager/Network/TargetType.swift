//
//  TargetType.swift
//  El Rass
//
//  Created by admin on 16/08/2022.
//

import Foundation
import Alamofire

enum httpMethod: String {
    case Get = "GET"
    case Post = "POST"
    case Delete = "DELETE"
}

enum parameterType {
    case plainRequest
    case plainRequest1(Parameters:[String:Any])
    case parameterRequest(Parameters:[String:Any], Encoding: ParameterEncoding)
    
}

protocol TargetType {
    var url: String {get}
    var method: httpMethod{get}
    var parameter: parameterType {get}
    var header: [String:String]? {get}
}
