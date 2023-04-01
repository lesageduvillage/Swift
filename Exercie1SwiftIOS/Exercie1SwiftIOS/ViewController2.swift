//
//  ViewController2.swift
//  Exercie1SwiftIOS
//
//  Created by Guest User on 01/04/2023.
//
import UIKit

class ViewController2: UIViewController {

    var text: String?
    @IBOutlet weak var MyLabel : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        MyLabel?.text = text
    }
    @IBAction func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }


}

