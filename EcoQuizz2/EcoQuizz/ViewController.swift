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
    @IBAction func showDetails(indexPath: IndexPath){
        performSegue(withIdentifier: "AnimalDetailSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch (identifier, segue.destination, sender) {
        case("AnimalDetailSegue", let labelController as AnimalDetailViewController, let indexPath as IndexPath):
            labelController.Name = animals[indexPath.row].name
            labelController.Size = String(animals[indexPath.row].size)
            labelController.Weight = String(animals[indexPath.row].weight)
            labelController.Expectency = String(animals[indexPath.row].lifespan)
            labelController.Image = animals[indexPath.row].image

        default:
            break
        }
    }
}

extension AnimalViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        if let cell = cell as? AnimalTableViewCell {
            cell.animalNameLabel.text = animals[indexPath.row].name
            cell.animalImageView.image = UIImage(named: animals[indexPath.row].imageResourceName)
        }
        
        return cell
    }
}

extension AnimalViewController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let alertController = UIAlertController(title: "\(animals[indexPath.row]) selected", message: nil, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         present(alertController, animated: true, completion: nil)
         // Handle the selection of the animal*/
        showDetails(indexPath: indexPath)
        
    }
        
    
}


class AnimalTableViewCell: UITableViewCell {
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            animalImageView.layer.cornerRadius = 10
        }
}


class AnimalDetailViewController : UIViewController {
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameView : UILabel!
    @IBOutlet weak var animalSizeView : UILabel!
    @IBOutlet weak var animalWeightView : UILabel!
    @IBOutlet weak var animalExpectencyView : UILabel!
    var Name: String?
    var Size: String?
    var Weight: String?
    var Expectency: String?
    var Image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        animalNameView.text = Name
        animalSizeView.text = Size
        animalWeightView.text = Weight
        animalNameView.text = Expectency
        animalImageView.image = Image
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
