//
//  ListTableViewController.swift
//  Challenge-02
//
//  Created by Ibragim Akaev on 27/12/2020.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    private var shoppingList = ["Bread", "Milk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .red
        
        let add = UIBarButtonItem(barButtonSystemItem: .add,
                                  target: self,
                                  action: #selector (addButtonTapped))
        
        let delete = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                     style: .plain,
                                     target: self,
                                     action: #selector (clearShoppingList))
        
        let share = UIBarButtonItem(barButtonSystemItem: .action,
                                    target: self,
                                    action: #selector(shareTapped))
        
        navigationItem.rightBarButtonItems = [share, delete, add]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = shoppingList[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    @objc func addButtonTapped() {
        
        let ac = UIAlertController(title: "Do you want to add new element on your list?",
                                   message: "",
                                   preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Save", style: .default) { [weak self, weak ac] action in
            guard let element = ac?.textFields?.first?.text else { return }
            self?.addElement(element)
        })
        
        ac.addAction(UIAlertAction(title: "No",
                                   style: .destructive))
        
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    private func addElement(_ element: String) {
        
        var shopListUpperCase: [String] = []
        for listItem in shoppingList {
            shopListUpperCase.append(listItem.uppercased())
        }
        if shopListUpperCase.contains(element.uppercased()) {
            
            let ac = UIAlertController(title: "Sorry!",
                                       message: "Your list already contains this product",
                                       preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        } else {
            shoppingList.insert(element, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}
