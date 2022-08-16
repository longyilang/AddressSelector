//
//  AddressView.swift
//  Gree_Sales system
//
//  Created by 一郎龙 on 2022/3/2.
//

import UIKit

class AddressView: UIView {
    
    typealias selectAddressBlock = (Array<RegionModel>)->()
    var selectAddressHandle: selectAddressBlock?
    
    var modelArray: Array<Any> = []
    var addressArray: Array<(key: Swift.String, value: Array<RegionModel>)> = []
    var selectedIndex: Int = 0
    
    private lazy var tblView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 196, width: ScreenWidth, height: ScreenHeight - 196), style: .grouped)
        tableView.register(AddressCell.self, forCellReuseIdentifier: AddressCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 14
        tableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        return tableView
    }()
    
    private lazy var addressTblView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.register(AddressSelectorCell.self, forCellReuseIdentifier: AddressSelectorCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
}

extension AddressView{
    func loadUI(){
        self.addSubview(tblView)
        self.updateUI()
        
        self.addSubview(addressTblView)
        addressTblView.snp.remakeConstraints{make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(tblView.snp.bottom).offset(0)
        }
    }
    
    func updateUI(){
        tblView.snp.remakeConstraints{make in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(196)
            if modelArray.count == 1 {
                make.height.equalTo(96)
            }else{
                make.height.equalTo(96+modelArray.count*48)
            }
            make.height.equalTo(96+modelArray.count*48)
        }
        self.tblView.reloadData()
    }
    
    func setData(data: Any){
        var dataArr: [RegionModel] = []
        if data is AddressModel {
            let tmpData = data as! AddressModel
            dataArr = tmpData.data
        }else{
            let tmpData = data as! RegionModel
            dataArr = tmpData.children
        }
        if dataArr.count == 0 {
            return
        }
        
        var tmpDic: Dictionary<String,Array<RegionModel>> = Dictionary<String,Array<RegionModel>>()
        for model in dataArr{
            var key: String = ""
            key = self.findFirstLetterFromString(aString: model.name)
            var arr = tmpDic[key] ?? Array<RegionModel>()
            arr.append(model)
            tmpDic[key] = arr
        }
        
        //处理了第二个字首字母排序
        _ = tmpDic.keys.compactMap{ key in
            var tmpArr = tmpDic[key]!
            tmpArr = tmpArr.sorted{(model1,model2) in
                var key1 = ""
                var key2 = ""
                key1 = self.findFirstLetterFromString(aString: model1.name, isSecond: true)
                key2 = self.findFirstLetterFromString(aString: model2.name, isSecond: true)
                return key1 < key2
            }
            tmpDic[key] = tmpArr
        }
        addressArray = tmpDic.sorted{$0.key < $1.key}
        self.addressTblView.reloadData()
    }
    
    func traverse(province: String, city: String, area: String, street: String){
        modelArray.removeAll()
        let dataArr: [RegionModel] = dataAddressModel?.data ?? AddressModel.init().data
        self.recursive(dataArr: dataArr, province: province, city: city, area: area, street: street)
        
        if dataAddressModel != nil {
            self.setData(data: dataAddressModel!)
        }
        selectedIndex = 0
        if modelArray.count == 0 {
            modelArray.append("请选择")
        }
        self.loadUI()
    }
    
    func recursive(dataArr: [RegionModel], province: String, city: String, area: String, street: String){
        for model in dataArr{
            if model.name.contains(province) {
                modelArray.append(model)
                self.recursive(dataArr: model.children, province: province, city: city, area: area, street: street)
                break
            }
            if model.name.contains(city){
                modelArray.append(model)
                self.recursive(dataArr: model.children, province: province, city: city, area: area, street: street)
                break
            }
            if model.name.contains(area){
                modelArray.append(model)
                self.recursive(dataArr: model.children, province: province, city: city, area: area, street: street)
                break
            }
            if model.name.contains(street){
                modelArray.append(model)
                break
            }
        }
    }
}

extension AddressView{
    @objc func actionForClose(){
        self.removeFromSuperview()
    }
}

extension AddressView{
    func findFirstLetterFromString(aString: String, isSecond : Bool = false) -> String {
        //转变成可变字符串
        let mutableString = NSMutableString.init(string: aString)
        
        //将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil,      kCFStringTransformToLatin, false)
        
        //去掉声调
        let pinyinString = mutableString.folding(options:          String.CompareOptions.diacriticInsensitive, locale:   NSLocale.current)
        
        //将拼音首字母换成大写
        let strPinYin = polyphoneStringHandle(nameString: aString,    pinyinString: pinyinString).uppercased()
        
        //截取大写首字母
        let arr = strPinYin.components(separatedBy: " ")
        let completeStr = isSecond == false ? arr[0] : arr[1]
        let firstString = completeStr.subScript(index: 0, length: 1)
        //判断首字母是否为大写
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    //多音字处理，根据需要添自行加
    func polyphoneStringHandle(nameString: String, pinyinString: String) -> String {
        //        if nameString.hasPrefix("长") {return "chang"}
        //        if nameString.hasPrefix("沈") {return "shen"}
        //        if nameString.hasPrefix("厦") {return "xia"}
        //        if nameString.hasPrefix("地") {return "di"}
        //        if nameString.hasPrefix("重") {return "chong"}
        return pinyinString
    }
}

extension AddressView: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblView {
            return 1
        }else{
            return addressArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblView {
            if modelArray.count == 1 && (modelArray.last is String) {
                return 0
            }else{
                return modelArray.count
            }
        }else{
            let dic = addressArray[section]
            let arr = dic.value
            return arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblView {
            return 48
        }else{
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tblView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier, for: indexPath) as! AddressCell
            let model = modelArray[indexPath.row]
            if selectedIndex == indexPath.row {
                cell.titleLb.textColor = UIColor.init(hex: "#409EFF")
            }else{
                cell.titleLb.textColor = UIColor.init(hex: "#3B4058")
            }
            if model is RegionModel {
                let tmp = model as! RegionModel
                cell.titleLb.text = tmp.name
            }else{
                cell.titleLb.text = model as? String
            }
            
            if indexPath.row == 0 {
                cell.position = .down
            }else if indexPath.row == modelArray.count-1{
                cell.position = .top
            }else{
                cell.position = .middle
            }
            
            return cell
        }else{
            let dic = addressArray[indexPath.section]
            let arr = dic.value
            let model = arr[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressSelectorCell.identifier, for: indexPath) as! AddressSelectorCell
            
            if indexPath.row == 0 {
                cell.indexLb.text = dic.key
            }else{
                cell.indexLb.text = ""
            }
            cell.nameLb.text = model.name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblView {
            return 48
        }else{
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tblView {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 48))
            let label = UILabel.init()
            label.font = .pingFangSemibold(size: 18)
            label.textColor = UIColor.init(hex: "#3B4058")
            label.text = "请选择所在地区"
            
            let closeBtn: UIButton = {
                let btn = UIButton()
                btn.setImage(UIImage.init(named: "Work_delete"), for: .normal)
                btn.addTarget(self, action: #selector(actionForClose), for: .touchUpInside)
                return btn
            }()
            
            view.addSubview(label)
            view.addSubview(closeBtn)
            label.snp.makeConstraints{make in
                make.centerY.equalTo(view)
                make.centerX.equalTo(view)
                make.width.equalTo(130)
                make.height.equalTo(30)
            }
            closeBtn.snp.makeConstraints{make in
                make.trailing.equalTo(-16)
                make.centerY.equalTo(view)
                make.width.equalTo(48)
                make.height.equalTo(48)
            }
            return view
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == tblView {
            return 48
        }else{
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView == tblView {
            let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 48))
            let label = UILabel.init()
            label.font = .pingFangSemibold(size: 16)
            label.textColor = UIColor.init(hex: "#3B4058")
            
            if selectedIndex == 0 {
                label.text = "选择省份/地区"
            }else if selectedIndex == 1{
                label.text = "选择城市"
            }else if selectedIndex == 2{
                label.text = "选择区/县"
            }else{
                label.text = "选择街道/镇"
            }
            
            view.addSubview(label)
            label.snp.makeConstraints{make in
                make.top.equalTo(0)
                make.leading.equalTo(8)
                make.width.equalTo(150)
                make.height.equalTo(30)
            }
            return view
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tblView == tableView {
            if indexPath.row == 0 {
                self.setData(data: dataAddressModel!)
            }else{
                let model = modelArray[indexPath.row-1]
                self.setData(data: model)
            }
            selectedIndex = indexPath.row
            self.tblView.reloadData()
        }else{
            let dic = addressArray[indexPath.section]
            let arr = dic.value
            let model = arr[indexPath.row]
            
            let index = modelArray.firstIndex{$0 is String} ?? 0
            if modelArray[selectedIndex] is String && modelArray.count < 5{
                modelArray.insert(model, at: index)
                if modelArray.count == 5 {
                    modelArray.removeLast()
                }
            }else{
                modelArray[selectedIndex] = model
                for i in (selectedIndex+1 ... modelArray.count-1).reversed(){
                    if modelArray[i] is String {
                        continue
                    }
                    modelArray.remove(at: i)
                }
                if !modelArray.contains(where: {$0 is String}){
                    modelArray.append("请选择")
                }
            }
            
            if modelArray.count == 4 && !modelArray.contains(where: {$0 is String}){
                var arr: [RegionModel] = []
                for model in modelArray {
                    let obj = model as! RegionModel
                    arr.append(obj)
                }
                selectAddressHandle?(arr)
                self.removeFromSuperview()
            }else{
                self.setData(data: model)
                self.updateUI()
                selectedIndex += 1
            }
        }
    }
}

extension AddressView{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        let p = self.layer.convert(point, from: self.layer)
        if self.layer.contains(p) {
            self.removeFromSuperview()
        }
    }
}
