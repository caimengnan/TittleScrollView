//
//  TitleCycleView.swift
//  RunTu
//
//  Created by RunTu on 2018/5/10.
//  Copyright © 2018年 xxx. All rights reserved.
//

import UIKit

class TitleCycleView: UIView {
    
    //要显示几行title
    var titleCount:NSInteger? {
        didSet {
            guard let titleCount = titleCount else {
                return
            }
            let titleHeight: CGFloat = self.frame.size.height/CGFloat(titleCount)
            for i in 0...titleCount-1 {
                let titlelabel = UILabel()
                titlelabel.tag = 1000 + i
                titlelabel.frame = CGRect(x: 50, y: titleHeight * CGFloat(i), width: self.frame.size.width-50-self.frame.size.height, height: titleHeight)
                self.addSubview(titlelabel)
            }
            
            for i in 0...titleCount-1 {
                let tiplabel = UILabel()
                tiplabel.frame = CGRect(x: 5, y: titleHeight * CGFloat(i)+4, width: 40, height: titleHeight-8)
                tiplabel.layer.cornerRadius = 3
                tiplabel.layer.borderColor = UIColor.orange.cgColor
                tiplabel.layer.borderWidth = 1.0
                tiplabel.text = i%2 == 0 ? "精品" : "推荐"
                tiplabel.textColor = UIColor.orange
                tiplabel.font = UIFont.systemFont(ofSize: 12)
                tiplabel.textAlignment = .center
                self.addSubview(tiplabel)
            }
            
            let rightImage = UIImageView(frame: CGRect(x: self.bounds.size.width-self.bounds.size.height, y: 0, width: self.bounds.size.height, height: self.bounds.size.height))
            rightImage.image = UIImage(named: "2.png")
            rightImage.tag = 100
            self.addSubview(rightImage)
            
        }
    }
    
    
    //多行显示数据
    var titleArray:[String]? {
        didSet {
            addTitleWithCount(titleArray ?? [])
        }
    }
    
    //单行显示数据
    var singleData: String? {
        didSet {
            addTitleWithCount([singleData ?? ""])
        }
    }
    
    //图片
    var imageName: String? {
        didSet {
            guard let imageName = imageName else { return }
            let imageView = self.viewWithTag(100) as! UIImageView
            imageView.image = UIImage(named: imageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -添加title
extension TitleCycleView {
    
    fileprivate func addTitleWithCount(_ titleArray: [String]) {
        let count = titleArray.count
        guard count != 0 else {
            return
        }
        
        for i in 0...count-1 {
            let title = self.viewWithTag(1000+i) as! UILabel
            title.text = titleArray[i]
        }
        
    }
    
    
}
