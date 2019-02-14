//
//  PageContentView.swift
//  DYZB
//
//  Created by 冯强 on 2019/2/14.
//  Copyright © 2019 IVOR. All rights reserved.
//

import UIKit
class  PageContentView: UIView {
    private var childVcs:[UIViewController]
    private var parentViewController:UIViewController
    
  
    
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController) {
       self.childVcs=childVcs
        self.parentViewController=parentViewController
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
