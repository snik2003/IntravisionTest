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
    
    func getShowrooms(cityID: Int, completion: @escaping ([ListObject]) -> Void) {
        
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
    
    func sendForm(controller: TableViewController) {
        let url = "\(Constants.shared.apiURL)/WorkSheets/"
        
        let headers = [
            "Authorization": "\(Constants.shared.tokenType) \(Constants.shared.accessToken)",
            "Accept": "application/json",
            "Content-type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "Gender": Constants.shared.order.gender,
            "LastName": Constants.shared.order.lastName,
            "FirstName": Constants.shared.order.firstName,
            "MiddleName": Constants.shared.order.middleName,
            "Email": Constants.shared.order.email,
            "Phone": Constants.shared.order.phone,
            "Vin": Constants.shared.order.vin,
            "Year": Constants.shared.order.year,
            "ClassId": Constants.shared.order.classID,
            "City": Constants.shared.order.city,
            "ShowRoomId": Constants.shared.order.showroomID
        ]
        
        let request = GetServerDataOperation(url: url, parameters: parameters, method: .post, headers: headers, encoding: JSONEncoding.default)
        request.completionBlock = {
            guard let data = request.data else { print("data error"); return }
            guard let json = try? JSON(data: data) else {
                Constants.shared.order.savePersonalData()
                Constants.shared.order = ThreePlusOrder(json: JSON.null)
                OperationQueue.main.addOperation {
                    controller.showErrorMessage(message: "Заявка на участие в сервисной программе успешно отправлена")
                }
                return
            }
            
            //print(json)
            OperationQueue.main.addOperation {
                let message = json["Message"].stringValue
                controller.showErrorMessage(message: message)
            }
        }
        OperationQueue().addOperation(request)
    }
}
