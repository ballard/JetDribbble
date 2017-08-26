//
//  Shot.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Shot {
    
    var identifier : Double
    var title : String
    var details : String
    var created : String
    var images : Images
    var animated : Bool
    
    init(json : JSON) {
        
        identifier = json["id"].doubleValue
        title = json["title"].stringValue
        details = json["description"].stringValue
        created = json["created_at"].stringValue
        images = Images.init(json: json["images"].dictionaryObject!)
        animated = json["animated"].boolValue
    }
}
