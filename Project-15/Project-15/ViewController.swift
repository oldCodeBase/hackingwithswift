//
//  ViewController.swift
//  Project-15
//
//  Created by Ibragim Akaev on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = view.center
        view.addSubview(imageView)
    }
    
    @IBAction func tapped(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5, options: [], animations: {
                        
                        switch self.currentAnimation {
                        case 0:
                            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                        case 1:
                            self.imageView.transform = CGAffineTransform.identity
                        case 2:
                            self.imageView.transform = CGAffineTransform(translationX: -340, y: -180)
                        case 3:
                            self.imageView.transform = CGAffineTransform.identity
                        case 4:
                            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        case 5:
                            self.imageView.transform = CGAffineTransform.identity
                        case 6:
                            self.imageView.alpha = 0
                            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        case 7:
                            self.imageView.alpha = 1
                            self.imageView.transform = CGAffineTransform.identity
                        default:
                            break
                        }
                        
                    }) { finished in
                }
        
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}

