//
//  HomeViewModel.swift
//  El Rass
//
//  Created by admin on 22/08/2022.
//

import Foundation
import Combine
import CoreData
import UIKit


class ViewModelPost: ObservableObject {
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<PostsModel, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    private var context = PersistenceController.shared.container.viewContext
    

    //    //------- output
    @Published var publishedPostModel: PostsModel?
    @Published var isDone = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var isConnected = true
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: {[self] (modeldata) in
            self.publishedPostModel = modeldata
            
            
            
        }.store(in: &cancellables)
    }
    
}


extension ViewModelPost:TargetType{
    
    var url: String {
        return  URLs().Posts
    }
    
    var method: httpMethod {
        return .Get
    }
    
    var parameter: parameterType {
        return .plainRequest
    }
    
    var header: [String : String]? {
        let header = [ "Accept": "*/*"]
        return header
    }
    
    
    func startFetchHomeData(){
        if Helper.isConnectedToNetwork(){
            self.isConnected = true
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: PostsModel.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.isDone = true
                        self.isLoading = false
                        self.passthroughModelSubject.send(model!)
                        print("post success")
                        
                        
                        
                        
                        
                    }
                }else{
                    if model != nil{
                        //case of model with error
                        //                        message = model?.msg ?? "Bad Request"
                        isAlert = true
                    }else{
                        if err == "Unauthorized"{
                            //case of Empty model (unauthorized)
                            isAlert = true
                            message = "Session_expired"
                        }else{
                            isAlert = true
                            message = "Your Internet connection has benn lost"
                        }
                    }
                    isAlert = true
                }
                isLoading = false
            }
        }else{
            //case of no internet connection
            self.isConnected = false
            message = "Check_Your_Internet_Connection"
            isAlert = true
        }
    }
}
