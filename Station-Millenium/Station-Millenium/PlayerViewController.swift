//
//  FirstViewController.swift
//  Station-Millenium
//
//  Created by Romain Caron on 21/03/2017.
//  Copyright © 2017 Romain Caron. All rights reserved.
//

import UIKit

class PlayerViewController: BaseController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var lastFiveButton: UIButton!
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
        
        lastFiveButton.layer.cornerRadius = 0.5 * lastFiveButton.bounds.size.width // add the round corners in proportion to the button size
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.dark))
        blur.frame = lastFiveButton.bounds
        blur.layer.cornerRadius = 0.05 * lastFiveButton.bounds.size.width
        blur.clipsToBounds = true
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
        lastFiveButton.insertSubview(blur, at: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

