//
//  LEETabBarViewController.swift
//  LEEDemoForMVC
//
//  Created by yuanlee on 2019/9/10.
//  Copyright © 2019 YuanLee. All rights reserved.
//

import UIKit

class LEETabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white
        
        self.setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let titleArray = ["首页", "个人中心"]
        let imageNormalArray = ["ic_main_home_not", "home-me"]
        let imageSeletedArray = ["ic_main_home_select", "home-me_h"]
        let vcArray = [MainViewController(), LEESwiftVC()]
        
        var navVCArray: [NSObject] = [NSObject]()
        var nav: RTRootNavigationController = RTRootNavigationController()
        
        for i in 0..<vcArray.count {
            nav = RTRootNavigationController.init(rootViewController: (vcArray[i]))
            nav.tabBarItem.title = titleArray[i]
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: RGBColor(0x797979)], for: .normal)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: GlobalColor], for: .selected)
            
            // 必须设置图片的RenderingMode属性，否则会默认为蓝色
            /**
             public enum RenderingMode : Int {
             // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式
             case automatic
             // 始终绘制图片原始状态，不使用 TintColor
             case alwaysOriginal
             // 始终根据TintColor绘制图片，忽略图片的颜色信息
             case alwaysTemplate
             }
             */
            var image: UIImage = UIImage.init(named: imageNormalArray[i])!
            var selectedImage: UIImage = UIImage.init(named: imageSeletedArray[i])!
            image = image.withRenderingMode(.alwaysOriginal)
            selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
            nav.tabBarItem.image = image
            nav.tabBarItem.selectedImage = selectedImage
            // 只显示图片不显示文字时，通过调节 imageInsets 属性的值使其向下移动一些距离
            //nav.tabBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
            
            //vcArray[i].title = titleArray[i]
            navVCArray.append(nav)
        }
        
        self.viewControllers = navVCArray as? [UIViewController]
        
    }

}


