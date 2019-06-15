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
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if numberTf.text!.isEmpty && pinTF.text!.isEmpty && nameTF.text!.isEmpty && emailTF.text!.isEmpty{
            return
        }else{
            guard let number = numberTf.text, let pin = pinTF.text, let name = nameTF.text, let email = emailTF.text else {return}
            print(number)
            
            let newRegistration = Registration(email: email, mobile: number, fullName: name, pinCode: pin)
            //Calling registration
           registration(newUser: newRegistration)
           
        }
    }
    
    
    //MARK : Registration
    func registration(newUser : Registration) {
        print(newUser)
        let jsonURLString = "https://www.meenaclick.com/api/v2/registration-try"
        
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else {
            print("Error: cannot create URL")
            return
        }
        var loginCheckRequest = URLRequest(url: url)
        loginCheckRequest.httpMethod = "POST"
        loginCheckRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        var param = ["mobile_no": number]
        
        do {
            let jsonBody = try JSONEncoder().encode(newUser)
            loginCheckRequest.httpBody = jsonBody
        } catch {
            print(error.localizedDescription)
            print("Error: cannot create JSON from user")
            return
        }
        
        let session = URLSession.shared
        let task = session
            .dataTask(with: loginCheckRequest) { (data, response, error) in
                guard let data = data else {return}
                print(data)
                do{
                    
                    let checkLogin = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                    print(checkLogin)
//                    let loginData = (checkLogin as AnyObject).value(forKey: "login_data") as? NSObject
//                    //                self.statusMessege = status
//                    print("loginData : \(loginData)")
//                    let accountExists = loginData!.value(forKey: "account_exists") as? Bool
//                    print(accountExists)
//                    if accountExists!{
//
//                    }else{
//                        DispatchQueue.main.async {
//                            self.performSegue(withIdentifier: "goToSignUpPage", sender: self)
//                        }
//                    }
                    
                    
                }
                catch{
                    print(error.localizedDescription)
                    print("Error: cannot Decode JSON from user")
                    //                    SwiftSpinner.hide()
                }
        }
        task.resume()
    }
}
