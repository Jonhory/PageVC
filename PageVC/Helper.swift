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
