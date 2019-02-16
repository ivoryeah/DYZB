//
//  PageTitleView.swift
//  DYZB
//
//  Created by 冯强 on 2019/2/14.
//  Copyright © 2019 IVOR. All rights reserved.
//

import UIKit
//MARK：定义协议
protocol PageTitleViewDelegate:class  {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
    }
//MARK:定义常量
private let kScrollLineH:CGFloat=2
private let KNormalColor:(CGFloat,CGFloat,CGFloat)=(85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat)=(255,120,0)

class PageTitleView:UIView{
    //MARK:定义属性
    private var currentIndex: Int = 0
    private var titles : [String]
   
    weak var delegate :PageTitleViewDelegate?
    
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
        firstLabel.textColor=UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
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
            label.textColor=UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            label.textAlignment = .center
            //3.设置label的Frame
            let labelX:CGFloat=labelW * CGFloat(index)
            label.frame=CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            //5.给label添加手势
            label.isUserInteractionEnabled=true
            let tapGes=UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
}

//MARK:监听label点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer){
       // print("____")
        //1.获取当前label
        guard let currnetLable=tapGes.view as? UILabel else {
            return
        }
        // 2.获取之前的label
        let oldLable=titleLabels[currentIndex]
        //3.切换文字的颜色
        currnetLable.textColor=UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLable.textColor=UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        //4.保存最新的label
        currentIndex=currnetLable.tag
        //5.滚动条位置发生改变
        let scrollLinex=CGFloat(currnetLable.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x=scrollLinex
        }
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK:对外暴露方法
extension PageTitleView{
    func  setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        //1.取出sourceLabel/targetLabel
        let sourceLabel=titleLabels[sourceIndex]
        let targetLabel=titleLabels[targetIndex]
        //2.处理滑块的逻辑
        let moveTotalX=targetLabel.frame.origin.x-sourceLabel.frame.origin.x
        let moveX=moveTotalX * progress
        scrollLine.frame.origin.x=sourceLabel.frame.origin.x+moveX
        //3.颜色的渐变（复杂）
        //3.1取出变化的范围
        let colorDelta=(kSelectColor.0-KNormalColor.0,kSelectColor.1-KNormalColor.1,kSelectColor.2-KNormalColor.2)
        //3.2变化sourceLabel
        sourceLabel.textColor=UIColor(r: kSelectColor.0-colorDelta.0*progress, g: kSelectColor.1-colorDelta.1*progress, b: kSelectColor.2-colorDelta.2*progress)
        //3.3变化targetLabel
        targetLabel.textColor=UIColor(r: KNormalColor.0+colorDelta.0*progress, g: KNormalColor.1+colorDelta.1*progress, b: KNormalColor.2+colorDelta.2*progress)
        //4.记录最新的index
        currentIndex=targetIndex
    }
}
