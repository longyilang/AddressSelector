//
//  ViewController.swift
//  AddressSelectorView
//
//  Created by 一郎龙 on 2022/3/11.
//

import UIKit

var dataAddressModel: AddressModel?

class ViewController: UIViewController {
    
    lazy private var addressView: AddressView = {
        let tmpview = AddressView()
        tmpview.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        tmpview.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        return tmpview
    }()
    
    lazy private var titleLb: UILabel = {
        let lb = UILabel()
        lb.font = .pingFangMedium(size: 16)
        lb.numberOfLines = 2
        lb.textAlignment = .center
        lb.text = "北京市 北京市 昌平区 北七家镇"
        return lb
    }()
    
    override func loadView() {
        super.loadView()
        
        let rightBtn = UIButton()
        rightBtn.frame = CGRect.init(x: ScreenWidth-100, y: 44, width: 80, height: 30)
        rightBtn.setTitle("选择地区", for: .normal)
        rightBtn.titleLabel?.font = .pingFangMedium(size: 16)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.addTarget(self, action: #selector(presentAddressSelectorView), for: .touchUpInside)
        self.view.addSubview(rightBtn)
        
        self.view.addSubview(titleLb)
        titleLb.snp.makeConstraints{make in
            make.top.equalTo(300)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(40)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if dataAddressModel == nil {
            DispatchQueue.global().async {
                self.reloadLocalData()
            }
        }
        
        addressView.selectAddressHandle = {[weak self] arr in
            guard let weakSelf = self else{return}
            weakSelf.titleLb.text = "\(arr[0].name) \(arr[1].name) \(arr[2].name) \(arr[3].name)"
        }
    }
    
    @objc func presentAddressSelectorView(){
        self.view.addSubview(addressView)
        let str = titleLb.text!
        let arr = str.components(separatedBy: " ")
        // 带地址传入
        addressView.traverse(province: arr[0] , city: arr[1], area: "", street: "")
        // 不带地址传入
        //addressView.traverse(province: "" , city: "" , area: "" , street: "" )
    }
}

extension ViewController{
    func reloadLocalData(){
        do {
            let filePath = Bundle.main.path(forResource: "city-new", ofType: "json")!
            let url = URL(fileURLWithPath: filePath)
            let result = try String.init(contentsOf: url)
            guard let model = AddressModel.deserialize(from: result) else { return }
            dataAddressModel = model
            
            //有地址存在缺失情况，用上一级地址填充空缺的四级地址
            for proviceModel in dataAddressModel!.data {
                for cityModel in proviceModel.children {
                    if cityModel.children.count == 0{
                        let areaModel = RegionModel.init()
                        areaModel.name = cityModel.name
                        areaModel.code = cityModel.code
                        
                        let streetModel = RegionModel.init()
                        streetModel.name = cityModel.name
                        streetModel.code = cityModel.code
                     
                        areaModel.children.append(streetModel)
                        cityModel.children.append(areaModel)
                    }else{
                        for areaModel in cityModel.children{
                            if areaModel.children.count == 0 {
                                let streetModel = RegionModel.init()
                                streetModel.name = areaModel.name
                                streetModel.code = areaModel.code
                                areaModel.children.append(streetModel)
                            }
                        }
                    }
                }
            }
        } catch let error as Error? {
            print("读取本地数据出现错误!",error as Any)
        }
    }
}

