//
//  Slogger.swift
//  slogger
//
//  Created by Kamil Matula on 12/07/16.
//  Copyright © 2016 Kamil Matula. All rights reserved.
//

import Foundation

final public class Slogger {
//    public static let sharedInstance = Slogger()
    
    public init() {
        //
    }
    
    public func dLog(logValue: AnyObject) {
        
        let parameters = RequestModel.getDefaultLogsDictionary("test", logType: .DefaultLog, logValue: logValue)
        
        RequestManager.sharedInstance.startRequest(.DefaultLog, parameters: parameters, successHandler: { (success) in
            print("✅slogger: success. \(success)")
        }) { (error) in
            print("❌slogger: error. \(error)")
        }
    }
    
    public func configureSlogger(appName: String, serverAddress: String, secureKey: String) {
        RequestManager.sharedInstance.configureRequestManager(appName, serverAddress: serverAddress, secureKey: secureKey)
    }
}