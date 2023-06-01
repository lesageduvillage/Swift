//
//  ViewController.swift
//  EcoQuizz
//
//  Created by Utilisateur invité on 01/06/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class AnimalViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let animals = Animal.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AnimalViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalTableViewCell", for: indexPath)
        
        if let cell = cell as? AnimalTableViewCell {
            cell.animalNameLabel.text = animals[indexPath.row].name
            cell.animalImageView.image = UIImage(named: animals[indexPath.row].imageResourceName)
        }
        
        return cell
    }
}

extension AnimalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "\(animals[indexPath.row]) selected", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        // Handle the selection of the animal
    }
}


class AnimalTableViewCell: UITableViewCell {
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
}

