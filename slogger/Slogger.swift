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
        
        let parameters = RequestModel.getDefaultLogsDictionary("test", logType: .DefaultLog, logValue: "asd")
        
        RequestManager.sharedInstance.startRequest(.DefaultLog, parameters: parameters, successHandler: { (success) in
            print("success")
        }) { (error) in
            print("error")
        }
    }
}