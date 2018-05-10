//
//  ViewController.swift
//  TittleScrollView
//
//  Created by RunTu on 2018/5/10.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

import UIKit

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///单行显示
        
        //初始化
        let titleViewSingle = RTCycleView(frame: CGRect(x: (kWidth-300)/2, y: 180, width: 300, height: 30))
        //设置滚动方向 默认向上滚动
        titleViewSingle.upOrdown = .up
        //是否单行显示
        titleViewSingle.isSingleLine = true
        //设置滚动时间间隔
        titleViewSingle.autoScrollTimeInterval = 2.0
        //设置显示数据条数（已设置单行显示此处可不设置）
//        titleViewSingle.count = 1
        //装载数据源 此处装载dataSource 根据数据结构来选择
        titleViewSingle.dataSource = ["一去二三里","烟村四五家","亭台六七座","八九十枝花"]
        titleViewSingle.imageDataSource = ["1.jpg","2.png","3.jpg","4.jpg"]
        titleViewSingle.backgroundColor = UIColor.white
        view.addSubview(titleViewSingle)
        
        
        ///多行显示
        
        //初始化
        let titleView = RTCycleView(frame: CGRect(x: (kWidth-300)/2, y: 250, width: 300, height: 60))
        //设置滚动方向 默认向上滚动
        titleView.upOrdown = .up
        //设置滚动时间间隔
        titleView.autoScrollTimeInterval = 2.0
        //设置显示数据条数
        titleView.count = 2
        //装载数据源 此处装载dataArray 根据数据结构来选择
        titleView.dataArray = [["白日依山尽","黄河入海流"],["欲穷千里目","更上一层楼"]]
        titleView.imageDataSource = ["1.jpg","2.png"]
        titleView.backgroundColor = UIColor.white
        view.addSubview(titleView)
        
        let titleView2 = RTCycleView(frame: CGRect(x: (kWidth-300)/2, y: 350, width: 300, height: 90))
        titleView2.upOrdown = .down
        titleView2.autoScrollTimeInterval = 2.0
        titleView2.count = 3
        titleView2.dataArray = [["久有凌云志","重上井冈山","千里来寻故地"],["旧貌变新颜","到处莺歌燕舞","更有潺潺流水"],["高路入云端","过了黄洋界","险处不须看"],["风雷动","旌旗奋","是人寰"],["三十八年过去","弹指一挥间","可上九天揽月"],["可下五洋捉鳖","谈笑凯歌还","世上无难事"],["只要肯登攀","弹指一挥间","可上九天揽月"]]
        titleView2.imageDataSource = ["1.jpg","2.png","3.jpg","4.jpg","5.jpg","6.jpg","1.jpg"]
        titleView2.backgroundColor = UIColor.white
        view.addSubview(titleView2)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

