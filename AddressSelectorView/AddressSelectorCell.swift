//
//  AddressSelectorCell.swift
//  Gree_Sales system
//
//  Created by 一郎龙 on 2022/3/3.
//

import UIKit

class AddressSelectorCell: UITableViewCell {
    
    static var identifier: String = "UITableViewCell"
    
    //索引
    lazy var indexLb: UILabel = {
        let label = UILabel()
        label.font = .pingFangMedium(size: 12)
        label.textColor = UIColor.init(hex: "#9B9DA7")
        return label
    }()
    
    //名称
    lazy var nameLb: UILabel = {
        let label = UILabel()
        label.font = .pingFangMedium(size: 14)
        label.textColor = UIColor.init(hex: "#3B4058")
        return label
    }()
    
    //勾选图标
    lazy var checkImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.isHidden = true
        imgView.image = UIImage.init(named: "勾选")
        return imgView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(indexLb)
        contentView.addSubview(nameLb)
        contentView.addSubview(checkImgView)
        
        indexLb.snp.makeConstraints{make in
            make.leading.equalTo(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(20)
        }
        
        nameLb.snp.makeConstraints{make in
            make.leading.equalTo(indexLb.snp.trailing).offset(16)
            make.trailing.equalTo(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        
        checkImgView.snp.makeConstraints{make in
            make.trailing.equalTo(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
