//
//  Network.swift
//  RandomCatPicture
//
//  Created by 김태형 on 2020/03/30.
//  Copyright © 2020 김태형. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    static let apiKey = "api key input"
    
    static let shared = Network()
    
    class var baseURL : String {
        return "https://api.thecatapi.com"
    }
    
    static var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [:]
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func getRandomCatPicture(parameters : Parameters, completion : @escaping(_ result : Data) -> (Void)){
        let url = "/v1/images/search"
        let parameters : Parameters = parameters
        Network.sessionManager.request(Network.baseURL + url, method: .get, parameters:  parameters).responseJSON { (response) in
            switch response.result{
            case .success(_):
                completion(response.data!)
                break
            case .failure(let error):
                print(error)
                print(response.data!)
                break
            }
        }
    }
}
