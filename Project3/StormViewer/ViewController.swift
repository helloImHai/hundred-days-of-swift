//
//  ViewController.swift
//  StormViewer
//
//  Created by Hai Nguyen on 30/12/20.
//

// This file uses UI tool kit
import UIKit

// Empty default screentype
class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    // We override to customise how we want
    override func viewDidLoad() {
        // Apple viewDidLoad first
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // #selector(shareTapped) says that shareTapped will exist
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Declares constant fm system type to work with file system
        let fm = FileManager.default
        
        // Declares path that is the bundle path
        let path = Bundle.main.resourcePath! // Our bundle might not have a resource path, iOS has so safe
        
        // Declares items that is the content at that path
        let items = try! fm.contentsOfDirectory(atPath: path) // If we can't read the bundle smt is super wrong
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a piture to load
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    // This function is called by iOS, not by us
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageRank = indexPath.row + 1
            vc.numberOfImages = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc
    func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Download StormViewer on the Appstore now!"], applicationActivities: [])
        // This line is to let code run on ipad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

