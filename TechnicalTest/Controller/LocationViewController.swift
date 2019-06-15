//
//  LocationViewController.swift
//  TechnicalTest
//
//  Created by Interview AITS on 15/6/19.
//  Copyright © 2019 Interview AITS. All rights reserved.
//

import UIKit
import DropDown
class LocationViewController: UIViewController {
    //MARK: - DropDown's
    let areaDropDown = DropDown()
    let zoneDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.zoneDropDown,
            self.areaDropDown
            
        ]
        
    }()
    
    //Outlets
    
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    let defaults = UserDefaults.standard
    private var zoneNameArray = [String]()
    private var zoneNameArrayLocal = [String]()
    private var zoneArray : [Zone] = [Zone]()
    
    private var areaNameArray = [String]()
    private var areaNameArrayLocal = [String]()
    private var areaArray : [Area] = [Area]()
    private var zoneSelected : Bool = false
    private var areaSelected : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getZone()
//        setupDropDowns()
        setUpZone()
        zoneNameArrayLocal = self.defaults.stringArray(forKey: "zoneNameArray") ?? [String]()
         areaNameArrayLocal = self.defaults.stringArray(forKey: "areaNameArray") ?? [String]()
        //MARK : - Under Section Tap Gesture
        let areaTap = UITapGestureRecognizer(target: self, action: #selector(areaTapFunction))
        areaLabel.isUserInteractionEnabled = true
        areaLabel.addGestureRecognizer(areaTap)
        
        //MARK : - Under Section Tap Gesture
        let zoneTap = UITapGestureRecognizer(target: self, action: #selector(zoneTapFunction))
        zoneLabel.isUserInteractionEnabled = true
        zoneLabel.addGestureRecognizer(zoneTap)
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if zoneSelected == true && areaSelected == true{
            performSegue(withIdentifier: "goToHomePage", sender: self)
        }else{
            customAlert(title: "Error", message: "Select Your Location", time: 3)
        }
    }
    
    
    //Mark Tap Function
    @objc
    func areaTapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        areaDropDown.show()
    }
    
    //Mark Tap Function
    @objc
    func zoneTapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        zoneDropDown.show()
    }
    //MARK : - Get Month data
    func getZone(){
        let jsonURLString = "https://meenaclick.com/api/get-all-area"
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check error
            // check response status 200 ok
            guard let data = data else {return}
            
            do {
                //Swift 4 or later
                let area = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                print(area)
                if let dataArray = area!.value(forKey: "data") as? NSArray {
                    print(dataArray)
                    var newArea = Zone()
                    
                    for data in dataArray{
                        
                        
                        if let id = (data as AnyObject).value(forKey: "id") {
                            print("id : \(id)")
                            
                            newArea.id = id as? Int
                            
                        }
                        if let outletID = (data as AnyObject).value(forKey: "outlet_id") {
                             print("outletID : \(outletID)")
                            newArea.outletID = outletID as? Int
                        }
                        if let areaName = (data as AnyObject).value(forKey: "area_name") {
                            print("areaName : \(areaName)")
                            newArea.areaName = areaName as? String
                        }
                        if let areaStatus = (data as AnyObject).value(forKey: "area_status") {
                            print("areaStatus : \(areaStatus)")
                            newArea.areaStatus = areaStatus as? String
                        }
                        
                        print("newArea : \(newArea)")
                        self.zoneArray.append(newArea)
                        
                    }
                    
                    print("areaArray : \(self.zoneArray)")
                    for element in self.zoneArray{
                        self.zoneNameArray.append(element.areaName!)
                        DispatchQueue.main.async {
                            self.defaults.set(self.zoneNameArray, forKey: "zoneNameArray")
                            //                        print(self.defaults.set(self.areaNameArray, forKey: "areaNameArray"))
                            self.zoneNameArrayLocal = self.defaults.stringArray(forKey: "zoneNameArray") ?? [String]()
                            self.setUpZone()
                        }
                       
                    }
                    
                }
                
                
            }catch{
                print(error.localizedDescription)
                print("Error in Decoding : \(error)")
                
                
            }
            
            }.resume()
    }
    
    
    //MARK : - Get Month data
    func getArea(id : Int){
        
        let jsonURLString = "https://meenaclick.com/api/get-subarea/\(id)"
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check error
            // check response status 200 ok
            guard let data = data else {return}
            
            do {
                //Swift 4 or later
                let area = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                print(area)
                if let dataArray = area!.value(forKey: "data") as? NSArray {
                    print(dataArray)
                    var newArea = Area()
                    
                    for data in dataArray{
                        
                        
                        if let id = (data as AnyObject).value(forKey: "id") {
                            print("id : \(id)")
                            
                            newArea.id = id as? Int
                            
                        }
                        if let areaName = (data as AnyObject).value(forKey: "area_name") {
                            print("areaName : \(areaName)")
                            newArea.areaName = areaName as? String
                        }
                       
                        
                        print("newArea : \(newArea)")
                        self.areaArray.append(newArea)
                        
                    }
                    
                    print("areaArray : \(self.areaArray)")
                    for element in self.areaArray{
                        self.areaNameArray.append(element.areaName!)
                        
                        DispatchQueue.main.async {
                            self.defaults.set(self.areaNameArray, forKey: "areaNameArray")
                            //                        print(self.defaults.set(self.areaNameArray, forKey: "areaNameArray"))
                            self.areaNameArrayLocal = self.defaults.stringArray(forKey: "areaNameArray") ?? [String]()
                            self.setUpArea()
                        }
                      
                    }
                    
                }
                
                
            }catch{
                print(error.localizedDescription)
                print("Error in Decoding : \(error)")
                
                
            }
            
            }.resume()
    }
    
    
    //MARK: - Setup DropDowns
    
//    func setupDropDowns() {
//        print("Call dropdown")
//        setUpZone()
//        setUpArea()
//
//
//    }
    func setUpZone() {
        zoneDropDown.anchorView = zoneLabel
        
        zoneDropDown.dataSource = self.zoneNameArrayLocal
        zoneDropDown.direction = .any
        zoneDropDown.topOffset = CGPoint(x: 0, y:-(zoneDropDown.anchorView?.plainView.bounds.height)!)
        zoneDropDown.separatorColor = .gray
        zoneDropDown.selectionAction = { [weak self] (index, item) in
            self?.zoneLabel.text = item
            self?.zoneSelected = true
            let matchZone = self!.zoneArray
            

            let result = matchZone.filter{$0.areaName == item}
            
            print("Result : \(result)")
            for matchingZone in result{
                
                let selectedZoneId = Int(matchingZone.id!)
                
                self?.getArea(id: selectedZoneId)
            }
            
        }
        zoneDropDown.cancelAction = { [unowned self] in
            print("Drop down dismissed")
        }
        
        zoneDropDown.willShowAction = { [unowned self] in
            print("Drop down will show")
        }
    }
    
    
    func setUpArea() {
        areaDropDown.anchorView = areaLabel
        
        areaDropDown.dataSource = self.areaNameArrayLocal
        areaDropDown.direction = .any
        areaDropDown.topOffset = CGPoint(x: 0, y:-(areaDropDown.anchorView?.plainView.bounds.height)!)
        areaDropDown.separatorColor = .gray
        areaDropDown.selectionAction = { [weak self] (index, item) in
            self?.areaLabel.text = item
            self?.areaSelected = true
        }
        areaDropDown.cancelAction = { [unowned self] in
            print("Drop down dismissed")
        }
        
        areaDropDown.willShowAction = { [unowned self] in
            print("Drop down will show")
        }
    }
}
