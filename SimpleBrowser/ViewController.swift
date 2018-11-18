//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Takahiro Abe on 2018/11/18.
//  Copyright © 2018 yami-beta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
    }
}

