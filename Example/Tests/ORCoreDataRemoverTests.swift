//
//  ORCoreDataRemoverTests.swift
//  ORCoreData
//
//  Created by Maxim Soloviev on 03/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import MagicalRecord
import ORCoreData
@testable import ORCoreData_Example

class ORCoreDataRemoverTests: ORBaseTestWithCoreData {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_truncateAllOfTypes() {
        let context = NSManagedObjectContext.mr_()
        let finderAndCreator = ORCoreDataEntityFinderAndCreator(context)

        TestEntity.mr_createEntity(in: context)
        TestEntity.mr_createEntity(in: context)
        TestEntity.mr_createEntity(in: context)
        XCTAssertEqual(3, finderAndCreator.countOfEntitiesOfType(TestEntity.self))

        AnotherTestEntity.mr_createEntity(in: context)
        XCTAssertEqual(1, finderAndCreator.countOfEntitiesOfType(AnotherTestEntity.self))

        ORCoreDataRemover.truncateAllOfTypes([TestEntity.self, AnotherTestEntity.self], inContext: context)
        
        XCTAssertEqual(0, finderAndCreator.countOfEntitiesOfType(TestEntity.self))
        XCTAssertEqual(0, finderAndCreator.countOfEntitiesOfType(AnotherTestEntity.self))
    }
}
