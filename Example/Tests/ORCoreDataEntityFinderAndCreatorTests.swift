//
//  ORCoreDataEntityFinderAndCreatorTests.swift
//  ORCoreData
//
//  Created by Maxim Soloviev on 08/04/16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import XCTest
import MagicalRecord
import ORCoreData
@testable import ORCoreData_Example

class ORCoreDataEntityFinderAndCreatorTests: ORBaseTestWithCoreData {
    
    func test_findOrCreate() {
        let context = NSManagedObjectContext.mr_()
        let finderAndCreator = ORCoreDataEntityFinderAndCreator(context)
        
        XCTAssertEqual(0, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        
        let testEntity1 = finderAndCreator.findOrCreateEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "1")
        XCTAssertEqual(1, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        XCTAssertEqual("1", testEntity1.uid)
        
        let testEntity1_1 = finderAndCreator.findOrCreateEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "1")
        XCTAssertEqual(1, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        XCTAssertEqual(testEntity1, testEntity1_1)
        
        let testEntity2 = finderAndCreator.findOrCreateEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "2")
        XCTAssertEqual(2, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        XCTAssertEqual("2", testEntity2.uid)
        XCTAssertNotEqual(testEntity2, testEntity1)
        
        let testEntityWithEmptyId = finderAndCreator.findOrCreateEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "")
        XCTAssertEqual(3, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        XCTAssertEqual("", testEntityWithEmptyId.uid)
    }
    
    func test_create() {
        let context = NSManagedObjectContext.mr_()
        let finderAndCreator = ORCoreDataEntityFinderAndCreator(context)
        
        XCTAssertEqual(0, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        
        let location1 = finderAndCreator.createEntityOfType(TestEntity.self)
        XCTAssertEqual(1, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        let location2 = finderAndCreator.createEntityOfType(TestEntity.self)
        XCTAssertEqual(2, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        let location3 = finderAndCreator.createEntityOfType(TestEntity.self)
        XCTAssertEqual(3, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        
        XCTAssertNotEqual(location1, location2)
        XCTAssertNotEqual(location2, location3)
        XCTAssertNotEqual(location3, location1)
    }
}
