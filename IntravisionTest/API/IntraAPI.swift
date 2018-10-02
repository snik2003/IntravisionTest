//
//  IntraAPI.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 02.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class IntraAPI {
    
    func getToken() {
        
        let url = Constants.shared.getTokenURL
        
        let parameters = [
            "grant_type": "custom_client_credentials",
            "scope": "profile"
        ]
        
        let headers = [
            "Authorization": "Basic Q3VzdG9tR3JhbnRUeXBlQ2xpZW50SWQ6Q3VzdG9tR3JhbnRUeXBlQ2xpZW50U2VjcmV0",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let request = GetServerDataOperation(url: url, parameters: parameters, method: .post, headers: headers)
        request.completionBlock = {
            guard let data = request.data else { print("data error"); return }
            guard let json = try? JSON(data: data) else { print("json error"); return }
            //print(json)
            
            Constants.shared.accessToken = json["access_token"].stringValue
            Constants.shared.tokenType = json["token_type"].stringValue
        }
        OperationQueue().addOperation(request)
    }
    
    func getClasses(completion: @escaping ([ListObject]) -> Void) {
        
        let url = "\(Constants.shared.apiURL)/Classes/"
        
        let headers = [
            "Authorization": "\(Constants.shared.tokenType) \(Constants.shared.accessToken)",
            "Accept": "application/json",
            "Content-type": "application/json"
        ]
        
        let request = GetServerDataOperation(url: url, method: .get, headers: headers)
        request.completionBlock = {
            guard let data = request.data else { print("data error"); return }
            guard let json = try? JSON(data: data) else { print("json error"); return }
            //print(json)
            
            let objects = json.compactMap { ListObject(json: $0.1)}
            completion(objects)
        }
        OperationQueue().addOperation(request)
    }
    
    func getCities(completion: @escaping ([ListObject]) -> Void) {
        
        let url = "\(Constants.shared.apiURL)/Cities/"
        
        let headers = [
            "Authorization": "\(Constants.shared.tokenType) \(Constants.shared.accessToken)",
            "Accept": "application/json",
            "Content-type": "application/json"
        ]
        
        let request = GetServerDataOperation(url: url, method: .get, headers: headers)
        request.completionBlock = {
            guard let data = request.data else { print("data error"); return }
            guard let json = try? JSON(data: data) else { print("json error"); return }
            //print(json)
            
            let objects = json.compactMap { ListObject(json: $0.1)}
            completion(objects)
        }
        OperationQueue().addOperation(request)
    }
    
    func getRooms(cityID: Int, completion: @escaping ([ListObject]) -> Void) {
        
        let url = "\(Constants.shared.apiURL)/ShowRooms/"
        
        let headers = [
            "Authorization": "\(Constants.shared.tokenType) \(Constants.shared.accessToken)",
            "Accept": "application/json",
            "Content-type": "application/json"
        ]
        
        let parameters = [
            "CityId": "\(cityID)"
        ]
        
        let request = GetServerDataOperation(url: url, parameters: parameters, method: .get, headers: headers)
        request.completionBlock = {
            guard let data = request.data else { print("data error"); return }
            guard let json = try? JSON(data: data) else { print("json error"); return }
            //print(json)
            
            let objects = json.compactMap { ListObject(json: $0.1)}
            completion(objects)
        }
        OperationQueue().addOperation(request)
        
    }
}
