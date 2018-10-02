//
//  ThreePlusOrder.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 02.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import Foundation
import SwiftyJSON

class ThreePlusOrder {
    var gender = 1
    var lastName = ""
    var firstName = ""
    var middleName = ""
    var email = ""
    var phone = ""
    var vin = ""
    var year = ""
    var classID = 0
    var city = ""
    var showroomID = 0

    init(json: JSON) {
        self.gender = json["Gender"].intValue
        self.lastName = json["LastName"].stringValue
        self.firstName = json["FirstName"].stringValue
        self.middleName = json["MiddleName"].stringValue
        self.email = json["Email"].stringValue
        self.phone = json["Phone"].stringValue
        self.vin = json["Vin"].stringValue
        self.year = json["Year"].stringValue
        self.classID = json["ClassId"].intValue
        self.city = json["City"].stringValue
        self.showroomID = json["ShowRoomId"].intValue
    }
    
    func checkValidation(controller: TableViewController) -> Bool {
        
        if self.gender == 0 {
            controller.showErrorMessage(message: "Некорректно указано значение «Обращения»")
        } else if self.lastName == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if self.firstName == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if self.middleName == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if self.phone == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if !self.phone.isValidPhone() {
            controller.showErrorMessage(message: "Некорректное значение номера телефона")
        } else if self.email == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if !self.email.isValidEmail() {
            controller.showErrorMessage(message: "Некорректное значение email")
        } else if self.vin == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if !self.vin.isValidVin() {
            controller.showErrorMessage(message: "Некорректное значение номера VIN")
        } else if self.year == "" {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if self.classID == 0 {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else if self.showroomID == 0 {
            controller.showErrorMessage(message: "Все поля обязательны для заполнения")
        } else {
            return true
        }
        
        return false
    }
    
    func savePersonalData() {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.gender, forKey: "3+Order_Gender")
        userDefaults.set(self.lastName, forKey: "3+Order_LastName")
        userDefaults.set(self.firstName, forKey: "3+Order_FirstName")
        userDefaults.set(self.middleName, forKey: "3+Order_MiddleName")
        userDefaults.set(self.phone, forKey: "3+Order_Phone")
        userDefaults.set(self.email, forKey: "3+Order_Email")
    }
    
    func readPersonalData() {
        
        let userDefaults = UserDefaults.standard

        self.gender = userDefaults.integer(forKey: "3+Order_Gender")
        
        if let text = userDefaults.string(forKey: "3+Order_LastName") {
            self.lastName = text
        }
        
        if let text = userDefaults.string(forKey: "3+Order_FirstName") {
            self.firstName = text
        }
        
        if let text = userDefaults.string(forKey: "3+Order_MiddleName") {
            self.middleName = text
        }
        
        if let text = userDefaults.string(forKey: "3+Order_Phone") {
            self.phone = text
        }
        
        if let text = userDefaults.string(forKey: "3+Order_Email") {
            self.email = text
        }
    }
}
