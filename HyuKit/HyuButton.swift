//
//  HyuButton.swift
//  HyuKit
//
//  Created by Hyubyn on 2/28/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//
import SnapKit
import Foundation
import RxSwift

struct GradientButtonProperties {
    var frame: CGRect!
    var title: String?
    var titleColor: UIColor?
    var gradientColors: [UIColor]?
    var gradientOrientation: GradientOrientation
    var cornerRadius: CGFloat
    var shadowOffset: CGSize
    var shadowOpacity: Float
    var showShadow: Bool
    
    init(frame: CGRect!, title: String?, titleColor: UIColor?, gradientColors: [UIColor]?, gradientOrientation: GradientOrientation, cornerRadius: CGFloat = 5, shadowOffset: CGSize = CGSize(width: 0, height: 1.0), shadowOpacity: Float = 0.7, showShadow: Bool = false) {
        
        self.frame = frame
        
        self.title = title
        
        self.titleColor = titleColor
        
        self.gradientColors = gradientColors
        
        self.gradientOrientation = gradientOrientation
        
        self.cornerRadius = cornerRadius
        
        self.shadowOffset = shadowOffset
        
        self.shadowOpacity = shadowOpacity
        
        self.showShadow = showShadow
    }
}


class HyuButton: UIButton {
    var properties: GradientButtonProperties?
    
    init(properties: GradientButtonProperties) {
        
        super.init(frame: properties.frame)
        
        clipsToBounds = true
        
        self.properties = properties
        
        setTitle(properties.title, for: .normal)
        
        setTitleColor(properties.titleColor, for: .normal)
        
        titleLabel?.minimumScaleFactor = 0.5
        
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        if !properties.showShadow {
            
            createCornerGradientBackground(colors: properties.gradientColors, gradientOrientation: properties.gradientOrientation)
            
        } else {
            self.layer.masksToBounds = false
            if let colors = properties.gradientColors {
                backgroundColor = colors[0]
            } else {
                backgroundColor = AppColor.defaultAppTheme
            }
        }
        
        layer.cornerRadius = properties.cornerRadius
        
        layer.shadowOpacity = properties.shadowOpacity
        
        layer.shadowOffset = properties.shadowOffset
        
        layer.shadowRadius = properties.cornerRadius
        
        layer.shadowColor = UIColor.black.cgColor
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCornerGradientBackground(colors gradientColors: [UIColor]?, gradientOrientation orientations: GradientOrientation) {
        guard let colors = gradientColors else { return }
        self.applyGradient(withColours: colors, gradientOrientation: orientations);
    }
}
