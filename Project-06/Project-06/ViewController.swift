//
//  ViewController.swift
//  Project-06
//
//  Created by Ibragim Akaev on 27/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.red
        label.text = "THESE"
        label.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        /*
         label1.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
         label1.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
         label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
         label1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
         label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
         label1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
         label1.textAlignment = .center
         
         let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
         
         let metrics = ["height": 88]
         
         for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|",
                                                                                 options: [],
                                                                                 metrics: nil,
                                                                                 views: viewsDictionary))
         }
         
         view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:
                                    "V:|-[label1(height@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|",
                                    options: [],
                                    metrics: metrics,
                                    views: viewsDictionary
                                    ))
         */
        
        var previous: UILabel?

        for label in [label, label2, label3, label4, label5] {
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: -10).isActive = true
            
            if let previous = previous {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // this is the first label
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }
    
}

