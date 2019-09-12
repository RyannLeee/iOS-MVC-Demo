//
//  LEETools.swift
//  LEEDemoForMVC
//
//  Created by yuanlee on 2019/8/26.
//  Copyright © 2019 YuanLee. All rights reserved.
//

import UIKit
import Foundation

public let GlobalColor = RGBColor(0x98CB00)
public let MainScreenWidth = UIScreen.main.bounds.width
public let MainScreenHeight = UIScreen.main.bounds.height

// 通知相关
public func LEEPostNotification(_ name: String, _ object: Any? = nil, _ userInfo: [AnyHashable : Any]? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: name), object: object, userInfo: userInfo)
}

public func LEEAddNotificationObserver(_ observer: Any, _ selector: Selector, _ name: String, _ object: Any? = nil) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: object)
}

public func LEERemoveNotificationObserver(_ observer: Any, _ name: NSNotification.Name? = nil, _ object: Any? = nil) {
    NotificationCenter.default.removeObserver(observer, name: name, object: object)
}

// 自动计算屏幕缩放比例
// 水平方向
public func autoScaleH(_ h: CGFloat) -> CGFloat {
    return LEEAutoScaleLayout.autoScaleH(h)
}

// 竖直方向
public func autoScaleV(_ v: CGFloat) -> CGFloat {
    return LEEAutoScaleLayout.autoScaleV(v)
}

// 字体大小
public func autoScaleF(_ f: CGFloat) -> CGFloat {
    return LEEAutoScaleLayout.autoScaleFont(f)
}

// 获取View的一些属性
public func x(_ view: UIView) -> CGFloat {
    return view.frame.origin.x
}

public func y(_ view: UIView) -> CGFloat {
    return view.frame.origin.y
}

public func width(_ view: UIView) -> CGFloat {
    return view.frame.size.width
}

public func heigit(_ view: UIView) -> CGFloat {
    return view.frame.size.height
}

// 十六进制颜色
public func RGBColor(_ rgb: Int) -> UIColor {
    return UIColor.init(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(rgb & 0xFF)) / 255.0, alpha: 1.0)
}

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
