//
//  ViewController.swift
//  ShoppingList
//
//  Created by Hai Nguyen on 2/1/21.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shopping List"
        setUpNavigationBar()
        resetShoppingList()
        
    }
    
    @objc
    func resetShoppingList() {
        shoppingItems.removeAll(keepingCapacity: true)
        
        tableView.reloadData()
    }
    
    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptShoppingItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetShoppingList))
    }
    
    @objc
    func promptShoppingItem() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAddItem = UIAlertAction(title: "Confirm", style: .default) {
            [weak self, weak ac] action in
            guard let shoppingItem = ac?.textFields?[0].text else { return }
            self?.addShoppingItem(shoppingItem)
        }
        ac.addAction(submitAddItem)
        present(ac, animated: true)
    }
    
    func addShoppingItem(_ shoppingItem: String) {
        let item = shoppingItem.lowercased().capitalized
        shoppingItems.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    /*
     Overriding table methods
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }

}

