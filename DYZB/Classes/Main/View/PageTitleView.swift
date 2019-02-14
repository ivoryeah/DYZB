//
//  PageTitleView.swift
//  DYZB
//
//  Created by 冯强 on 2019/2/14.
//  Copyright © 2019 IVOR. All rights reserved.
//

import UIKit

private let kScrollLineH:CGFloat=2

class PageTitleView:UIView{
   //定义属性
    private var titles : [String]
    //懒加载属性
    private lazy var titleLabels:[UILabel]=[UILabel]()
    private lazy var scrollView:UIScrollView = {
        let scrollView=UIScrollView()
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.scrollsToTop=false
        scrollView.bounces=false
        return scrollView
    }()
    private lazy var scrollLine:UIView={
       let scrollLine=UIView()
        scrollLine.backgroundColor=UIColor.orange
       
        return scrollLine
    }()
    
    //自定义构造函数
    init(frame :CGRect,titles:[String]){
        self.titles = titles
        super.init(frame:frame)
       //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//设置UI界面
extension PageTitleView{
    private func setupUI(){
        
        //1.添加ScrollView
        addSubview(scrollView)
        scrollView.frame=bounds
       
      
        //2.title对应的label
        setupTitleLabels()
       //3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
        
    }
    private func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let bottomLine=UIView()
        bottomLine.backgroundColor=UIColor.lightGray
        let lineH:CGFloat=8.5
        bottomLine.frame=CGRect(x: 0, y: frame.height, width: frame.width, height: lineH)
        scrollView.addSubview(bottomLine)
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel=titleLabels.first else{return}
        firstLabel.textColor=UIColor.orange
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame=CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    private func setupTitleLabels(){
        //0 确定label的一些frame值
        let labelW:CGFloat=frame.width/CGFloat(titles.count)
        let labelH:CGFloat=frame.height-kScrollLineH
        
        let labelY:CGFloat=0
        
        for(index,title) in titles.enumerated(){
            //1.创建UILabel
            let label=UILabel()
            //2.设置label的属性
            label.text=title
            label.tag=index
            label.font=UIFont.systemFont(ofSize: 16.0)
            label.textColor=UIColor.darkGray
            label.textAlignment = .center
            //3.设置label的Frame
          
            let labelX:CGFloat=labelW * CGFloat(index)
           
            label.frame=CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
        }
    }
}
