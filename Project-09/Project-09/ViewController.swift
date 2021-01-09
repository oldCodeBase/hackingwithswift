//
//  ViewController.swift
//  Project-07
//
//  Created by Ibragim Akaev on 27/12/2020.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var numbers = [1, 2, 3, 4, 5, 6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petitions"
        navigationController?.navigationBar.prefersLargeTitles = true
        let credit = UIBarButtonItem(title: "Credits",
                                     style: .done,
                                     target: self,
                                     action: #selector(creditTapped))
        let sorting = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.circle"),
                                      style: .done,
                                      target: self,
                                      action: #selector(sortingPetitions))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                        target: self,
                                        action: #selector(refreshFilter))
        
        navigationItem.rightBarButtonItems = [credit, refresh, sorting]
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }

    @objc func fetchJSON() {
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=10"
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }

        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = petition.title
        content.secondaryText = petition.body
        content.textProperties.numberOfLines = 1
        content.secondaryTextProperties.numberOfLines = 1
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func creditTapped() {
        showAlert(title: "The data comes from:",
                  message: "The People API of the Whitehouse.")
    }
    
    @objc func refreshFilter() {
        if filteredPetitions != petitions {
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    @objc func sortingPetitions() {
        let alert = UIAlertController(title: "Do you want to filter?", message: "", preferredStyle: .alert)
        alert.addTextField()
        guard let textFieldText = alert.textFields?.first else { return }
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {_ in
            self.filteredPetitions.removeAll()
            for petition in self.petitions {
                if petition.title.uppercased().contains(textFieldText.text!.uppercased()) {
                    self.filteredPetitions.append(petition)
                }
            }
            
            self.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

