//
//  MenuViewController.swift
//  Budget Catcher
//
//  Created by Md. Kamrul Hassan Sabuj on 25/11/18.
//  Copyright © 2018 SahiTech. All rights reserved.
//
import UIKit
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let defaults = UserDefaults.standard
   
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        topView.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: view.frame, colors: Colors.backgroundColor)
//        let anyAvatarImage:UIImage = UIImage(named: "Profile Aveter")!
//        profileImageView.maskCircle(anyImage: anyAvatarImage)
        versionLabel.text = "Version : \(Bundle.main.releaseVersionNumber!) Bilud : \(Bundle.main.buildVersionNumber!)"
        tblMenuOptions.tableFooterView = UIView()
        tblMenuOptions.rowHeight = 45
     
//        tblMenuOptions.separatorColor = UIColor(red:0.22, green:0.38, blue:0.40, alpha:1.0)
        // Do any additional setup after loading the view.
        
//        //Set Current User Details
//        if let savedUser = defaults.object(forKey: "currentUser") as? Data{
//            let decoder = JSONDecoder()
//            if let loadedUser = try? decoder.decode(UserDetails.self, from: savedUser){
//                DispatchQueue.main.async {
//                    self.userNameLable.text = loadedUser.firstName ?? ""
//                    self.userPhoneNumberLabel.text = loadedUser.contactNumber ?? ""
//
//
//                }
//
//
//            }
//
//
//        }
//        if let imageData = UserDefaults.standard.value(forKey: "profileImage") as? Data{
//            DispatchQueue.main.async {
//                self.profileImageView.maskCircle(anyImage: UIImage(data: imageData)!)
//            }
//
//
//        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Welcome", "icon":"map"])
        arrayMenuOptions.append(["title":"Self", "icon":"trip"])
//        arrayMenuOptions.append(["title":"Promotion", "icon":"rsz_1promotion (1)"])
//        arrayMenuOptions.append(["title":"Free Rides", "icon":"freeride"])
//        arrayMenuOptions.append(["title":"Help","icon":"help1"])
//        arrayMenuOptions.append(["title":"Profile Setting", "icon":"rsz_settings"])
//        arrayMenuOptions.append(["title":"Logout","icon":"rsz_logout"])
        tblMenuOptions.reloadData()    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParent()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
//        imgIcon.tintColor = UIColor.red
        imgIcon.image = imgIcon.image?.imageWithColor(color1: UIColor.red)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
