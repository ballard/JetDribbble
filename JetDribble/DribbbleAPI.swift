//
//  DribbbleAPI.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

struct DribbbleAPI {
    
    static func loadData(completion: (([Shot])->Void)?) {
        
        let sessionURL = URL(string: Config.url)
        let session = URLSession(configuration: .default)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let task = session.dataTask(with: sessionURL!) { data, response, error in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error != nil {
                completion?([Shot]())
            } else if data != nil {
                let json = JSON(data: data!).arrayValue
                let shots = json.map{
                    return Shot.init(json: $0)
                }
                completion?(shots)
            }
        }
        
        task.resume()
    }
    
}
