//
//  Images.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import Foundation

struct Images {
    var hidpi: String?
    var normal : String
    
    init(json : [String: Any]) {
        hidpi = json["hidpi"] as? String
        normal = json["normal"] as! String
    }
}
