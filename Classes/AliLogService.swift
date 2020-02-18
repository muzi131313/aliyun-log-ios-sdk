//
//  AliLogService.swift
//  AliLogHub
//
//  Created by Qihang Cheng on 2020/2/18.
//

import UIKit

public class AliLogService: LOGClient {

    public init(endPoint: String, accessKeyID: String, accessKeySecret: String, projectName: String, accessToken: String? = nil) {
        let config = SLSConfig.init(connectType: .wifiOrwwan, cachable: true)
        super.init(endPoint: endPoint, accessKeyID: accessKeyID, accessKeySecret: accessKeySecret, projectName: projectName, token: accessToken, config: config)
    }
    
}
