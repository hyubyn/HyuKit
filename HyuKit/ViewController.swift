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
import RxSwift

class ViewController: BaseViewViewController {

    lazy var demoButton: HyuButton = {
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: self.screenWidth / 4, y: self.screenHeight / 2 - 15, width: 100, height: 80), title: "Start", titleColor: UIColor.white, gradientColors: [UIColor.blue, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 30))
    }()
    
    lazy var colorPicker: ColorPicker = {
        let picker = ColorPicker()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Hello world, this is the first line of this application. I'm creating utilities for my own project"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var gradientLayer = CAGradientLayer()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    func setupView() {
        view.addSubview(demoButton)
        view.addSubview(colorPicker)
        view.addSubview(label)
        
        colorPicker.snp.makeConstraints { (maker) in
            maker.height.equalTo(80)
            maker.leading.trailing.equalTo(view).inset(20)
            maker.bottom.equalTo(demoButton.snp.top).inset(-50)
        }
        
        colorPicker.hideColorPicker()
        
        label.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalTo(view).inset(30)
        }
    }
    
    func setupRx() {
        demoButton.button.rx.tap
            .debug("Button tapped")
            .subscribe(onNext: { [weak self] in
                self?.demoButtonTapped()
            })
            .disposed(by: disposeBag)
    }

    func demoButtonTapped() {
        if colorPicker.isHidden {
            colorPicker.showColorPicker()
        } else {
            colorPicker.hideColorPicker()
        }
    }

}

extension ViewController: ColorPickerDelegate {
    func didSelectColor(color: UIColor) {
        label.textColor = color.getInverseColor()
        if var nearBy = color.getNearByColor() {
            nearBy.insert(color, at: 0)
            UIView.createGradientColors(for: view, with: nearBy, GradientStartPosition.top, layer: &gradientLayer)
        } else {
            UIView.createGradientColors(for: view, with: [color, color.getInverseColor()?.withAlphaComponent(0.5) ?? color.withAlphaComponent(0.5) ], GradientStartPosition.top, layer: &gradientLayer)
        }
        
    }
}

