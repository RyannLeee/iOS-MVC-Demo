//
//  LEETools.swift
//  LEEDemoForMVC
//
//  Created by yuanlee on 2019/8/26.
//  Copyright © 2019 YuanLee. All rights reserved.
//

import UIKit
import Foundation

/// 全局颜色
public let GlobalColor = RGBColor(0x98CB00)
/// 屏幕宽度
public let MainScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
public let MainScreenHeight = UIScreen.main.bounds.height

// MARK: - 封装的日志输出功能（T表示不指定日志信息参数类型）

/// 为 Swift 封装的日志输出功能（T表示不指定日志信息参数类型)
/// - Parameter message: 要打印的内容
/// - Parameter file: 当前所在文件
/// - Parameter methodName: 当前位置的方法名
/// - Parameter lineNumber: 当前位置所在行数
public func NSLog<T>(_ message: T, file : String = #file, methodName: String = #function, lineNumber : Int = #line) {
    #if DEBUG

    ///去掉 .swift
    ///let filePath = file as NSString
    ///let filePath_copy = filePath.lastPathComponent as NSString
    ///let fileName = filePath_copy.deletingPathExtension
    
    //获取文件名
    ///带后缀 .swift
    let fileName = (file as NSString).lastPathComponent
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    // 为日期格式器设置格式字符串
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    // 使用日期格式器格式化当前日期、时间
    let datestr = dformatter.string(from: Date())
    //打印日志内容
    print("\(datestr)\n    文件:\(fileName)[第\(lineNumber)行]\n    方法:\(methodName)\n    打印:\(message)")
    #else
    #endif
}

// 通知相关

/// 为 Swift 封装的发送 Notification 的快捷方法
/// - Parameter name: 通知名称
/// - Parameter object: 通知对象
/// - Parameter userInfo: 通知内容
public func LEEPostNotification(_ name: String, _ object: Any? = nil, _ userInfo: [AnyHashable : Any]? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: name), object: object, userInfo: userInfo)
}

/// 为 Swift 封装的添加 Notification Observer 的快捷方法
/// - Parameter observer: Observer
/// - Parameter selector: 收到通知时执行的方法
/// - Parameter name: 要 Observer 的通知名称
/// - Parameter object: 通知对象
public func LEEAddNotificationObserver(_ observer: Any, _ selector: Selector, _ name: String, _ object: Any? = nil) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
}


/// 为 Swift 封装的移除 Notification Observer 的快捷方法
/// - Parameter observer: Observer
/// - Parameter name: Observer Name
/// - Parameter object: Observer Object
public func LEERemoveNotificationObserver(_ observer: Any, _ name: NSNotification.Name? = nil, _ object: Any? = nil) {
    NotificationCenter.default.removeObserver(observer, name: name, object: object)
}

// 自动计算屏幕缩放比例
/// 水平方向缩放
public func autoScaleH(_ h: CGFloat) -> CGFloat {
    return LEEAutoScaleLayout.autoScaleH(h)
}

/// 竖直方向缩放
public func autoScaleV(_ v: CGFloat) -> CGFloat {
    return LEEAutoScaleLayout.autoScaleV(v)
}

/// 字体大小缩放
public func autoScaleF(_ f: CGFloat) -> CGFloat {
    return LEEAutoScaleLayout.autoScaleFont(f)
}

// 获取View的一些属性

/// 获取 View 的 x 值
/// - Parameter view: View
public func x(_ view: UIView) -> CGFloat {
    return view.frame.origin.x
}

/// 获取 View 的 y 值
/// - Parameter view: View
public func y(_ view: UIView) -> CGFloat {
    return view.frame.origin.y
}

/// 获取 View 的 width 值
/// - Parameter view: View
public func width(_ view: UIView) -> CGFloat {
    return view.frame.size.width
}

/// 获取 View 的 heigit 值
/// - Parameter view: View
public func heigit(_ view: UIView) -> CGFloat {
    return view.frame.size.height
}

/// 十六进制颜色
public func RGBColor(_ rgb: Int) -> UIColor {
    return UIColor.init(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgb & 0xFF)) / 255.0, alpha: 1.0)
}

/// 十六进制颜色加 alpha 值
public func RGBAColor(_ rgb: Int, _ alpha: CGFloat) -> UIColor {
    return UIColor.init(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgb & 0xFF)) / 255.0, alpha: alpha)
}

// 屏幕尺寸等

// iPhone X / iPhone XS
public var is_iPhoneX_XS: Bool {
    //    if MainScreenWidth == 375 && MainScreenHeight == 812 {
    //        return true
    //    } else {
    //        return false
    //    }
    return (MainScreenWidth == 375.0 && MainScreenHeight == 812.0) ? true : false
}

// iPhone XR / iPhone XS Max
public var is_iPhoneXR_XSMax: Bool {
    return (MainScreenWidth == 414.0 && MainScreenHeight == 896.0) ? true : false
}

// 异形全面屏
public var isFullScreen: Bool {
    return (is_iPhoneX_XS || is_iPhoneXR_XSMax) ? true : false
}

// Status bar height.
public var statusBarHeight: CGFloat {
    return isFullScreen ? 44.0 : 20.0
}

// Navigation bar height.
public let navigationBarHeight = 44.0

// Tabbar height.
public var tabbarHeight: CGFloat {
    return isFullScreen ? (49.0 + 34.0) : 49.0
}

// Tabbar safe bottom margin.
public var tabbarSafeBottomMargin: CGFloat {
    return isFullScreen ? 34.0 : 0.0
}

// Status bar & navigation bar height.
public var statusBarAndNavigationBarHeight: CGFloat {
    return isFullScreen ? 88.0 : 64.0
}
