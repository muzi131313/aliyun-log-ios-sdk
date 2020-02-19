//
//  AliLog.swift
//  AliLogHub
//
//  Created by Qihang Cheng on 2020/2/18.
//

import UIKit

open class AliLog: Log {

    public private(set) var logStoreName: String
    
    public init(logStoreName: String) {
        self.logStoreName = logStoreName
        super.init()
    }
    
    public func post(_ service: AliLogService, callBack: @escaping (URLResponse?, NSError?) -> ()) -> AliLog {
        let logGroup = LogGroup(topic: "", source: "")
        logGroup.PutLog(self)
        service.PostLog(logGroup, logStoreName: logStoreName, call: callBack)
        return self
    }
    
}
