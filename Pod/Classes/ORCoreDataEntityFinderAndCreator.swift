//
//  ORCoreDataEntityFinderAndCreator.swift
//  Pods
//
//  Created by Maxim Soloviev on 08/04/16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import Foundation
import MagicalRecord

@objc public class ORCoreDataEntityFinderAndCreator : NSObject {
    
    var context: NSManagedObjectContext?
    
    public init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func findEntityOfType<T: NSManagedObject>(type: T.Type, byAttribute attr: String, withValue value: String) -> T? {
        let obj = type.MR_findFirstByAttribute(attr, withValue: value, inContext: context!)
        return obj
    }
    
    public func findFirstEntityOfType<T: NSManagedObject>(type: T.Type) -> T? {
        let obj = type.MR_findFirstInContext(context!)
        return obj
    }
    
    public func createEntityOfType<T: NSManagedObject>(type: T.Type) -> T? {
        let obj = type.MR_createEntityInContext(context!)
        return obj
    }
    
    public func findOrCreateEntityOfType<T: NSManagedObject>(type: T.Type, byAttribute attr: String, withValue value: String) -> T {
        let obj = type.MR_findFirstOrCreateByAttribute(attr, withValue: value, inContext: context!)
        return obj
    }
    
    public func countOfEntitiesOfType<T: NSManagedObject>(type: T.Type) -> UInt {
        let count = type.MR_countOfEntitiesWithContext(context!)
        return count
    }
}
