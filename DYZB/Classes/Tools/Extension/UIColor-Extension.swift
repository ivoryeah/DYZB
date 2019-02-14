//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 冯强 on 2019/2/14.
//  Copyright © 2019 IVOR. All rights reserved.
//

import UIKit
extension UIColor{
    convenience init(r :CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.01, alpha: 1.0)
    }
}
