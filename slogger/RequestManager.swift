//
//  NetworkController.swift
//  slogger
//
//  Created by Kamil Matula on 12/07/16.
//  Copyright © 2016 Kamil Matula. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum LogType: Int {
    case DefaultLog = 1
}

enum RequestModel: String {
    case defaultLog = "api/addLogDefault/"
    
    func getRequestType() -> Alamofire.Method {
        switch self {
        case .defaultLog:
            return .POST
        }
    }
    
    func getRequestURL(serverAddres: String) -> URLStringConvertible {
        return serverAddres + self.rawValue
    }
    
    func getHeadersDictionary(secureKey: String) -> [String: String] {
        return [
            "Accept":       "application/json",
            "TOKEN":        secureKey
        ]
    }
    
    static func getDefaultLogsDictionary(appName: String, logType: LogType, logValue: AnyObject) -> [String: AnyObject] {
        return [
            "APPNAME":      appName,
            "LOGTYPE":      logType.rawValue,
            "LOGVALUE":     logValue
        ]
    }
}


final class RequestManager {
    
    static let sharedInstance = RequestManager()
    
    private var serverAddress   = ""
    private var secureKey       = ""
    private var appName         = ""
    
    private let alamofireManager: Alamofire.Manager

    private init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.alamofireManager = Alamofire.Manager(configuration: configuration)
    }
    
    private func configureRequestManager(appName: String, serverAddress: String, secureKey: String) {
        self.appName = appName
        self.serverAddress = serverAddress
        self.secureKey = secureKey
    }
    
    func startRequest(request: RequestModel, parameters: [String: AnyObject], successHandler: (success: JSON) -> Void, errorHandler: (error: NSError) -> Void) {
        
        let method = request.getRequestType()
        let url = request.getRequestURL(self.serverAddress)
        let headers = request.getHeadersDictionary(self.secureKey)
        
        self.alamofireManager.request(method, url, parameters: parameters, encoding: .JSON, headers: headers).response { request, response, data, error in
            if error != nil {
                errorHandler(error: error!)
            }
            else if data != nil {
                let json = JSON(data: data!)
                successHandler(success: json)
            }
        }
    }
}
