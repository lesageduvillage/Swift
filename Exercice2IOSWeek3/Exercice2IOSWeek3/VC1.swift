//
//  ViewController.swift
//  Exercice2IOSWeek3
//
//  Created by Guest User on 01/04/2023.
//


import UIKit

class VC1: UIViewController {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func FirstToSecond(_ sender: Any) {
        let secondVC = sb.instantiateViewController(identifier: "VC2")
        self.navigationController?.pushViewController(secondVC, animated: true)
    }


}

