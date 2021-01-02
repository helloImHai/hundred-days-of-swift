//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Hai Nguyen on 2/1/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInPetitionData()
        addNavbarButtons()
        
    }
    
    func addNavbarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(tapCreditButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(tapFilterButton))
    }
    
    @objc
    func tapFilterButton() {
        let ac = UIAlertController(title: "Filter", message: "Enter keywords to filter", preferredStyle: .alert)
        ac.addTextField()
        let setFilter = UIAlertAction(title: "Set", style: .default) {
            [weak ac, weak self] action in
            guard let filterString = ac?.textFields?[0].text else { return }
            self?.applyFilter(filterString)
        }
        ac.addAction(setFilter)
        let removeFilter = UIAlertAction(title: "Remove", style: .default) {
            [weak self] action in
            self?.applyFilter(isReset: true)
        }
        ac.addAction(removeFilter)
        present(ac, animated: true)
    }
    
    func applyFilter(_ key: String = "", isReset: Bool = false) {
        if isReset {
            filteredPetitions = petitions
        } else {
            filteredPetitions.removeAll(keepingCapacity: true)
            for petition in petitions {
                if petition.title.contains(key) || petition.body.contains(key) {
                    filteredPetitions.append(petition)
                }
            }
        }
    
        tableView.reloadData()
    }
    
    @objc
    func tapCreditButton() {
        let ac = UIAlertController(title: "Credits", message: "This data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func loadInPetitionData() {
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        } else {
            print("Parsing failed")
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

