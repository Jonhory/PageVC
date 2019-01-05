//
//  BaseViewController.swift
//  PageVC
//
//  Created by Jonhory on 2017/3/31.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var myType: PageNavViewBtnType = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor
    }
    
    public func updateTable(frame: CGRect) {
//        tableView?.frame = frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
