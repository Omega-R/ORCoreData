//
//  ORBaseTestWithCoreData.swift
//  ORCoreData
//
//  Created by Maxim Soloviev on 08/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import MagicalRecord

let kTestExpectationTimeout = 2.0

class ORBaseTestWithCoreData: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // create temporary in-memory CoreData stack
        MagicalRecord.setupCoreDataStackWithInMemoryStore()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        // clean temporary in-memory CoreData stack
        MagicalRecord.cleanUp()
    }
}
