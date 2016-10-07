//
//  ORCoreDataSaverTests.swift
//  ORCoreData
//
//  Created by Maxim Soloviev on 08/04/16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import XCTest
import MagicalRecord
import ORCoreData
@testable import ORCoreData_Example

class ORCoreDataSaverTests: ORBaseTestWithCoreData {
    
    func test_saveData_empty() {
        let expectation = self.expectation(description: "")
        ORCoreDataSaver.sharedInstance.saveData({ (localContext, cancelSaving: inout Bool) in
        },
        success: {
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: kTestExpectationTimeout, handler: nil)
    }
    
    func test_saveData_full() {
        let expectation = self.expectation(description: "")
        ORCoreDataSaver.sharedInstance.saveData({ (localContext, cancelSaving: inout Bool) in
            let entityFinderAndCreator = ORCoreDataEntityFinderAndCreator(localContext)
            let _ = entityFinderAndCreator.findOrCreateEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "1")
        },
        success: {
            DispatchQueue.main.async(execute: {
                let object = ORCoreDataEntityFinderAndCreator(NSManagedObjectContext.mr_default()).findEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "1")
                XCTAssertNotNil(object)
                
                expectation.fulfill()
            })
        })
        
        waitForExpectations(timeout: kTestExpectationTimeout, handler: nil)
    }
    
    func test_saveData_cancelSaving() {
        ORCoreDataSaver.sharedInstance.saveData({ (localContext, cancelSaving: inout Bool) in
            let obj = TestEntity.mr_findFirstOrCreate(byAttribute: "uid", withValue: "should_not_be_created", in: localContext)
            XCTAssertNotNil(obj)
            cancelSaving = true
        },
        success: {
            XCTFail("success should not be called!");
        })
        
        usleep(1000)    // some timeout to success block can be possibly called
        let obj = TestEntity.mr_findFirst(byAttribute: "uid", withValue: "should_not_be_created", in: NSManagedObjectContext.mr_default())
        XCTAssertNil(obj)
    }
}
