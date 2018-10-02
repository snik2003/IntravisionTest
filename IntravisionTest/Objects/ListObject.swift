//
//  ListObject.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 02.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListObject {
    var id = 0
    var name = ""
    
    init(json: JSON) {
        self.id = json["Id"].intValue
        self.name = json["Name"].stringValue
    }
}
