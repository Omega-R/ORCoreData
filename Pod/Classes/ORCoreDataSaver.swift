//
//  ORCoreDataSaver.swift
//  Pods
//
//  Created by Maxim Soloviev on 08/04/16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import Foundation
import MagicalRecord

public typealias ORCoreDataSaverSavingBlock = (localContext : NSManagedObjectContext!, inout cancelSaving: Bool) -> Void
public typealias ORCoreDataSaverCompletionBlock = () -> Void

@objc public class ORCoreDataSaver: NSObject {
    
    public static let sharedInstance = ORCoreDataSaver()
    
    let savingQueue = NSOperationQueue()
    
    private override init() {
        super.init()
        savingQueue.name = "ORCoreDataSaver queue"
        savingQueue.maxConcurrentOperationCount = 1
        savingQueue.qualityOfService = .Utility
    }
    
    public func saveData(savingBlock: ORCoreDataSaverSavingBlock, success: ORCoreDataSaverCompletionBlock) -> Void {
        savingQueue.addOperationWithBlock( {
            var cancelSaving = false

            MagicalRecord.saveWithBlockAndWait({ (localContext : NSManagedObjectContext!) in
                savingBlock(localContext: localContext, cancelSaving: &cancelSaving)
                
                if cancelSaving {
                    localContext.rollback()
                }
            })
            
            if !cancelSaving {
                dispatch_async(dispatch_get_main_queue()) {
                    success()
                }
            }
        })
    }
}
