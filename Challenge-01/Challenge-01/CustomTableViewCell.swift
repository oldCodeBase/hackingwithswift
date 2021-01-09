//
//  CustomTableViewCell.swift
//  Challenge-01
//
//  Created by Ibragim Akaev on 24/12/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
   
    // MARK: - IBOutlets
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var countryName: UILabel!
    
    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        flagImage.layer.borderColor = #colorLiteral(red: 0.1602793634, green: 0.1644741595, blue: 0.1861864924, alpha: 1)
        flagImage.layer.borderWidth = 2
    }

}
