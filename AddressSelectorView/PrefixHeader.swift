//
//  PrefixHeader.swift
//  Gree_Sales system
//
//  Created by Gree on 2021/10/20.
//  Copyright © 2020 com.gree. All rights reserved.
//

import Foundation
import UIKit

@_exported import SnapKit
@_exported import HandyJSON
@_exported import Hue




let kScreen : UIScreen = UIScreen.main
let ScreenWidth : CGFloat = UIScreen.main.bounds.width
let ScreenHeight : CGFloat = UIScreen.main.bounds.height

/**安全区域顶部高度*/

/**安全区域底部高度*/
let SafeAreaBottomHeight : CGFloat = (ScreenHeight >= 812.0) ? 34 : 0


let ApplicationStatusBarHeight = UIApplication.shared.statusBarFrame.height

//状态栏高度
let STATUS_BAR_HEIGHT: CGFloat = ApplicationStatusBarHeight

// SE的屏幕
let iPhoneSE = UIScreen.main.bounds.width == 320 ? true : false
// 6/6S/7/8
let iPhone6Late = UIScreen.main.bounds.width == 375 ? true : false

//iPhone X机模适配高度
func RatioHeight(height : CGFloat) -> CGFloat {
    return (ScreenWidth / 375.0 * (height))
}
