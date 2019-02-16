//
//  uiButton_extension.swift
//  DYZB
//
//  Created by 冯强 on 2019/2/13.
//  Copyright © 2019 IVOR. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
   /* 类方式
     class func createItem(imageName:String,highImageName:String,size:CGSize)->UIBarButtonItem{
        let btn=UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame=CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //便利构造函数1､convenience开头 2､在构造函数中必须明确调用一个设计的构造函数（self)
    @objc convenience init(imageName:String,highImageName:String,size:CGSize){
    let btn=UIButton()
    btn.setImage(UIImage(named: imageName), for: .normal)
    btn.setImage(UIImage(named: highImageName), for: .highlighted)
    btn.frame=CGRect(origin: CGPoint.zero, size: size)
        self.init(customView:btn)
}

}
