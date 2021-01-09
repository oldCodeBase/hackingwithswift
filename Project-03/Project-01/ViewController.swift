//
//  ViewController.swift
//  Project-01
//
//  Created by Ibragim Akaev on 23/12/2020.
//

import UIKit

class ViewController: UITableViewController {
    
    private var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        guard let items = try? fm.contentsOfDirectory(atPath: path) else { return }
        
        for item in items {
            if item.hasPrefix("Picture") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = pictures[indexPath.row]
        content.textProperties.font = UIFont(name: "PingFang SC Thin", size: 18)!
        content.textProperties.color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
        }
    }
}

