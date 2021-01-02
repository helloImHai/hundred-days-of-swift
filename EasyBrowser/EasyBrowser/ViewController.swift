//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Hai Nguyen on 2/1/21.
//

import UIKit

class ViewController: UITableViewController {
    var websites: [String] = ["google.com", "helloimhai.github.io"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Easy Browser"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteRow", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "WebViewController") as? WebViewController {
            vc.websiteToLoad = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
