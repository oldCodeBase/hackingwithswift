//
//  ViewController.swift
//  Challenge-03
//
//  Created by Ibragim Akaev on 31/12/2020.
//

import UIKit

class ViewController: UIViewController {
    private let defaults = UserDefaults.standard
    var person: Person!
    var person2 = Person(name: "Alihan", age: 30, surename: "Bulaev")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(50, forKey: "age")
        defaults.set("Ibragim", forKey: "name")
        
        defaults.integer(forKey: "age")
        defaults.string(forKey: "name")
    }
    
    func loadDataFromUD() {
        if let savedData = defaults.object(forKey: "person") {
            let jsonDecoder = JSONDecoder()
            do {
                self.person2 = try? jsonDecoder.decode(self, from: savedData)
            } catch {
                print("Failed to load Data")
            }
        }
        
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(person) {
            defaults.set(savedData, forKey: "person")
        }
    }
}

