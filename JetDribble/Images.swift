//
//  Images.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Images {
    var hidpi: String?
    var normal : String
    
    init(json : JSON) {
        hidpi = json["hidpi"].stringValue
        normal = json["normal"].stringValue
    }
}
