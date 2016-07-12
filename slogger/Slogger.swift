//
//  Slogger.swift
//  slogger
//
//  Created by Kamil Matula on 12/07/16.
//  Copyright © 2016 Kamil Matula. All rights reserved.
//

import Foundation

final public class Slogger {
    
    private init() {
        //
    }
    
    static public func configureSlogger(appName: String, serverAddress: String, secureKey: String) {
        RequestManager.sharedInstance.configureRequestManager(appName, serverAddress: serverAddress, secureKey: secureKey)
    }
    
    static public func dLog(logValue: AnyObject) {
        
        let parameters = RequestModel.getDefaultLogsDictionary(.Standard, logValue: logValue)
        
        RequestManager.sharedInstance.startRequest(.DefaultLog, parameters: parameters, successHandler: { (success) in
            print("✅slogger: success. \(success)")
        }) { (error) in
            print("❌slogger: error. \(error)")
        }
    }
    
    static public func dlog(logValue: AnyObject, logType: LogType) {
        
        let parameters = RequestModel.getDefaultLogsDictionary(logType, logValue: logValue)
        
        RequestManager.sharedInstance.startRequest(.DefaultLog, parameters: parameters, successHandler: { (success) in
            print("✅slogger: success. \(success)")
        }) { (error) in
            print("❌slogger: error. \(error)")
        }
    }
}