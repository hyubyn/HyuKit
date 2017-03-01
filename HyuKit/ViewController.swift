//
//  ViewController.swift
//  HyuKit
//
//  Created by Hyubyn on 2/28/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa

class ViewController: BaseViewViewController {

    lazy var demoButton: HyuButton = {
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: self.screenWidth / 4, y: self.screenHeight / 2 - 15, width: self.screenWidth / 2, height: 30), title: "Hello Hyu's button", titleColor: UIColor.white, gradientColors: [UIColor.blue, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 15, showShadow: false))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    func setupView() {
        view.addSubview(demoButton)
        demoButton.addTarget(self, action: #selector(demoButtonTapped), for: .touchUpInside)
        
    }
    
    func setupRx() {
        demoButton.rx.tap.bindNext { _ in
            print("The button is pressed")
        }.dispose()
    }

    func demoButtonTapped() {
        print("The button is pressed")
    }

}

