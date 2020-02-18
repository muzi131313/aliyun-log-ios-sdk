//
//  Log.swift
//  AliyunLOGiOS
//
//  Created by 王佳玮 on 16/7/29.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import Foundation

open class Log: NSObject {
    
    public var mContent: NSMutableDictionary = [:]
    
    public override init(){
        mContent[KEY_TIME] = Int(Date().timeIntervalSince1970) as AnyObject?
    }

    @objc open func PutTime(_ time: Int32){
        mContent[KEY_TIME] = NSNumber(value: time as Int32)
    }
    
    @objc open func PutContent(_ key: String,value: String){
        mContent[key] = value as AnyObject?
    }
    
}
