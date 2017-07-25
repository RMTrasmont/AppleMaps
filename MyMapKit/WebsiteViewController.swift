//
//  WebsiteViewController.swift
//  MyMapKit
//
//  Created by Rafael M. Trasmontero on 5/12/17.
//  Copyright © 2017 TurnToTech. All rights reserved.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController {
    var webURL:URL?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let restaurantWebURL = webURL else {return}
        webView.loadRequest(URLRequest(url: restaurantWebURL))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
