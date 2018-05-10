//
//  RTCycleView.swift
//  RunTu
//
//  Created by RunTu on 2018/5/10.
//  Copyright © 2018年 xxx. All rights reserved.
//

import UIKit

enum scrollUpAndDown {
    case up     //上翻
    case down   //下翻
}

class RTCycleView: UIView,UIScrollViewDelegate {
    
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    private var topView = TitleCycleView()
    private var middleView = TitleCycleView()
    private var bottomView = TitleCycleView()
    
    private var timer:Timer?
    open var autoScrollTimeInterval: TimeInterval?
    //滚动方向 默认向上翻
    open var upOrdown:scrollUpAndDown = .up
    
    //是否是单行显示
    open var isSingleLine: Bool? {
        didSet {
            guard isSingleLine != false else {
                return
            }
            topView.titleCount = 1
            middleView.titleCount = 1
            bottomView.titleCount = 1
        }
    }
    
    //记录当前的title index
    private var currentIndex: NSInteger = 0
    
    //设置要显示几行
    open var count: NSInteger? {
        didSet {
            topView.titleCount = count
            middleView.titleCount = count
            bottomView.titleCount = count
        }
    }
    
    //记录数组个数
    private var titleCount: NSInteger?
    
    //多行显示 接收数据源
    var dataArray:[[String]]? {
        didSet {
            guard dataArray?.count != 0 else {
                return
            }
            currentIndex = 0
            titleCount = dataArray?.count
            addDataToLabelByIndex(currentIndex)
            createTimer()
        }
    }
    
    //单行显示 接收数据源
    var dataSource:[String]? {
        didSet {
            guard dataSource?.count != 0 else {
                return
            }
            currentIndex = 0
            titleCount = dataSource?.count
            addDataToLabelByIndex(currentIndex)
            createTimer()
        }
    }
    
    //图片数据源
    var imageDataSource:[String?]?
    
    
    lazy var scrollView: UIScrollView =  {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isUserInteractionEnabled = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
        scrollView.addSubview(topView)
        scrollView.addSubview(middleView)
        scrollView.addSubview(bottomView)
        
        width = scrollView.frame.size.width
        height = scrollView.frame.size.height
        
        updateViewFrame()
        
    }

    
    fileprivate func updateViewFrame() {
        
        scrollView.contentSize = CGSize(width: width * 3, height: height)
        scrollView.contentOffset = CGPoint(x: 0, y: height)
        
        topView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        middleView.frame = CGRect(x: 0, y: height, width: width, height: height)
        bottomView.frame = CGRect(x: 0, y: height * 2, width: width, height: height)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RTCycleView {
    
    fileprivate func addDataToLabelByIndex(_ index: NSInteger) {
        
        let topIndex = (index - 1 + titleCount!) % titleCount!
        let bottmIndex = (index + 1) % titleCount!
        
        if let count = imageDataSource?.count {
            if count > 0 {
                topView.imageName = imageDataSource?[topIndex]
                middleView.imageName = imageDataSource?[index]
                bottomView.imageName = imageDataSource?[bottmIndex]
            }
        }
        
        guard let single = isSingleLine,single == true else {
            topView.titleArray = dataArray?[topIndex]
            middleView.titleArray = dataArray?[index]
            bottomView.titleArray = dataArray?[bottmIndex]
            return
        }
        
        topView.singleData = dataSource?[topIndex]
        middleView.singleData = dataSource?[index]
        bottomView.singleData = dataSource?[bottmIndex]
        
    }
    
    
    fileprivate func createTimer () {
        
        timer = Timer(timeInterval: autoScrollTimeInterval!, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .commonModes)
        
    }
    
    @objc func autoScroll() {
        //开始显示的是中间，设置往上翻就是翻到下面的view,设置往下翻就是翻到上面的view
        guard upOrdown == .up else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            return
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: height * 2), animated: true)
    }

}

// MARK: -scrollView的代理方法
extension RTCycleView {
    
    //减速滑动完成
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //重新装填数据
        reload()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    
    func reloadTitle() {
        if upOrdown == .up {
            currentIndex = (currentIndex + 1) % titleCount!
        } else {
            currentIndex = (currentIndex - 1 + titleCount!) % titleCount!
        }
        addDataToLabelByIndex(currentIndex)
    }
    
    func reload() {
        
        reloadTitle()
        scrollView.setContentOffset(CGPoint(x: 0, y: height), animated: false)
        
    }
    
    
}



