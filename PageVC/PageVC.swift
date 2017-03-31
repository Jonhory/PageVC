//
//  PageVC.swift
//  PageVC
//
//  Created by Jonhory on 2017/3/31.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

import UIKit

class PageVC: UIViewController {

    let navView = NavView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分页主控制器"
        view.backgroundColor = UIColor(red: 187/255.0, green: 187/255.0, blue: 193/255.0, alpha: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
