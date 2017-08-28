//
//  Config.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import Foundation
import UIKit

struct Config {
    static let token = "dfdb774dbf2ebe6d24fd20990215fe10028512442367cc4f68b4e2c98d5c2dba"
    static let sortingParameter = "sort=recent"
    static let fetchLimitParameter = "per_page=\(shotsPacketSize)"
    static let listParameter = "list=animated"
    static let url = "http://api.dribbble.com/v1/shots?access_token=\(token)&\(sortingParameter)&\(fetchLimitParameter))"
    static let entityName = "Item"
    static let updatedSortDescriptor = "updatedAt"
    static let cellReuseIdentifier = "ShotCell"
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    static let navigationBarHeigth : CGFloat = 44.0
    static let shotsFetchLimit = 50
    static let shotsPacketSize = 10
    
    public struct Strings {
        static let refresher = "fetching data..."
        static let databaseError = "Database problems"
    }
}
