//
//  FlightsCollectionCell.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 29/01/22.
//

import UIKit
import Kingfisher
import FlagKit
import SnapKit

class FlightsCollectionCell: UICollectionViewCell {
    
    let fromCityLbl = UILabel()
    let fromNameLbl = UILabel()
    let fromIcon = UIImageView()
    let fromCountryLbl = UILabel()
    let fromFlagIcon = UIImageView()
    
    let indexLbl = UILabel()
    let companyLbl = UILabel()
    let distLbl = UILabel()
    let compIcon = UIImageView()
    let icon = UIImageView()
    
    let toCityLbl = UILabel()
    let toNameLbl = UILabel()
    let toIcon = UIImageView()
    let toCountryLbl = UILabel()
    let toFlagIcon = UIImageView()
    
    let bgColor = UIColor.clear
    let color =  UIColor.black
    let hmg = 7
    let countrySize: CGFloat = 14
    let nameSize: CGFloat = 16
    let citySize = 15
    let divide = 3.2
    let multiply = 0.635
    
    let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        
        contentView.addSubview(fromCityLbl)
        contentView.addSubview(fromIcon)
        contentView.addSubview(fromNameLbl)
        contentView.addSubview(fromFlagIcon)
        contentView.addSubview(fromCountryLbl)
        
        fromCityLbl.backgroundColor = bgColor
        fromCityLbl.textAlignment = .left
        fromCityLbl.textColor = .black
        fromCityLbl.numberOfLines = 2
        fromCityLbl.font = UIFont.systemFont(ofSize: CGFloat(citySize), weight: UIFont.Weight.regular)
        fromCityLbl.snp.makeConstraints { make in
            make.top.equalTo(hmg)
            make.left.equalTo(hmg)
            make.right.equalToSuperview().dividedBy(divide)
        }
        fromIcon.image = UIImage(named: "fly")
        fromIcon.clipsToBounds = true
        fromIcon.backgroundColor = bgColor
        fromIcon.contentMode = .scaleToFill
        fromIcon.snp.makeConstraints { make in
            make.centerY.equalTo(fromNameLbl.snp.centerY)
            make.height.width.equalTo(nameSize)
            make.right.equalTo(fromCityLbl.snp.right)
        }
        fromNameLbl.backgroundColor = bgColor
        fromNameLbl.textAlignment = .left
        fromNameLbl.textColor = .black
        fromNameLbl.numberOfLines = 2
        fromNameLbl.font = UIFont.systemFont(ofSize: nameSize, weight: UIFont.Weight.semibold)
        fromNameLbl.snp.makeConstraints { make in
            make.top.equalTo(fromCityLbl.snp.bottom).offset(5)
            make.centerY.equalToSuperview()
            make.left.equalTo(fromCityLbl.snp.left)
            make.right.equalTo(fromIcon.snp.left).offset(-hmg)
        }
        fromFlagIcon.clipsToBounds = true
        fromFlagIcon.contentMode = .scaleToFill
        fromFlagIcon.snp.makeConstraints { make in
            make.left.equalTo(fromNameLbl.snp.left)
            make.height.width.equalTo(countrySize)
            make.bottom.equalTo(-5)
        }
        fromCountryLbl.backgroundColor = bgColor
        fromCountryLbl.textAlignment = .left
        fromCountryLbl.textColor = .black
        fromCountryLbl.font = UIFont.systemFont(ofSize: CGFloat(countrySize), weight: UIFont.Weight.regular)
        fromCountryLbl.snp.makeConstraints { make in
            make.centerY.equalTo(fromFlagIcon.snp.centerY)
            make.left.equalTo(fromFlagIcon.snp.right).offset(hmg)
            make.right.equalTo(fromCityLbl.snp.right)
        }
        contentView.addSubview(companyLbl)
        contentView.addSubview(indexLbl)
        contentView.addSubview(distLbl)
        
        indexLbl.backgroundColor = bgColor
        indexLbl.textAlignment = .center
        indexLbl.textColor = .black
        indexLbl.numberOfLines = 1
        indexLbl.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.semibold)
        indexLbl.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.height.equalTo(indexLbl.snp.width)
            make.centerX.equalToSuperview()
        }
        companyLbl.backgroundColor = bgColor
        companyLbl.textAlignment = .center
        companyLbl.textColor = .black
        companyLbl.numberOfLines = 2
        companyLbl.font = UIFont.systemFont(ofSize: nameSize*0.7, weight: UIFont.Weight.semibold)
        companyLbl.snp.makeConstraints { make in
            make.top.equalTo(indexLbl.snp.bottom).offset(2)
            make.left.equalTo(fromCityLbl.snp.right).offset(hmg)
            make.right.equalToSuperview().multipliedBy(multiply)
        }
        distLbl.backgroundColor = bgColor
        distLbl.textAlignment = .center
        distLbl.textColor = .black
        distLbl.font = UIFont.systemFont(ofSize: countrySize, weight: UIFont.Weight.bold)
        distLbl.snp.makeConstraints { make in
            make.top.equalTo(companyLbl.snp.bottom).offset(5)
            make.centerY.equalToSuperview()
            make.left.equalTo(companyLbl.snp.left)
            make.right.equalTo(companyLbl.snp.right)
        }
        contentView.addSubview(compIcon)
        compIcon.clipsToBounds = true
        compIcon.contentMode = .scaleAspectFill
        compIcon.snp.makeConstraints { make in
            make.top.equalTo(distLbl.snp.bottom).offset(hmg)
            make.bottom.equalTo(-hmg)
            make.left.equalTo(companyLbl.snp.left)
            make.right.equalTo(companyLbl.snp.right)
        }
        
        
        
        
        
        
        
        
        contentView.addSubview(toCityLbl)
        contentView.addSubview(toIcon)
        contentView.addSubview(toNameLbl)
        contentView.addSubview(toFlagIcon)
        contentView.addSubview(toCountryLbl)
        
        toCityLbl.backgroundColor = bgColor
        toCityLbl.textAlignment = .right
        toCityLbl.textColor = .black
        toCityLbl.numberOfLines = 2
        toCityLbl.font = UIFont.systemFont(ofSize: CGFloat(citySize), weight: UIFont.Weight.regular)
        toCityLbl.snp.makeConstraints { make in
            make.top.equalTo(hmg)
            make.left.equalTo(companyLbl.snp.right).offset(hmg)
            make.right.equalTo(-hmg)
        }
        toIcon.image = UIImage(named: "land")
        toIcon.clipsToBounds = true
        toIcon.backgroundColor = bgColor
        toIcon.contentMode = .scaleToFill
        toIcon.snp.makeConstraints { make in
            make.centerY.equalTo(toNameLbl.snp.centerY)
            make.height.width.equalTo(nameSize)
            make.left.equalTo(toCityLbl.snp.left)
        }
        toNameLbl.backgroundColor = bgColor
        toNameLbl.textAlignment = .right
        toNameLbl.textColor = .black
        toNameLbl.numberOfLines = 2
        toNameLbl.font = UIFont.systemFont(ofSize: nameSize, weight: UIFont.Weight.semibold)
        toNameLbl.snp.makeConstraints { make in
            make.top.equalTo(toCityLbl.snp.bottom).offset(5)
            make.centerY.equalToSuperview()
            make.left.equalTo(toIcon.snp.right).offset(hmg)
            make.right.equalTo(-hmg)
        }
        
        toCountryLbl.backgroundColor = bgColor
        toCountryLbl.textAlignment = .left
        toCountryLbl.textColor = .black
        toCountryLbl.font = UIFont.systemFont(ofSize: countrySize, weight: UIFont.Weight.regular)
        toCountryLbl.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(contentView.snp.width).dividedBy(divide).inset(countrySize/2)
            make.right.equalTo(toCityLbl.snp.right)
            make.bottom.equalTo(-5)
        }
        toFlagIcon.clipsToBounds = true
        toFlagIcon.contentMode = .scaleToFill
        toFlagIcon.snp.makeConstraints { make in
            make.right.equalTo(toCountryLbl.snp.left).offset(-hmg)
            make.height.width.equalTo(countrySize)
            make.centerY.equalTo(toCountryLbl.snp.centerY)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initDatas(_ routes: Routes?, rowIndex: Int, tansiteIndex: Int ){
        
        let from = routes?.flights[rowIndex][tansiteIndex].orig ?? ""
        let to = routes?.flights[rowIndex][tansiteIndex].dest ?? ""
        let comp = routes?.flights[rowIndex][tansiteIndex].ac ?? ""
        
        self.fromCityLbl.text = "\(routes?.airports["\(from)"]?.citycode ?? ""), \(routes?.airports["\(from)"]?.city_en ?? "")"
        self.fromNameLbl.text = "\(routes?.airports["\(from)"]?.iata ?? ""), \(routes?.airports["\(from)"]?.name ?? "")"
        self.fromCountryLbl.text = routes?.airports["\(from)"]?.country ?? ""
        self.fromFlagIcon.image = Flag(countryCode: routes?.airports["\(from)"]?.cc ?? "")?.image(style: .roundedRect)
        
        self.compIcon.setImage(with: routes?.flights[rowIndex][tansiteIndex].acImage ?? "", placeholder: "placeholder")
        self.companyLbl.text = "\(routes?.aircarriers["\(comp)"]?.name ?? "")"
        self.distLbl.text = "dist: \(routes?.flights[rowIndex][tansiteIndex].dist ?? "") km"

        self.toCityLbl.text = "\(routes?.airports["\(to)"]?.citycode ?? ""), \(routes?.airports["\(to)"]?.city_en ?? "")"
        self.toNameLbl.text = "\(routes?.airports["\(to)"]?.iata ?? ""), \(routes?.airports["\(to)"]?.name ?? "")"
        self.toCountryLbl.text = routes?.airports["\(to)"]?.country ?? ""
        self.toFlagIcon.image = Flag(countryCode: routes?.airports["\(to)"]?.cc ?? "")?.image(style: .roundedRect)
    }
    
   
}




extension UIImageView {
    func setImage(with urlString: String, placeholder: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}
    

