//
//  OpenedNewsViewController.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/31/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import UIKit
import WebKit

var page_url = ""

class OpenedNewsViewController: UIViewController {

    
    @IBOutlet var web: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        web.load(URLRequest(url:URL(string: page_url)!))
    }
  



}
