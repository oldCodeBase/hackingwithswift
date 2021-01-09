//
//  MainTableViewController.swift
//  Challenge-01
//
//  Created by Ibragim Akaev on 24/12/2020.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private var countries = ["estonia", "france", "germany", "ireland",
                             "italy", "monaco", "nigeria", "poland",
                             "russia", "spain", "uk", "us"]
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.countryName.text = countries[indexPath.row].uppercased()
        cell.flagImage.image = UIImage(named: countries[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Country") as? CountryDetailViewController {
            vc.selectedCountry = countries[indexPath.row]
            vc.title = "\(countries[indexPath.row].uppercased())"
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
