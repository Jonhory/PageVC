//
//  Helper.swift
//  PageVC
//
//  Created by Jonhory on 2017/4/1.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

import UIKit

func iPhonePlus() -> Bool {
    return SCREEN_W > 375
}

func iPhoneX() -> Bool {
    return (SCREEN_W == 375.0 && SCREEN_H == 812.0) || (SCREEN_W == 414.0 && SCREEN_H == 896.0)
}

/// 83 / 49
func TabbarHeight() -> CGFloat {
    return iPhoneX() ? (49.0 + TabbarSafeBottomMargin()) : 49.0
}

/// 34 / 0
func TabbarSafeBottomMargin() -> CGFloat {
    return iPhoneX() ? 34.0 : 0.0
}

/// 状态栏高度 44/20
func StatusBarHeight() -> CGFloat {
    return iPhoneX() ? 44 : 20
}

/// 导航栏高度 84/64
func NavigationBarHeight() -> CGFloat {
    return StatusBarHeight() + 44
}

let SCREEN = UIScreen.main.bounds.size
let SCREEN_W = SCREEN.width
let SCREEN_H = SCREEN.height


extension UIColor {
    //返回随机颜色
    open class var randomColor:UIColor{
        get{
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
