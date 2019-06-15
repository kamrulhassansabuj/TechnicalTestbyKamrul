//
//  ViewController.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import UIKit
import QuartzCore
class SignInViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var pinCodeTf: UITextField!
    @IBOutlet weak var pinCodeView: UIView!
    @IBOutlet weak var resendStackView: UIStackView!
    
    //variables
    private var selectedNumber : String?
    private var isExists : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.09, green:0.84, blue:0.67, alpha:1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        resendStackView.isHidden = true
        pinCodeView.isHidden = true
        resendButton.underline()
    }

    @IBAction func verifyButtonPressed(_ sender: UIButton) {
        if phoneNumberTF.text!.isEmpty{
            return
        }else{
            guard let number = phoneNumberTF.text else {return}
            guard let code = pinCodeTf.text else {return}
            print(number)
            print(code)
            selectedNumber = number
            if isExists{
                if pinCodeTf.text!.isEmpty{
                    return
                }else{
                    login(number: number, pin: code)
                }
                
            }else{
                loginCheck(number: number)
            }
            
        }
        
        //if user exists
        
        
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
                    guard let loginData = (checkLogin as AnyObject).value(forKey: "login_data") as? NSObject else{
                        return
                    }
                    //                self.statusMessege = status
                    print("loginData : \(loginData)")
                    guard let accountExists = loginData.value(forKey: "account_exists") as? Bool else{return}
                    print(accountExists)
                    if accountExists{
                        DispatchQueue.main.async {
                            self.isExists = true
                            self.resendStackView.isHidden = false
                            self.pinCodeView.isHidden = false
                        }
//
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

    func login(number : String, pin :String) {
        let jsonURLString = "https://meenaclick.com/api/v2/process-login"
        
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else {
            print("Error: cannot create URL")
            return
        }
        var login = URLRequest(url: url)
        login.httpMethod = "POST"
        login.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var param = ["check_mobile_no": number, "check_pin_code" : pin]
        
        do {
            let jsonBody = try JSONEncoder().encode(param)
            login.httpBody = jsonBody
        } catch {
            print(error.localizedDescription)
            print("Error: cannot create JSON from user")
            return
        }
        
        let session = URLSession.shared
        let task = session
            .dataTask(with: login) { (data, response, error) in
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
    
    //MARK : Prepare Segue for Registration Page

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goToSignUpPage") {
            let destinationVC = segue.destination as! RegistrationViewController
            destinationVC.getNumber = selectedNumber
        }
        
    }
}

