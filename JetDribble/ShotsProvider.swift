//
//  ShotsProvider.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 26.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import Foundation
import CoreData

struct ShotsProvider
{
    static func getShots()->[Item] {
        let context = AppDelegate.viewContext
        var items = [Item]()
        context.performAndWait {
            let request : NSFetchRequest<Item> = NSFetchRequest(entityName: Config.entityName)
            request.fetchLimit = Config.shotsFetchLimit
            request.predicate = NSPredicate(format: "animated = NO")
            request.sortDescriptors = [NSSortDescriptor(key: Config.updatedSortDescriptor, ascending: false)]
            if let fetchedItems = try? context.fetch(request) {
                items = fetchedItems
            }
        }
        return items
    }
    
    static func getShotsCount()-> Int {
        let context = AppDelegate.viewContext
        var itemsCount = 0
        context.performAndWait {
            let request : NSFetchRequest<Item> = NSFetchRequest(entityName: Config.entityName)
            request.predicate = NSPredicate(format: "animated = NO")
            if let count = try? context.count(for: request) {
                itemsCount = count
            }
        }
        return itemsCount
    }
    
    static func saveShots(_ shots: [Shot], withCompletion completion: (()->Void)?){
        let container = AppDelegate.persistentContainer
        container.performBackgroundTask{ moc in
            for shot in shots {
                _ = try? Item.findOrCreateItem(matching: shot, in: moc)
            }
            try? moc.save()
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    static func flushDatabase() {
        
        let context = AppDelegate.viewContext
        
        var items = [Item]()
        
        context.performAndWait {
            let request : NSFetchRequest<Item> = NSFetchRequest(entityName: Config.entityName)
            
            if let fetchedItems = try? context.fetch(request) {
                items = fetchedItems
            }
            
            for item in items {
                context.delete(item)
            }
            
            try? context.save()
        }
    }
    
}
