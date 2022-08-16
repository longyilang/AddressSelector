//
//  String+Length.swift
//  Gree_Sales system
//
//  Created by mac on 2020/7/21.
//  Copyright © 2020 com.gree. All rights reserved.
//

import Foundation

extension String {
    
    // limitCount 默认等于 4 意思是最大5位， dotCount 默认2 默认两位小数点
    func validateAmountCountAndDot(checkStr: String, limitCount: Int=4, dotCount: Int=2) -> Bool {
        
        let regex = "(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,\(limitCount)}(([.]\\d{0,\(dotCount)})?)))?"
        let predicte = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicte.evaluate(with: checkStr)
        return isValid
    }
    
    // limitCount 默认等于 4  dotCount 默认2 默认两位小数点
    func validateAmountCountAndDot(limitCount: Int=4, dotCount: Int=2) -> Bool {
        let limit = limitCount - 1
        let regex = "(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,\(limit)}(([.]\\d{0,\(dotCount)})?)))?"
        let predicte = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicte.evaluate(with: self)
        return isValid
    }
    
    //验证长度
    func validateAmountCount(checkStr: String, limitCount: Int=4) -> Bool {
        let regex = "(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,\(limitCount)}(([.]\\d{0,2})?)))?"
        let predicte = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicte.evaluate(with: checkStr)
        return isValid
    }
    
    ///字符串截取
    func subScript(index: Int, length: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: index)
        let endIndex = self.index(startIndex, offsetBy: length)
        return String(self[startIndex ..< endIndex])
    }
    
    
    subscript(_ indexs: ClosedRange<Int>) -> String {
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[beginIndex...endIndex])
    }
    
    subscript(_ indexs: Range<Int>) -> String {
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[beginIndex..<endIndex])
    }
    
    subscript(_ indexs: PartialRangeThrough<Int>) -> String {
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[startIndex...endIndex])
    }
    
    subscript(_ indexs: PartialRangeFrom<Int>) -> String {
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        return String(self[beginIndex..<endIndex])
    }
    
    subscript(_ indexs: PartialRangeUpTo<Int>) -> String {
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[startIndex..<endIndex])
    }

}

extension String {
    /// 获取子串位置
    func matchStringOfRange(pattern searchString: String) -> [NSRange] {
        let regex = try? NSRegularExpression(pattern: searchString, options: .caseInsensitive)
        let results = regex?.matches(in: self,
                                     options: NSRegularExpression.MatchingOptions(),
                                     range: NSRange(location: 0, length: self.count))
        return results?.map { $0.range } ?? []
    }
}
