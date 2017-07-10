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
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: self.screenWidth / 4, y: self.screenHeight / 2 - 15, width: 80, height: 80), title: "Start", titleColor: UIColor.white, gradientColors: [UIColor.blue, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 40))
    }()
    
    lazy var firstButton: HyuButton = {
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: 0, y: 0, width: 80, height: 80), title: "Start", titleColor: UIColor.white, gradientColors: [UIColor.blue, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 40))
    }()
    
    lazy var secondButton: HyuButton = {
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: 0, y: 0, width: 80, height: 80), title: "Start", titleColor: UIColor.white, gradientColors: [UIColor.blue, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 40))
    }()
    
    lazy var thirdButton: HyuButton = {
        return HyuButton(properties: GradientButtonProperties(frame: CGRect(x: 0, y: 0, width: 80, height: 80), title: "Start", titleColor: UIColor.white, gradientColors: [UIColor.blue, UIColor.green], gradientOrientation: .horizontal, cornerRadius: 40))
    }()
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.addSubview(self.firstButton)
        view.addSubview(self.secondButton)
        view.addSubview(self.thirdButton)
        return view
    }()
    
    let disposeBag = DisposeBag()
    var isShowing = false
    
    // demo observable with RxSwift
    lazy var circleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 25
        return view
    }()
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    func setupView() {
        view.addSubview(demoButton)
        
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(demoButton)
            maker.center.equalTo(demoButton)
        }
        
        firstButton.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(demoButton)
            maker.leading.equalTo(0)
            maker.top.equalTo(0)
        }
        
        secondButton.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(demoButton)
            maker.centerX.equalTo(0)
            maker.top.equalTo(0)
        }
        
        thirdButton.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(demoButton)
            maker.trailing.equalTo(0)
            maker.top.equalTo(0)
        }
        
        view.bringSubview(toFront: demoButton);
        
        view.addSubview(circleView)
        
        // Add gesture recognizer
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
    
    func setupRx() {
        demoButton.button.rx.tap
            .debug("Button tapped")
            .subscribe(onNext: { [weak self] in
                self?.demoButtonTapped()
            })
            .disposed(by: disposeBag)
        
        circleView
            .rx.observe(CGPoint.self, "center")
            .bindTo(viewModel.centerVariable)
            .addDisposableTo(disposeBag)
        
        viewModel.backgroundColorObservable
            .subscribe(onNext: { [weak self](backgroundColor) in
                UIView.animate(withDuration: 0.1) {
                    self?.view.backgroundColor = backgroundColor
                }
            }).addDisposableTo(disposeBag)
        
        
    
    }

    func demoButtonTapped() {
        UIView.animate(withDuration: 2.5, animations: {
            if self.isShowing {
                self.containerView.snp.remakeConstraints { (maker) in
                    maker.width.height.equalTo(self.demoButton)
                    maker.center.equalTo(self.demoButton)
                }
            } else {
                self.containerView.snp.makeConstraints { (maker) in
                    maker.width.height.equalTo(self.view.snp.width).dividedBy(2)
                    maker.centerX.equalTo(self.demoButton)
                    maker.bottom.equalTo(self.demoButton)
                }
            }
        }) { (_) in
            self.isShowing = !self.isShowing
            self.view.layoutIfNeeded()
        }
        
        
    }

}

