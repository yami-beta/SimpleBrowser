//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Takahiro Abe on 2018/11/18.
//  Copyright © 2018 yami-beta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // ホームページのURL。起動時にこのページを開く。
    let homeUrlString = "http://www.yahoo.co.jp"
    
    // URLのホワイトリスト。
    // このURLにあてはまればアプリ内ブラウザで表示許可。
    // 前方一致の正規表現で処理される。
    let whiteList = [
        "https?://.*\\.yahoo\\.co\\.jp",
        "https?://.*\\.yahoo\\.com",
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // ホームページを開く。
        open(urlString: homeUrlString)
    }

    // 文字列で指定されたURLをWeb Viewで開く。
    func open(urlString: String) {
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
    }
    
    // 文字列で指定されたURLをSafariで開く。
    func openInSafari(urlString: String) {
        if let nsUrl = URL(string: urlString) {
            UIApplication.shared.open(nsUrl)
        }
    }

    // 読込完了後の処理
    func stopLoading() {
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        backButton.isEnabled = true
        reloadButton.isEnabled = true
        stopButton.isEnabled = false
    }

    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        backButton.isEnabled = false
        reloadButton.isEnabled = false
        stopButton.isEnabled = true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        stopLoading()
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        // ユーザの操作によるリクエストでなければ表示許可。
        if navigationType == UIWebView.NavigationType.other {
            return true;
        }
        
        // 現在表示中のURLを取得。
        var theUrl: String
        if let unwrappedUrl = request.url?.absoluteString {
            theUrl = unwrappedUrl
        } else {
            // 現在表示中のURLが取得できない場合表示不許可。
            stopLoading()
            return false;
        }
        
        // ホワイトリストでループしてURLがホワイトリスト内にあるかチェック。
        var canStayInApp = false;
        for url in whiteList {
            if theUrl.range(of: url, options: NSString.CompareOptions.regularExpression) != nil {
                canStayInApp = true;
                break;
            }
        }
        
        if !canStayInApp {
            openInSafari(urlString: theUrl)
            stopLoading()
            return false;
        }
        return true
    }

    // MARK: - IBAction
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func stopButtonTapped(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
}

