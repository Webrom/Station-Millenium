//
//  PodcastController.swift
//  Station_Millenium_Sur_iOS
//
//  Created by Romain Caron on 10/09/2016.
//  Copyright © 2016 Station Millenium. All rights reserved.
//

import UIKit

class PodcastController: UIViewController {
    
    
    @IBOutlet weak var podWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: Global.URL.podcast);
        let requestObj = NSURLRequest(URL: url!);
        podWebView.loadRequest(requestObj);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
