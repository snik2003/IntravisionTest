//
//  Constants.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Constants {
    static let shared = Constants()
    
    let userTitles: [String] = [
        "Обращение",
        "Фамилия",
        "Имя",
        "Отчество",
        "Телефон",
        "Email"]
    
    let userPlaceholder: [String] = [
        "",
        "Введите Вашу Фамилию",
        "Введите Ваше Имя",
        "Введите Ваше Отчество",
        "+7",
        "Введите email адрес"]
    
    
    let autoTitles: [String] = [
        "VIN",
        "Год выпуска",
        "Класс",
        "Город",
        "Дилер"]
    
    let autoPlaceholder: [String] = [
        "Введите VIN",
        "Выберите год выпуска",
        "Выберите класс",
        "Выберите город",
        "Выберите дилера"]

    let apiURL = "http://3plus-authless.test.intravision.ru/api"
    let getTokenURL = "http://identity-server.test.intravision.ru/core/connect/token"
    
    var accessToken = ""
    var tokenType = ""
    
    var order = ThreePlusOrder(json: JSON.null)
}
