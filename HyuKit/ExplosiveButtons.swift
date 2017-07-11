//
//  ExplosiveButtons.swift
//  HyuKit
//
//  Created by Hyubyn on 3/13/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit
import SnapKit

class ExplosiveButtons: UIView {
    lazy var containerView: UIView = {
        return UIView()
    }()
    
    lazy var mainButton: HyuButton = {
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: 0, y: 0, width: 50, height: 50), title: "Start", titleColor: UIColor.white, gradientColors: [UIColor.yellow, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 25))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        clipsToBounds = false;
        autoresizesSubviews = false;
        backgroundColor = UIColor.blue
        containerView.backgroundColor = UIColor.black
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.bottom.equalTo(0)
        }
        
        containerView.addSubview(mainButton);
        
        mainButton.snp.makeConstraints { (maker) in
            maker.leading.trailing.bottom.top.equalTo(0)
        }
    }

}
