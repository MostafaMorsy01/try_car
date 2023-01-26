//
//  BaseNetwork.swift
//  El Rass
//
//  Created by admin on 16/08/2022.
//

import Foundation
import Alamofire

final class BaseNetwork<T:TargetType>{

    static func request<M:Codable>(Target:T,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
    
        
        
        AF.request(Target.url, method: method ,parameters: parameters.0, encoding: parameters.1, headers: headers)
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )

                        }else{
                            completion(false, nil, "serialization error" )
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print(err)
                        }
                    }
            })
    }
   
    
    
    static func buildparameters(paramaters:parameterType)->([String:Any],ParameterEncoding){
        switch paramaters{
        case .plainRequest:
            return ([:],URLEncoding.default)
        case .plainRequest1:
            return ([:],URLEncoding.default)
        case .parameterRequest(Parameters: let Parameters, Encoding: let Encoding):
            return(Parameters,Encoding)
        }
    }
    
    }
