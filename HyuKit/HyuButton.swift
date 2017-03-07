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
    
    init() {
        frame = CGRect()
        title = ""
        titleColor = nil
        gradientColors = nil
        gradientOrientation = .horizontal
        cornerRadius = 0
        shadowOffset = CGSize()
        shadowOpacity = 1.0
    }
    
    init(frame: CGRect!, title: String?, titleColor: UIColor?, gradientColors: [UIColor]?, gradientOrientation: GradientOrientation, cornerRadius: CGFloat = 5, shadowOffset: CGSize = CGSize(width: 0.5, height: 0.5), shadowOpacity: Float = 1.0) {
        
        self.frame = frame
        
        self.title = title
        
        self.titleColor = titleColor
        
        self.gradientColors = gradientColors
        
        self.gradientOrientation = gradientOrientation
        
        self.cornerRadius = cornerRadius
        
        self.shadowOffset = shadowOffset
        
        self.shadowOpacity = shadowOpacity
        
    }
    
}


class HyuButton: UIView {
    
    var properties: GradientButtonProperties?
    var button: UIButton!
    
    init(properties: GradientButtonProperties) {
        
        super.init(frame: properties.frame)
        
        self.properties = properties
        
        //create shadow view
        backgroundColor = UIColor.clear
        
        layer.shadowOpacity = properties.shadowOpacity
        
        layer.shadowOffset = properties.shadowOffset
        
        layer.shadowColor = UIColor.black.cgColor
        
        layer.shadowRadius = 2
        
        layer.masksToBounds = false
        //create subview
        
        let width = properties.frame.size.width
        
        let height = properties.frame.size.height
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        addSubview(button)
        
        button.clipsToBounds = true
        
        button.setTitle(properties.title, for: .normal)
        
        button.setTitleColor(properties.titleColor, for: .normal)
        
        button.titleLabel?.minimumScaleFactor = 0.5
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        button.titleLabel?.numberOfLines = 2
        
        button.layer.cornerRadius = properties.cornerRadius
        
        createCornerGradientBackground(colors: properties.gradientColors, gradientOrientation: properties.gradientOrientation)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCornerGradientBackground(colors gradientColors: [UIColor]?, gradientOrientation orientations: GradientOrientation) {
        
        guard let colors = gradientColors else { return }
        
        button.applyGradient(withColours: colors, gradientOrientation: orientations);
    }
}
