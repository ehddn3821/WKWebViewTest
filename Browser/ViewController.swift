//
//  ViewController.swift
//  Browser
//
//  Created by dwKang on 2021/05/02.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var urlField: UITextField!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var mainWebView: WKWebView!
    
    
    // MARK: - Parameters
    var urlStr = "https://www.apple.com"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlField.delegate = self
        
        mainWebView.navigationDelegate = self
        mainWebView.loadUrlString(urlString: urlStr)
    }


}


//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    
}


// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    
}


// MARK: - WKWebView Extension
extension WKWebView {
    func loadUrlString(urlString: String) {
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
