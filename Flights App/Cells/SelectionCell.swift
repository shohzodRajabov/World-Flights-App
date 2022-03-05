//
//  SelectionCell.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 28/01/22.
//

import UIKit

class SelectionCell: UITableViewCell {

    let fromWhere = UIButton()
    let toWhere = UIButton()
    let change = UIButton()
    let total = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        
        contentView.addSubview(change)
        contentView.addSubview(fromWhere)
        contentView.addSubview(toWhere)
        contentView.addSubview(total)
        
        change.setImage(UIImage(named: "change")?.withRenderingMode(.alwaysTemplate), for: .normal)
        change.backgroundColor = .clear
        change.tintColor = .orange
        change.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        fromWhere.setTitle("from where?", for: .normal)
        fromWhere.backgroundColor = .orange
        fromWhere.tintColor = .red
        fromWhere.titleLabel?.textColor = .red
        fromWhere.layer.cornerRadius = 8
        fromWhere.tag = 11
        fromWhere.snp.makeConstraints { make in
            make.centerY.equalTo(change.snp.centerY)
            make.left.equalTo(20)
            make.right.equalTo(change.snp.left).offset(-20)
        }
        
        toWhere.setTitle("to where ?", for: .normal)
        toWhere.backgroundColor = .orange
        toWhere.tintColor = .red
        toWhere.titleLabel?.textColor = .red
        toWhere.layer.cornerRadius = 8
        toWhere.tag = 12
        toWhere.snp.makeConstraints { make in
            make.centerY.equalTo(change.snp.centerY)
            make.right.equalTo(-20)
            make.left.equalTo(change.snp.right).offset(20)
        }
        total.backgroundColor = .clear
        total.textAlignment = .center
        total.textColor = .white
        total.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        total.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(change.snp.bottom).offset(20)
            make.bottom.equalTo(-10)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initDatas(_ str: String){
        
        self.total.text = str
    
    }
    
    
    
    
    
}
