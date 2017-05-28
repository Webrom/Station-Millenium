//
//  BaseController.swift
//  Station-Millenium
//
//  Created by Romain Caron on 21/03/2017.
//  Copyright © 2017 Romain Caron. All rights reserved.
//

import Foundation
import UIKit
class BaseController : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.frame =  (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))!
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubview(toBack: visualEffectView)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
}
