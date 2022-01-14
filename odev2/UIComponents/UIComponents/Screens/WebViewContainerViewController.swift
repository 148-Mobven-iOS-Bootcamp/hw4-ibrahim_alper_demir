//
//  WebViewContainerViewController.swift
//  UIComponents
//
//  Created by Semih Emre ÜNLÜ on 9.01.2022.
//

import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goBackwardButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    @IBOutlet weak var openInSafariButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // configureWebView()
        configureActivityIndicator()
        addObservers()
        loadHtmlString()
    }

    var urlString = "https://www.google.com"

    func configureWebView() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
//        webView.configuration = configuration
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.load(urlRequest)
    }
    
    func loadHtmlString() {
        webView.loadHTMLString(
            """
            <body>
                <p><font color="red" face="Verdana, Geneva, sans-serif" size="16">whoami</font></p>
            </body>
            """,
            baseURL: nil
        )
    }
    
    func addObservers() {
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.isLoading),
            options: .new,
            context: nil
        )
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.canGoBack),
            options: .new,
            context: nil
        )
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.canGoForward),
            options: .new,
            context: nil
        )
    }

    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        switch keyPath {
        case "loading":
            webView.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        case "canGoBack":
            goBackwardButton.isEnabled = webView.canGoBack
        case "canGoForward":
            goForwardButton.isEnabled = webView.canGoForward
        default:
            break
        }
    }

    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func goBackwardButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func openInSafariButtonTapped(_ sender: UIBarButtonItem) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

extension WebViewContainerViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let url = webView.url?.absoluteString {
            self.urlString = url
        }
    }

}

extension WebViewContainerViewController: WKUIDelegate {

}
