//
//  Petition.swift
//  Project-07
//
//  Created by Ibragim Akaev on 27/12/2020.
//

import Foundation

struct Petition: Codable, Equatable {
    
    var title: String
    var body: String
    var signatureCount: Int
}
