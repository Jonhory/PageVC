//
//  PageVC.swift
//  PageVC
//
//  Created by Jonhory on 2017/3/31.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

import UIKit

class PageVC: UIViewController {

    var orderType: PageNavViewBtnType = .all
    var currentVC: BaseViewController?
    
    var navView: PageNavView?
    
    // tableview 背景
    let scrollView = UIScrollView()
    
    // 以下属性为了懒加载
    // 装全部vc
    var orderBaseVCs: [BaseViewController] = []
    // 装已加载的vc
    var orderBaseVCLoads : [Int: BaseViewController] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.title = "分页主控制器"
        view.backgroundColor = UIColor(red: 187/255.0, green: 187/255.0, blue: 193/255.0, alpha: 0.5)
        loadUI()
        loadChildView()
        loadCurrentType()
        
    }

    private func loadUI() {
        let fn = CGRect(x: 0, y: NavigationBarHeight(), width: SCREEN_W, height: 49+6)
        navView = PageNavView(frame: fn)
        navView?.delegate = self
        view.addSubview(navView!)
        
        let f = CGRect(x: 0, y: fn.maxY, width: SCREEN_W, height: SCREEN_H - fn.maxY)
        scrollView.frame = f
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.gray
        scrollView.delegate = self
        view.addSubview(scrollView)
    }
    
    private func loadChildView() {
        for i in 0..<navView!.titles.count {
            let baseVC = BaseViewController()
            baseVC.myType = PageNavViewBtnType(rawValue: PageNavViewBtnType.all.rawValue + i)!
            addChildViewController(baseVC)
            if i == 0 {
                NSLog("懒加载主要是调用了VC.view,当前初始化了%@", baseVC)
                baseVC.view.frame = CGRect(x: SCREEN_W * CGFloat(i), y: 0, width: SCREEN_W, height: scrollView.bounds.size.height)
                baseVC.updateTable(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: scrollView.bounds.size.height))
                scrollView.addSubview(baseVC.view)
                orderBaseVCLoads[0] = baseVC
                currentVC = baseVC
            }
            orderBaseVCs.append(baseVC)
        }
        scrollView.contentSize = CGSize(width: CGFloat(navView!.titles.count) * SCREEN_W, height: 0)
    }
    
    private func loadCurrentType() {
        let index = orderType.index
        let point = CGPoint(x: CGFloat(index) * SCREEN_W, y: 0)
        scrollView.setContentOffset(point, animated: true)
        navView?.setTypeClicked(orderType)
    }
    
    func loadBaseVCView(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index: Int = Int(x / SCREEN_W)
        if index >= orderBaseVCs.count || index < 0 { return }
        let baseVC = orderBaseVCs[index]
        currentVC = baseVC
        let alreadyVC = orderBaseVCLoads[index]
        if alreadyVC != nil { return }
        NSLog("懒加载主要是调用了VC.view,当前初始化了%@", baseVC)
        baseVC.view.frame = CGRect(x: SCREEN_W * CGFloat(index), y: 0, width: SCREEN_W, height: scrollView.bounds.size.height)
        baseVC.updateTable(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: scrollView.bounds.size.height))
        scrollView.addSubview(baseVC.view)
        orderBaseVCLoads[index] = baseVC
    }
    
    func getType(with scrollView: UIScrollView) -> PageNavViewBtnType {
        let x = scrollView.contentOffset.x
        var index: Int = Int(x / SCREEN_W)
        if index >= orderBaseVCs.count {
            index = orderBaseVCs.count - 1
        } else if index < 0 {
            index = 0
        }
        let type = PageNavViewBtnType(rawValue: PageNavViewBtnType.all.rawValue + index)!
        NSLog("index === \(index) type == \(type)")
        return type
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension PageVC: PageNavViewDelegate {
    
    func navViewClick(type: PageNavViewBtnType) {
        let index = type.index
        let point = CGPoint(x: CGFloat(index) * SCREEN_W, y: 0)
        scrollView.setContentOffset(point, animated: true)
    }
}

extension PageVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadBaseVCView(scrollView)
        let type = getType(with: scrollView)
        navView?.setTypeClicked(type)
        
        NSLog("停止拖拽")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        loadBaseVCView(scrollView)
        
        NSLog("动画结束")
    }
}
