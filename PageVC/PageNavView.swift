//
//  NavView.swift
//  PageVC
//
//  Created by Jonhory on 2017/3/31.
//  Copyright © 2017年 com.wujh. All rights reserved.
//

import UIKit

enum PageNavViewBtnType: Int {
    
    case all = 534
    case waitPay
    case waitAudit
    case waitGetGoods
    case waitEvaluation
    case finished
}

extension PageNavViewBtnType {
    
    var index: Int {
        switch self {
        case .all: return 0
        case .waitPay: return 1
        case .waitAudit: return 2
        case .waitGetGoods: return 3
        case .waitEvaluation: return 4
        case .finished: return 5
        }
    }
}

protocol PageNavViewDelegate: class {
    
    func navViewClick(type: PageNavViewBtnType)
}

class PageNavView: UIView {

    weak var delegate: PageNavViewDelegate?
    // 跟MyOrderNavViewBtnType.all 保持一致
    private let myOrderNavViewTagBegin: Int = 534
    let titles: [String] = ["全部", "待付款", "待审核", "待收货", "待评价", "已完成"]
    private var titleBtns: [String: UIButton] = [:]

    // 滑动背景
    private let scrollView = UIScrollView()
    // 小滑块
    private let sliderView = UIView()
    private let line = UIView()
    private var sliderWidth: CGFloat = 75.0
    private var currentBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        backgroundColor = UIColor.gray
    }
    
    public func setTypeClicked(_ type: PageNavViewBtnType) {
        let btn: UIButton = viewWithTag(type.rawValue) as! UIButton
        if currentBtn == btn {
            return
        }
        btn.isSelected = true
        currentBtn?.isSelected = false
        currentBtn = btn
        UIView.animate(withDuration: 0.5) {
            self.sliderView.frame.origin.x = self.sliderWidth * CGFloat(btn.tag - self.myOrderNavViewTagBegin)
        }
        if type == .finished {
            let point = CGPoint(x: sliderWidth * CGFloat(type.rawValue - PageNavViewBtnType.waitEvaluation.rawValue), y: 0)
            scrollView.setContentOffset(point, animated: true)
        } else if type == .all {
            let point = CGPoint(x: 0, y: 0)
            scrollView.setContentOffset(point, animated: true)
        }
    }
    
    func btnClick(_ btn: UIButton) {
        if currentBtn == btn { return }
        currentBtn?.isSelected = false
        btn.isSelected = true
        currentBtn = btn
        UIView.animate(withDuration: 0.5) {
            self.sliderView.frame.origin.x = self.sliderWidth * CGFloat(btn.tag - self.myOrderNavViewTagBegin)
        }
        delegate?.navViewClick(type: PageNavViewBtnType.init(rawValue: btn.tag)!)
    }
    
    private func loadUI() {
        if iPhonePlus() {
            sliderWidth = 82.8
        }
        let f = CGRect(x: 0, y: 0, width: self.bounds.width, height: 49)
        scrollView.frame = f
        scrollView.backgroundColor = UIColor.white
        scrollView.bounces = true
        scrollView.contentSize = CGSize(width: sliderWidth * CGFloat(titles.count), height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        let fl = CGRect(x: 0, y: 48.5, width: self.bounds.width, height: 0.5)
        line.frame = fl
        line.backgroundColor = UIColor.gray
        addSubview(line)
        
        for i in 0..<titles.count {
            let btn = loadBtn(with: titles[i], tag: i+myOrderNavViewTagBegin)
            if i == 0 {
                btn.isSelected = true
                currentBtn = btn
            }
            btn.frame = CGRect(x: CGFloat(i)*sliderWidth, y: 0, width: sliderWidth, height: 49)
            scrollView.addSubview(btn)
        }
        
        let fs = CGRect(x: 0, y: 47, width: sliderWidth, height: 2)
        sliderView.backgroundColor = UIColor.black
        sliderView.frame = fs
        scrollView.addSubview(sliderView)
    }
    
    private func loadBtn(with title: String, tag: Int) -> UIButton {
        let btn = UIButton(type: .custom)
        titleBtns[title] = btn
        btn.tag = tag
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle(title, for: UIControlState())
        btn.setTitleColor(UIColor.black, for: .selected)
        btn.setTitleColor(UIColor.lightGray, for: UIControlState())
        return btn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
