//
//  ViewController.swift
//  Challenge-01
//
//  Created by Ibragim Akaev on 24/12/2020.
//

import UIKit

class CountryDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var countryName: UILabel!
    
    // MARK: - Public Properties
    var selectedCountry: String?
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        flagImage.image = UIImage(named: selectedCountry ?? "")
        countryName.text = (selectedCountry ?? "").uppercased()
        flagImage.layer.borderWidth = 2
        flagImage.layer.borderColor = #colorLiteral(red: 0.1602793634, green: 0.1644741595, blue: 0.1861864924, alpha: 1)
    }
}

