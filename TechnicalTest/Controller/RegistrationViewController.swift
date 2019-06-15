//
//  RegistrationViewController.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var numberTf: UITextField!
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    //variables
    var getNumber : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let number = getNumber else {
            return
        }
        numberTf.text = number
        
    }
    

}
