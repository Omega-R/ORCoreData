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
        let expectation = expectationWithDescription("")
        ORCoreDataSaver.sharedInstance.saveData({ (localContext, cancelSaving) -> Void in
        },
        success: { () -> Void in
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(kTestExpectationTimeout, handler: nil)
    }
    
    func test_saveData_full() {
        let expectation = expectationWithDescription("")
        ORCoreDataSaver.sharedInstance.saveData({ (localContext, cancelSaving) -> Void in
            let entityFinderAndCreator = ORCoreDataEntityFinderAndCreator(localContext)
            let _ = entityFinderAndCreator.findOrCreateEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "1")
        },
        success: { () -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                let object = ORCoreDataEntityFinderAndCreator(NSManagedObjectContext.MR_defaultContext()).findEntityOfType(TestEntity.self, byAttribute: "uid", withValue: "1")
                XCTAssertNotNil(object)
                
                expectation.fulfill()
            })
        })
        
        waitForExpectationsWithTimeout(kTestExpectationTimeout, handler: nil)
    }
    
    func test_saveData_cancelSaving() {
        ORCoreDataSaver.sharedInstance.saveData({ (localContext, inout cancelSaving: Bool) -> Void in
            cancelSaving = true
        },
        success: { () -> Void in
            XCTFail("success should not be called!");
        })
        
        usleep(1000)    // some timeout to success block can be possibly called
    }
}
