//
//  HomeViewController.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    //variables
    var getLocation : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        title = defaults.getValue(key: "location")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.09, green:0.84, blue:0.67, alpha:1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    

   

}
