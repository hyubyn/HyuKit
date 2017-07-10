//
//  ColorPicker.swift
//  HyuKit
//
//  Created by NguyenVuHuy on 7/10/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate {
    func didSelectColor(color: UIColor)
}

class ColorPicker: UIView {
    
    var listColor = [UIColor.white, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.brown, UIColor.red, UIColor.purple, UIColor.gray, UIColor.darkGray, UIColor.black]
    
    var delegate: ColorPickerDelegate?
    
    lazy var collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize.init(width: 50, height: 50)
        flowLayout.estimatedItemSize = CGSize.init(width: 50, height: 50)
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorPickerCell")
        return collectionView
    }()
    func addColor(color: UIColor) {
        listColor.insert(color, at: 0)
        collection.reloadData()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
        addCornerRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(collection)
        
        collection.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        isHidden = true
    }
    
    // Animate show Color Picker
    func showColorPicker() {
        animateShow()
    }
    
    // Animate hide Color Picker
    func hideColorPicker() {
        animateHide()
    }
}

extension ColorPicker: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorPickerCell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = listColor[indexPath.row]
        cell.addCircle()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            hideColorPicker()
            delegate.didSelectColor(color: listColor[indexPath.row])
        }
    }
}

