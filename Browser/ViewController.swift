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
    @IBOutlet var backBtn: UIBarButtonItem!
    @IBOutlet var forwardBtn: UIBarButtonItem!
    @IBOutlet var reloadBtn: UIBarButtonItem!
    
    
    // MARK: - Parameters
    var urlStr = "https://www.apple.com"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.isEnabled = false
        forwardBtn.isEnabled = false
        
        urlField.delegate = self
        
        mainWebView.navigationDelegate = self
        mainWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        mainWebView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        mainWebView.loadUrlString(urlString: urlStr)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            backBtn.isEnabled = mainWebView.canGoBack
            forwardBtn.isEnabled = mainWebView.canGoForward
        } else if keyPath == "estimatedProgress" {
            progressBar.isHidden = mainWebView.estimatedProgress == 1
            progressBar.setProgress(Float(mainWebView.estimatedProgress), animated: true)
        }
    }


    // MARK: - Actions
    @IBAction func backBtnClicked(_ sender: UIBarButtonItem) {
        mainWebView.goBack()
    }
    
    @IBAction func forwardBtnClicked(_ sender: UIBarButtonItem) {
        mainWebView.goForward()
    }
    
    @IBAction func reloadBtnClicked(_ sender: UIBarButtonItem) {
        mainWebView.reload()
    }
}


// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        urlField.resignFirstResponder()
        
        if let str = textField.text {
            urlStr = "https://" + str
            mainWebView.loadUrlString(urlString: urlStr)
        }
        
        return false
    }
}


// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        urlField.text = webView.url?.absoluteString
        
        progressBar.setProgress(0, animated: false)
    }
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
