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
            labelController.Size = "Taille: " + String(animals[indexPath.row].size) + " cm"
            labelController.Weight = "Poids: " + String(animals[indexPath.row].weight) + " kg"
            labelController.Expectency = "Espérance de vie: " + String(animals[indexPath.row].lifespan) + " ans"
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
        animalExpectencyView.text = Expectency
        animalImageView.image = Image
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// API
import Foundation

// Définir la structure de données pour les questions
struct Question: Codable {
    let id: Int
    let title: String
    let date: String
    let image: String
    let sentence: String
    let correct: Bool
    let explain: String?
}


// Fonction pour effectuer la requête et récupérer les questions
func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
    guard let url = URL(string: "https://ecoq.monprojetiosdemti.tech") else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching questions:", error)
            completion(nil)
            return
        }
        
        guard let data = data else {
            completion(nil)
            return
        }
        
        do {
            let questions = try JSONDecoder().decode([Question].self, from: data)
            completion(questions)
        } catch {
            print("Error decoding questions:", error)
            completion(nil)
        }
    }.resume()
}
//FIN API

class QuestionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var questions: [Question] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        indicator.startAnimating()
        fetchQuestions {[weak self] questions in
            if let questions = questions {
                self?.questions = questions
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } else {
                print("Echech de la récupération des questions")
            }
        }
        indicator.stopAnimating()
    }
    @IBAction func showQuestion(indexPath: IndexPath){
        performSegue(withIdentifier: "showQuestion", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch (identifier, segue.destination, sender) {
        case("showQuestion", let labelController as QuestionDetailViewController, let indexPath as IndexPath):
            labelController.Image = UIImage(named: questions[indexPath.row].image)
            labelController.Date = questions[indexPath.row].date
            labelController.Question = questions[indexPath.row].sentence
            labelController.Answer = questions[indexPath.row].correct
            labelController.Explain = questions[indexPath.row].explain == nil ? "" : questions[indexPath.row].explain
            labelController.title = questions[indexPath.row].title
            let backItem = UIBarButtonItem()
                backItem.title = "Quizz"
            navigationItem.backBarButtonItem = backItem

        default:
            break
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCell", for: indexPath)
        if let cell = cell as? QuestionCell {
            let question = questions[indexPath.item]
            cell.titleLabel.text = question.title
            cell.imageLabel.image = UIImage(named: question.image)
        }
            
            
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showQuestion(indexPath: indexPath)
    }
    
}


class QuestionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    override func awakeFromNib() {
            super.awakeFromNib()
            imageLabel.layer.cornerRadius = 10
        }
}

class QuestionDetailViewController : UIViewController {
    @IBOutlet weak var QuestionImageView: UIImageView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    var Answer: Bool?
    var Image: UIImage?
    var Date : String?
    var Question: String?
    var Explain: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionImageView.image = Image
        DateLabel.text = Date
        QuestionLabel.text = Question
    }
    let okAction = UIAlertAction (title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
    
    func success() {
        var TrueAnswer = UIAlertController(title: "Bonne réponse",message: "", preferredStyle: UIAlertController.Style.alert)
        TrueAnswer.addAction(okAction)
        self.present(TrueAnswer, animated: true, completion: nil)
    }
    func failure() {
        var FalseAnswer = UIAlertController(title: "Mauvaise réponse", message: Explain, preferredStyle: UIAlertController.Style.alert)
        FalseAnswer.addAction(okAction)
        self.present(FalseAnswer, animated: true, completion: nil)
    }
    
    @IBAction func TrueButton(){
        if (Answer == true) {
            success()
        }
        else {
            failure()
        }
    }
    @IBAction func FalseButton(){
        if (Answer != true) {
            success()
        }
        else {
            failure()
        }
    }
}
