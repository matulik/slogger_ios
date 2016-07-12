//
//  NetworkController.swift
//  slogger
//
//  Created by Kamil Matula on 12/07/16.
//  Copyright © 2016 Kamil Matula. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum RequestModel: String {
    case DefaultLog = "api/addLogDefault/"
    
    func getRequestMethod() -> Alamofire.Method {
        switch self {
        case .DefaultLog:
            return .POST
        }
    }
    
    func getRequestURL(serverAddres: String) -> URLStringConvertible {
        return serverAddres + self.rawValue
    }
    
    func getLogType() -> Int {
        switch self {
        case .DefaultLog:
            return 1
        }
    }
    
    func getHeadersDictionary(secureKey: String, appName: String) -> [String: String] {
        return [
            "Accept":       "application/json",
            "TOKEN":        secureKey,
            "APPNAME":      appName
        ]
    }
    
    static func getDefaultLogsDictionary(appName: String, logType: RequestModel, logValue: AnyObject) -> [String: AnyObject] {
        return [
            "LOGTYPE":      logType.getLogType(),
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
    
    func configureRequestManager(appName: String, serverAddress: String, secureKey: String) {
        self.appName = appName
        self.serverAddress = serverAddress
        self.secureKey = secureKey
    }
    
    func startRequest(request: RequestModel, parameters: [String: AnyObject], successHandler: (success: JSON) -> Void, errorHandler: (error: NSError) -> Void) {
        
        let method = request.getRequestMethod()
        let url = request.getRequestURL(self.serverAddress)
        let headers = request.getHeadersDictionary(self.secureKey, appName: self.appName)

        self.alamofireManager.request(method, url, parameters: parameters, encoding: .URL, headers: headers).response { request, response, data, error in
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
