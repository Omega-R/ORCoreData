//
//  FindEntityTraitProtocol.swift
//  MagicalRecord
//
//  Created by Alexey Vedushev on 16/01/2019.
//

import Foundation

public protocol FindEntityTraitProtocol {
    associatedtype key: RawRepresentable where key.RawValue == String
    associatedtype object: NSManagedObject
}

extension FindEntityTraitProtocol {
    public static func findOrCreate(in context: NSManagedObjectContext, byField: key, withValue: Any) -> object {
        return ORCoreDataEntityFinderAndCreator(context).findOrCreateEntityOfType(object.self, byAttribute: byField.rawValue, withValue: withValue)
    }
    
    public static func find(in context: NSManagedObjectContext, byField: key, withValue: Any) -> object? {
        return ORCoreDataEntityFinderAndCreator(context).findEntityOfType(object.self, byAttribute: byField.rawValue, withValue: withValue)
    }
}
