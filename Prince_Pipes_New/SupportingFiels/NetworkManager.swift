//
//  NetworkManager.swift
//  OfficeNetTMS
//
//  Created by Netcommlabs on 31/08/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class Networkmanager
{
    class func postRequest(vv:UIView,remainingUrl:String, parameters: [String:Any], completion: @escaping ((_ data: JSON, _ responseData:Foundation.Data) -> Void)) {
        CustomActivityIndicator.sharedInstance.showActivityIndicator(uiView: vv)
  
        
        print("parameters posted : ",parameters)
        let completeUrl = base.url + remainingUrl
        print ("complete url : ", completeUrl)
     
        AF.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of:JSON.self) { response in
                
                guard let data = response.data else { return }
                
                switch response.result
                {
                case .success(let value):
                    CustomActivityIndicator.sharedInstance.hideActivityIndicator(uiView: vv)
                  
                    let swiftyJsonVar = JSON(value)
                    //print(swiftyJsonVar)
                    completion(swiftyJsonVar, data)
                 
                case.failure(let error):
                    print(error.localizedDescription)
                }
           
        }
    }
      
}

class Networkmanager2
{
    class func postRequest(remainingUrl:String, parameters: [String:Any], completion: @escaping ((_ data: JSON, _ responseData:Foundation.Data) -> Void)) {
       
  
        
        print("parameters posted : ",parameters)
        let completeUrl = base.url + remainingUrl
        print ("complete url : ", completeUrl)
     
        AF.request(completeUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of:JSON.self) { response in
                
                guard let data = response.data else { return }
                switch response.result
                {
                case .success(let value):
                   
                  
                    let swiftyJsonVar = JSON(value)
                    //print(swiftyJsonVar)
                    completion(swiftyJsonVar, data)
                 
                case.failure(let error):
                    print(error.localizedDescription)
                }
           
        }
    }
      
}

