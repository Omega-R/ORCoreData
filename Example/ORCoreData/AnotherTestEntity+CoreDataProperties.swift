//
//  AnotherTestEntity+CoreDataProperties.swift
//  ORCoreData
//
//  Created by Maxim Soloviev on 03/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import CoreData


extension AnotherTestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnotherTestEntity> {
        return NSFetchRequest<AnotherTestEntity>(entityName: "AnotherTestEntity");
    }

    @NSManaged public var attribute: String?

}
