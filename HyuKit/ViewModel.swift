//
//  ViewModel.swift
//  HyuKit
//
//  Created by Hyubyn on 3/14/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit
import RxSwift

class ViewModel {
    var centerVariable = Variable<CGPoint?>(.zero)
    
    var backgroundColorObservable: Observable<UIColor>!
    
    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservable = centerVariable.asObservable().map({ center in
            guard let centerPoint = center else { return UIColor.red }
            let red = (centerPoint.x + centerPoint.y).truncatingRemainder(dividingBy: 255) / 255
            let green = (centerPoint.x * centerPoint.y).truncatingRemainder(dividingBy: 255) / 255
            let blue: CGFloat = 100.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        })
    }
    
}
