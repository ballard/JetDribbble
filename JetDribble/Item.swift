//
//  Item.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 25.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import UIKit
import CoreData

class Item: NSManagedObject {
    
    class func findOrCreateItem(matching itemInfo: Shot, in context: NSManagedObjectContext) throws -> Item {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "identifier = %lf", itemInfo.identifier)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, Config.Strings.databaseError)
                return matches.first!
            }
        } catch {
            throw error
        }
        
        let item = Item(context: context)
        item.identifier = itemInfo.identifier
        item.title = itemInfo.title
        item.details = itemInfo.details
        let formatter = DateFormatter()
        formatter.dateFormat = Config.dateFormat
        if let date = formatter.date(from: itemInfo.created) as NSDate? {
            item.created = date
        }
        item.image = itemInfo.images.hidpi ?? itemInfo.images.normal
        item.animated = itemInfo.animated
        
        return item
    }

}
