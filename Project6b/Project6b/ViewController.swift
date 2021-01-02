//
//  ViewController.swift
//  Project6b
//
//  Created by Hai Nguyen on 2/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        var labels = [UILabel]()
        let texts = ["THESE", "ARE", "SOME", "AWESOME", "LABELS"]
        let colors: [UIColor] = [.red, .cyan, .yellow, .green, .orange]
        
        for i in 0...4 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = colors[i]
            label.text = texts[i]
            label.sizeToFit()
            labels.append(label)
        }
        for i in 0...4 {
            view.addSubview(labels[i])
        }

//        var viewsDictionary: [String : UILabel] = [:]
//        for i in 1...5 {
//            viewsDictionary["label\(i)"] = labels[i - 1]
//        }
//
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        
        var previous: UILabel?

        for label in labels {
            // Part 1 of challenge, replace width anchor with trailing and leading
            // Part 2 of challenge, replace with safeAreaLayoutGuide
            // label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true

            if let previous = previous {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // this is the first label
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }

            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
    }

}

