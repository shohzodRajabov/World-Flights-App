//
//  FlightsCell.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 29/01/22.
//

import UIKit

class FlightsCell: UITableViewCell {
    
    var qwe:(Int)->() = {_ in }

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FlightsCollectionCell.self, forCellWithReuseIdentifier: "FlightsCollectionCell")
        return collectionView
    }()
    
    var orient: Int = 0
    var h: CGFloat = 130
    var w = UIScreen.main.bounds.width
    var index = 0
    var routes: Routes? {
        didSet{
            collectionView.reloadData()
            collectionView.setContentOffset(CGPoint(x:-5,y:0), animated: false)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pushVC () {
        
    }
    
    func reload(or: Int) {
        self.orient = or
        if or == 1 { h = 130 }
        if or == 2 { h = 230 }
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-5)
            make.left.equalTo(5)
            make.height.equalTo(h)
            make.bottom.equalTo(-10)
        }
    }
}

extension FlightsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routes?.flights[index].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightsCollectionCell", for: indexPath) as! FlightsCollectionCell
        cell.initDatas(routes, rowIndex: index, tansiteIndex: indexPath.row)
        cell.indexLbl.text = "\(indexPath.row + 1)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if orient == 1 {
            return CGSize(width: UIScreen.main.bounds.width * 0.93 , height: h)
        }
        return CGSize(width: UIScreen.main.bounds.width * 0.87 , height: h)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let home = HomeViewController()
        let vc = MapViewController()
        home.present(vc, animated: true, completion: nil)
        print("Goooooo")
        qwe(indexPath.row)
    }
    
    
    
}


