//
//  LOGLogGroup.swift
//  AliyunLOGiOS
//
//  Created by 王佳玮 on 16/7/30.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import Foundation

class LogGroup: NSObject {
    
    fileprivate var mTopic: String = ""
    fileprivate var mSource: String = ""
    fileprivate var mContent = NSMutableArray.init()
    
    var logs: NSMutableArray {
        return self.mContent
    }
    
    var logTopic: String {
        return self.mTopic
    }
    
    var logSource: String {
        return self.mSource
    }
    
    init(topic: String,source: String) {
        mTopic = topic
        mSource = source
    }

    func PutTopic(_ topic: String) {
        mTopic = topic
    }
    
    func PutSource(_ source: String) {
        mSource = source
    }
    
    func PutLog(_ log: Log){
        mContent.add(log.mContent)
    }
    
    func GetJsonPackage() -> String {
        do {
            var package = [String: AnyObject]()
            package[KEY_TOPIC] = mTopic as AnyObject?
            package[KEY_SOURCE] = mSource as AnyObject?
            package[KEY_LOGS] = mContent as AnyObject?
            let JsonPackage = String(data:try JSONSerialization.data(withJSONObject: package, options: .prettyPrinted), encoding: .utf8)!
            return JsonPackage
        } catch _ as NSError {
            fatalError("Fail to serialize data.")
            return ""
        }
    }
}
