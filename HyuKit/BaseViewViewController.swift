//
//  BaseViewViewController.swift
//  HyuKit
//
//  Created by Hyubyn on 3/1/17.
//  Copyright © 2017 Hyubyn. All rights reserved.
//

import UIKit

class BaseViewViewController: UIViewController {

    var screenWidth: CGFloat {
        return self.view.frame.size.width
    }
    
    var screenHeight: CGFloat {
        return self.view.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
