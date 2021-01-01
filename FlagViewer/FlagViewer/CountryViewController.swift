//
//  CountryViewController.swift
//  FlagViewer
//
//  Created by Hai Nguyen on 1/1/21.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet var flagImageView: UIImageView!
    var country: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = country!
        setUpShareButton()
        
        flagImageView.layer.borderWidth = 1
        
        if let imageToLoad = country {
            flagImageView.image = UIImage(named: imageToLoad.lowercased())
        }
    }
    
    func setUpShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc
    func shareTapped() {
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}
