//
//  AddressCell.swift
//  Gree_Sales system
//
//  Created by 一郎龙 on 2022/3/2.
//

import UIKit



class AddressCell: UITableViewCell {
    enum LinePosition {
        case down
        case middle
        case top
    }
    
    static var identifier: String = "AddressCell"
    
    lazy var titleLb: UILabel = {
        let label = UILabel()
        label.font = .pingFangRegular(size: 14.0)
        label.textColor = UIColor.init(hex: "#3B4058")
        return label
    }()
    
    lazy var roundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#409EFF")
        view.layer.cornerRadius = 3.5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hex: "#409EFF").cgColor
        return view
    }()
    
    lazy private var toplineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#409EFF")
        return view
    }()
    
    lazy private var downlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#409EFF")
        return view
    }()
    
    lazy private var rightImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage.init(named: "客户信息_右箭头")
        return imgView
    }()

   
    var model: Any?{
        didSet{
            guard let _model = model else{return}
            if _model is RegionModel {
                let tmp = _model as! RegionModel
                titleLb.text = tmp.name
            }else{
                let tmp = _model as! String
                titleLb.text = tmp
            }
        }
    }
    
    var position: LinePosition?{
        didSet{
            guard let _position = position else{return}
            toplineView.removeFromSuperview()
            downlineView.removeFromSuperview()
            if _position == .down {
                contentView.addSubview(downlineView)
                downlineView.snp.makeConstraints{make in
                    make.centerX.equalTo(roundView)
                    make.top.equalTo(roundView.snp.top).offset(0)
                    make.bottom.equalTo(0)
                    make.width.equalTo(1)
                }
                roundView.backgroundColor = UIColor.init(hex: "#409EFF")
            }else if _position == .top{
                contentView.addSubview(toplineView)
                toplineView.snp.makeConstraints{make in
                    make.centerX.equalTo(roundView)
                    make.top.equalTo(0)
                    make.bottom.equalTo(roundView.snp.top)
                    make.width.equalTo(1)
                }
                if model is String {
                    roundView.backgroundColor = .white
                }else{
                    roundView.backgroundColor = UIColor.init(hex: "#409EFF")
                }
            }else{
                contentView.addSubview(toplineView)
                contentView.addSubview(downlineView)
                toplineView.snp.makeConstraints{make in
                    make.centerX.equalTo(roundView)
                    make.top.equalTo(0)
                    make.bottom.equalTo(roundView.snp.top)
                    make.width.equalTo(1)
                }
                downlineView.snp.remakeConstraints{make in
                    make.centerX.equalTo(roundView)
                    make.top.equalTo(roundView.snp.bottom)
                    make.bottom.equalTo(0)
                    make.width.equalTo(1)
                }
                roundView.backgroundColor = UIColor.init(hex: "#409EFF")
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(titleLb)
        contentView.addSubview(roundView)
        contentView.addSubview(rightImgView)
        
        roundView.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(14)
            make.width.equalTo(7)
            make.height.equalTo(7)
        }
        
        rightImgView.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
            make.width.equalTo(19)
            make.height.equalTo(19)
        }
        
        titleLb.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(roundView.snp.trailing).offset(22)
            make.trailing.equalTo(rightImgView.snp.leading).offset(10)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
