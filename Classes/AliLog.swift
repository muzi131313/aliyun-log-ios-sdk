//
//  AliLog.swift
//  AliLogHub
//
//  Created by Qihang Cheng on 2020/2/18.
//

import UIKit

open class AliLog: Log {

    public func post(_ service: AliLogService, logStoreName: String, callBack: @escaping (URLResponse?, NSError?) -> ()) -> AliLog {
        let logGroup = LogGroup(topic: "", source: "")
        logGroup.PutLog(self)
        service.PostLog(logGroup, logStoreName: logStoreName, call: callBack)
        return self
    }
    
}
