//
//  APPConfig.swift
//  Gree_Sales system
//
//  Created by mac on 2020/5/15.
//  Copyright © 2020 com.gree. All rights reserved.
//

import Foundation
import UIKit

/**
 机型的屏幕大小
 */
let Device_Is_PHONE = __CGSizeEqualToSize(CGSize.init(width: 750/2, height: 1334/2), UIScreen.main.bounds.size)
let Device_Is_PHONEPlus = __CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2208/3), UIScreen.main.bounds.size)
let Device_Is_iPhoneX = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)
let Device_Is_iPhoneXr = __CGSizeEqualToSize(CGSize.init(width: 828/2, height: 1792/2), UIScreen.main.bounds.size)
let Device_Is_iPhoneXs = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)
let Device_Is_iPhoneXs_Max = __CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2688/3), UIScreen.main.bounds.size)
let Device_Is_iPhone12_Min = __CGSizeEqualToSize(CGSize.init(width: 1080/3, height: 2340/3), UIScreen.main.bounds.size)
let Device_Is_iPhone12_And_Pro = __CGSizeEqualToSize(CGSize.init(width: 1170/3, height: 2532/3), UIScreen.main.bounds.size)
let Device_Is_iPhone12Pro_Max = __CGSizeEqualToSize(CGSize.init(width: 1284/3, height: 2778/3), UIScreen.main.bounds.size)
let isIphoneX = (Device_Is_iPhoneX || Device_Is_iPhoneXr || Device_Is_iPhoneXs || Device_Is_iPhoneXs_Max || Device_Is_iPhone12_Min || Device_Is_iPhone12_And_Pro || Device_Is_iPhone12Pro_Max)
 
/**
状态栏高度
 */
let Height_StatusBar: CGFloat = (isIphoneX ? 44 : 20)
/**
 顶部状态栏+导航高度
 */

/**
 底部安全区域的高度
 */
/**
 Tabbar高度
 */
let Height_TabBar: CGFloat = (isIphoneX ? 83 : 49)
/**
 顶部安全区域高度
 //当左边从0开始时，iPhoneX可以编辑的有效区域是44以下，其他的是20以下，如果自定义navbar的话，有效区最好加上44-20，避免不能编辑的问题
 */

/**
 错误提示信息Cell的row高度
 */
let EMPTY_CELL_HEIGHT: CGFloat = 282

/**
 网络异常统一错误提示
 */
let GMNetworkingError: String = "当前网络不佳"
/**
 没有网络统一提示
 */
let GMNotNetWorkingTips: String = "当前设备网络不可用"

/**
 商品数量减少限制提示语
 */
let GMGoodsReduce: String = "宝贝不能再少了"
let GMGoodsIncrease: String = "宝贝已添加达上限"


//---UIColor
func RGBCOLOR(r:CGFloat , g:CGFloat , b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

func RGBCOLOR(r:CGFloat , g:CGFloat , b:CGFloat , a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func RGBSAMECOLOR(x:CGFloat, a:CGFloat) -> UIColor {
    return UIColor.init(red: (CGFloat(x/255.0)), green: (CGFloat(x/255.0)), blue: (CGFloat(x/255.0)), alpha: a)
}

func GM_ScaleValue(_ original:CGFloat) -> (CGFloat) {
   return (ScreenWidth / 375) * original
}

//---默认占位图
func DEFAULT_SQUARE_IMG() -> UIImage? {
    return UIImage.init(named: "defaultSquareImg")
}

func DEFAULT_RECTANGLE_IMG() -> UIImage? {
    return UIImage.init(named: "defaultRectangleImg")
}

//获取本地图片
func APPImage(name :String) -> UIImage? {
    return UIImage.init(named: name)
}

//设置字体
extension UIFont {
    // 可以通过let names = UIFont.fontNames(forFamilyName: "PingFang SC") 来遍历所有PingFang 的字体名字 iOS9.0 以后支持
    /*
     PingFangSC-Medium
     PingFangSC-Semibold
     PingFangSC-Light
     PingFangSC-Ultralight
     PingFangSC-Regular
     PingFangSC-Thin
     */
    static func bold(_ size:CGFloat)->UIFont{
        pingFangBold(size: size)
    }
    static func regular(_ size:CGFloat)->UIFont{
        pingFangRegular(size: size)
    }
    static func medium(_ size:CGFloat)->UIFont{
        pingFangMedium(size: size)
    }
    static func heavy(_ size:CGFloat)->UIFont{
        pingFangHeavy(size: size)
    }
    static func light(_ size:CGFloat)->UIFont{
        guard let font = UIFont(name: "PingFangSC-Light", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .light)
        }
        return font
    }
    public static func pingFangRegular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    public static func pingFangMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    public static func pingFangSemibold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public static func pingFangBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Bold", size: size) else {
            return UIFont.pingFangSemibold(size: size)
        }
        return font
    }
    
    /// PingFangSC-Heavy,
    public static func pingFangHeavy(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "PingFangSC-Heavy", size: size) else {
            return UIFont.pingFangSemibold(size: size)
        }
        return font
    }
}

func APPFontSize(x: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: x)
}


func APPFontSizeAndWeight(X: CGFloat, W: UIFont.Weight) -> UIFont {
    return UIFont.systemFont(ofSize: X, weight: W)
}

/// 打印封装
/// - Parameters:
///   - message: 需要打印的信息
///   - file: 文件名，默认文件路径最后一个
///   - funcName: 函数名，默认打印所在函数
///   - lineNum: 行数，默认打印所在行数
func GMLog<T>(_ message: T, file: NSString = #file, funcName: String = #function, lineNum: Int = #line) {
    #if DEBUG
    let fileName: String = file.lastPathComponent
    print("\(fileName)-\(funcName)-(\(lineNum))-\(message)")
    #endif
}

#if !targetEnvironment(simulator)
func print(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    #if DEBUG
    Swift.print(items,separator:separator,terminator: terminator)
    #endif
}
#endif
