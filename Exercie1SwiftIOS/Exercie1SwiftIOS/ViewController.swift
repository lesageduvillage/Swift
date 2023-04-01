//
//  ViewController.swift
//  Exercie1SwiftIOS
//
//  Created by Guest User on 01/04/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func showButtonActionHello() {
        performSegue(withIdentifier: "ShowSecond", sender: "Hello")
    }
    @IBAction func showButtonActionBonjour() {
        performSegue(withIdentifier: "ShowSecond", sender: "Bonjour")
    }
    
    @IBAction func showAlert(){
        let alert = UIAlertController(title:"Ceci est le titre", message:"Ceci est le message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title:"Second", style: .default, handler: {action in self.performSegue(withIdentifier: "ShowSecond", sender: "Alert")}))
        present(alert, animated: true, completion: {
            return
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch (identifier, segue.destination) {
        case("ShowSecond", let viewController as ViewController2):
            if let value = sender as? String {
                viewController.text = value;
            }
            
        default:
            break
        }
    }

    


}

