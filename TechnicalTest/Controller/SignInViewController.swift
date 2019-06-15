//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var pinCodeTf: UITextField!
    
    //variables
    var selectedNumber : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Underline resend button title
        resendButton.underline()
    }

    @IBAction func verifyButtonPressed(_ sender: UIButton) {
        if phoneNumberTF.text!.isEmpty {
            return
        }else{
            guard let number = phoneNumberTF.text else {return}
            print(number)
            selectedNumber = number
            loginCheck(number: number)
        }
        
        }
    
    //MARK : Login Check Function
    func loginCheck(number : String) {
        let jsonURLString = "https://meenaclick.com/api/v2/login-check"
        
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else {
            print("Error: cannot create URL")
            return
        }
        var loginCheckRequest = URLRequest(url: url)
        loginCheckRequest.httpMethod = "POST"
        loginCheckRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var param = ["mobile_no": number]
        
        do {
            let jsonBody = try JSONEncoder().encode(param)
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
                    let loginData = (checkLogin as AnyObject).value(forKey: "login_data") as? NSObject
                    //                self.statusMessege = status
                    print("loginData : \(loginData)")
                   let accountExists = loginData!.value(forKey: "account_exists") as? Bool
                    print(accountExists)
                    if accountExists!{
                        
                    }else{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "goToSignUpPage", sender: self)
                        }
                    }
                    
                  
                }
                catch{
                    print(error.localizedDescription)
                    print("Error: cannot Decode JSON from user")
//                    SwiftSpinner.hide()
                }
        }
        task.resume()
    }

    
    //MARK : Prepare Segue for Registration Page

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToSignUpPage") {
            let destinationVC = segue.destination as! RegistrationViewController
            destinationVC.getNumber = selectedNumber
        }
        
    }
}

