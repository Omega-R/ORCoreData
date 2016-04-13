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
public typealias ORCoreDataSaverCompletionWithObjectIdsBlock = (objects: [String]) -> Void

public class ORCoreDataSaver: NSObject {
    
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
    
    public func saveData(savingBlock: ORCoreDataSaverSavingBlock, objectUidKey: String, successWithObjectIds: ORCoreDataSaverCompletionWithObjectIdsBlock) -> Void {
        savingQueue.addOperationWithBlock( {
            var cancelSaving = false
            
            var objectIds = [String]()
            
            MagicalRecord.saveWithBlockAndWait({ (localContext : NSManagedObjectContext!) in
                savingBlock(localContext: localContext, cancelSaving: &cancelSaving)
                
                if cancelSaving {
                    localContext.rollback()
                } else {
                    for obj in localContext.insertedObjects {
                        if let uid = obj.valueForKey(objectUidKey) where uid is String {
                            objectIds.append(uid as! String)
                        }
                    }
                    for obj in localContext.updatedObjects {
                        if let uid = obj.valueForKey(objectUidKey) where uid is String {
                            objectIds.append(uid as! String)
                        }
                    }
                }
            })
            
            if !cancelSaving {
                dispatch_async(dispatch_get_main_queue()) {
                    successWithObjectIds(objects: objectIds)
                }
            }
        })
    }
}
