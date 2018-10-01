//
//  GetServerDataOperation.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetServerDataOperation: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest
    private var url: String
    private var parameters: Parameters?
    private var method: HTTPMethod
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(url: String, parameters: Parameters, method: HTTPMethod) {
        self.url = url
        self.parameters = parameters
        self.method = method
        request = Alamofire.request(self.url, method: self.method, parameters: self.parameters)
    }
}
