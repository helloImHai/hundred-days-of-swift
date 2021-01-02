//
//  DetailViewController.swift
//  WhitehousePetitions
//
//  Created by Hai Nguyen on 2/1/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h3>\(detailItem.title)</h3>
        <p><small><em>Number of signatures \(detailItem.signatureCount)</em></small></p>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    
}
