//
//  AdressModel.swift
//  Gree_Sales system
//
//  Created by 一郎龙 on 2021/12/24.
//

import Foundation
import HandyJSON

class AddressModel: HandyJSON {
    var data: [RegionModel] = []
    required init() {}
}

class RegionModel: HandyJSON {
    var code: String = ""
    var name: String = ""
    var children: [RegionModel] = []
    required init() {}
}
