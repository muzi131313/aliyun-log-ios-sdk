#
#  Be sure to run `pod spec lint AliyunLOG.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#  pod lib lint --sources=http://git.dingyuegroup.biz/iOS_Literary/Modules/specs.git,https://github.com/CocoaPods/Specs.git

Pod::Spec.new do |s|
  s.name         = "AliLogLH" # 项目名称
  s.version      = "1.0.1"        # 版本号 与 你仓库的 标签号 对应
  s.license      = { :type => "MIT", :file => "LICENSE" }          # 开源证书
  s.summary      = "阿里日志服务(ios低版本)" # 项目简介
  s.homepage     = "https://github.com/muzi131313/aliyun-log-ios-sdk" # 仓库的主页
  s.source       = { :git => "https://github.com/muzi131313/aliyun-log-ios-sdk.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
  s.source_files = 'Classes/*.{swift,h}'
  s.requires_arc = true # 是否启用ARC
  s.author       = { "muzi131313" => "muzi131313@163.com" } # 作者信息
  s.platform     = :ios, "8.0" #平台及支持的最低版本
  s.dependency 'FMDB/standard', '~> 2.7.0'
  s.swift_version = '5.0'

end

