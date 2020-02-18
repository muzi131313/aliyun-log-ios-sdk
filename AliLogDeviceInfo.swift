//
//  AliLogDeviceInfo.swift
//  AliLogHub
//
//  Created by Qihang Cheng on 2020/2/18.
//

import CoreTelephony

class AliLogDeviceInfo {

    static public var resolutionRatio: String {
        let scale = UIScreen.main.scale
        let width = UIScreen.main.bounds.size.width * scale
        let height = UIScreen.main.bounds.size.height * scale
        return "\(String(format:"%.0f",width)) x \(String(format:"%.0f",height))"
    }
    
    /// 运营商名字
    static var carrierName: String {
        let info = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceSubscriberCellularProviders {
                if carriers.keys.count == 0 {
                    return "none"
                }
                else {
                    var result: String = ""
                    for (index, carrier) in carriers.values.enumerated() {
                        result += carrier.carrierName ?? "Unknown"
                        if index < carriers.count - 1 {
                            result += ","
                        }
                    }
                    return result
                }
            }
            else {
                return "none"
            }
        } else {
            if let carrier = info.subscriberCellularProvider, let result = carrier.carrierName {
                return result
            }
            else {
                return "none"
            }
        }
    }

    static let manager = NetworkReachabilityManager(host: "www.aliyun.com")
    static public var networkStatus: String {
        if manager?.isReachableOnEthernetOrWiFi ?? false {
            return "wifi"
        }
        else if manager?.isReachableOnWWAN ?? false {
            return cellularType
        }
        return "none"
    }
    
    private static func cellularTypeString(currentRadioTech: String) -> String {
        switch currentRadioTech {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x:
            return "2G"
        case CTRadioAccessTechnologyeHRPD,
             CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyHSUPA:
            return "3G"
        case CTRadioAccessTechnologyLTE:
            return "4G"
        default:
            return "none"
        }
    }
    
    /// 网络制式
    static var cellularType: String {
        let info = CTTelephonyNetworkInfo()
        if #available(iOS 12.0, *) {
            if let carriers = info.serviceCurrentRadioAccessTechnology {
                if carriers.keys.count == 0 {
                    return "none"
                }
                else {
                    var result: String = ""
                    for (index, currentRadioTech) in carriers.values.enumerated() {
                        result += cellularTypeString(currentRadioTech: currentRadioTech)
                        if index < carriers.count - 1 {
                            result += ","
                        }
                    }
                    return result
                }
            }
            else {
                return "none"
            }
        } else {
            if let currentRadioTech = info.currentRadioAccessTechnology {
                return cellularTypeString(currentRadioTech: currentRadioTech)
            }
            else {
                return "none"
            }
        }
    }
    
    static var modeIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") {identifier, element  in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 设备型号
    static var modeName: String {
        
        let identifier = modeIdentifier
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":  return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1":   return "国行(A1863)、日行(A1906)iPhone 8"
        case "iPhone10,2":   return "国行(A1864)、日行(A1898)iPhone 8 Plus"
        case "iPhone10,3":   return "国行(A1865)、日行(A1902)iPhone X"
        case "iPhone10,4":   return "美版(Global/A1905)iPhone 8"
        case "iPhone10,5":   return "美版(Global/A1897)iPhone 8 Plus"
        case "iPhone10,6":   return "美版(Global/A1901)iPhone X"
        case "iPhone11,2":   return "iPhone XS"
        case "iPhone11,4":   return "iPhone XS Max"
        case "iPhone11,6":   return "iPhone XS Max"
        case "iPhone11,8":   return "iPhone XR"

        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1":   return "iPad 2 (WiFi)"
        case "iPad2,2":   return "iPad 2"
        case "iPad2,3":   return "iPad 2 (CDMA)"
        case "iPad2,4":   return "iPad 2"
        case "iPad2,5":   return "iPad Mini (WiFi)"
        case "iPad2,6":   return "iPad Mini"
        case "iPad2,7":   return "iPad Mini (GSM+CDMA)"
        case "iPad3,1":  return "iPad 3 (WiFi)"
        case "iPad3,2":  return "iPad 3 (GSM+CDMA)"
        case "iPad3,3":  return "iPad 3"
        case "iPad3,4":   return "iPad 4 (WiFi)"
        case "iPad3,5":   return "iPad 4"
        case "iPad3,6":   return "iPad 4 (GSM+CDMA)"
        case "iPad4,1":   return "iPad Air (WiFi)"
        case "iPad4,2":   return "iPad Air (Cellular)"
        case "iPad4,3":   return "iPad Air"
        case "iPad4,4":  return "iPad Mini 2 (WiFi)"
        case "iPad4,5":  return "iPad Mini 2 (Cellular)"
        case "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7":  return "iPad Mini 3"
        case "iPad4,8":  return "iPad Mini 3"
        case "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1":  return "iPad Mini 4 (WiFi)"
        case "iPad5,2":  return "iPad Mini 4 (LTE)"
        case "iPad5,3":   return "iPad Air 2"
        case "iPad5,4":   return "iPad Air 2"
        case "iPad6,3":  return "iPad Pro 9.7"
        case "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7":  return "iPad Pro 12.9"
        case "iPad6,8":  return "iPad Pro 12.9"
        case "iPad6,11":  return "iPad 5 (WiFi)"
        case "iPad6,12":  return "iPad 5 (Cellular)"
        case "iPad7,1":  return "iPad Pro 12.9 inch 2nd gen (WiFi)"
        case "iPad7,2":  return "iPad Pro 12.9 inch 2nd gen (Cellular)"
        case "iPad7,3":  return "iPad Pro 10.5 inch (WiFi)"
        case "iPad7,4":  return "iPad Pro 10.5 inch (Cellular)"
        case "iPad7,5":  return "iPad 6 (WiFi)"
        case "iPad7,6":  return "iPad 6 (Cellular)"
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1":  return "Apple TV 3"
        case "AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"

        case "i386", "x86_64":   return "Simulator"
            
        default:  return identifier
        }
    }
        
    /// 磁盘总大小
    static var totalDiskSize: String {
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return fileSizeToString(fileSize: Int64(UInt64(fs.f_bsize) * fs.f_blocks))
        }
        return "0 B"
    }
        
    /// 磁盘可用大小
    static var availableDiskSize: String {
        var fs = blankof(type: statfs.self)
        if statfs("/var",&fs) >= 0{
            return fileSizeToString(fileSize: Int64(UInt64(fs.f_bsize) * fs.f_bavail))
        }
        return "0 B"
    }
    
    private static func blankof<T>(type:T.Type) -> T {
        let size = MemoryLayout<T>.size
        let ptr = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
        let val = ptr.pointee
        ptr.deinitialize(count: size)
        ptr.deallocate()
        return val
    }
        
    /// 将大小转换成字符串用以显示
    private static func fileSizeToString(fileSize:Int64) -> String{
        
        let fileSize1 = CGFloat(fileSize)
        
        let KB:CGFloat = 1024
        let MB:CGFloat = KB*KB
        let GB:CGFloat = MB*KB
        
        if fileSize < 10 {
            return "0 B"
        } else if fileSize1 < KB {
            return "< 1 KB"
        } else if fileSize1 < MB {
            return String(format: "%.1f KB", CGFloat(fileSize1)/KB)
        } else if fileSize1 < GB {
            return String(format: "%.1f MB", CGFloat(fileSize1)/MB)
        } else {
            return String(format: "%.1f GB", CGFloat(fileSize1)/GB)
        }
    }
}
