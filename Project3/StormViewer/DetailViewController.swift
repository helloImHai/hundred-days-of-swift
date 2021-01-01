//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Hai Nguyen on 31/12/20.
//

import UIKit

class DetailViewController: UIViewController {
    // We are certain that it will not be nil when we use it
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imageRank: Int?
    var numberOfImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(imageRank!) of \(numberOfImages!)"
        // Just for this screen
        navigationItem.largeTitleDisplayMode = .never
        
        // #selector(shareTapped) says that shareTapped will exist
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc
    func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image, "Image name: \(selectedImage!)"], applicationActivities: [])
        // This line is to let code run on ipad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
