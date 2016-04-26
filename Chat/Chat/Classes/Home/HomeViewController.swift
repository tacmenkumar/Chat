//
//  HomeViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/21/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import Contacts
import ENSwiftSideMenu

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ENSideMenuDelegate {
    
    
    // Data Variables
    var users: NSArray = []
    
    // UI Controls
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnContacts: UIButton!
    
    var btnAddContact: UIBarButtonItem!
    var btnHomeMenu : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnHomeMenu = UIBarButtonItem(image: UIImage(named: "icn-menu"), landscapeImagePhone: UIImage(named: "icn-arrow-white-left"),
                                      style: .Plain, target: self, action: #selector(HomeViewController.toggleSideMenu))
        btnHomeMenu.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = btnHomeMenu
        
        btnAddContact = UIBarButtonItem(image: UIImage(named: "icn-add-contact"), style: .Plain, target: self , action: #selector(HomeViewController.checkContactsAuthorization))
        btnAddContact.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = btnAddContact
        
        self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    /**
     Called when there is a memory issue
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func toggleSideMenu() {
        toggleSideMenuView()
    }
    
    /**
     Check for access to contacts
     
     - returns: 1 if denied 2 if authorized and 3 if not determined
     */
    func checkContactsAuthorization() -> Int{
        // Asking for authorization
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(.Contacts)
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            print("Denied")
            return 1
        case .Authorized:
            //2
            print("Authorized")
            return 2
        case .NotDetermined:
            //3
            print("Not Determined")
            return 3
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "contactCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactsTableViewCell
        
        if let imgProfile = cell.imgProfile {
            imgProfile.image = UIImage(named: "sample")
        }
        
        if let label = cell.lblContact {
            label.text = "Contact Person: \(indexPath.row)"
        }
        if let label = cell.lblMessage{
            label.text = "Message: \(indexPath.row)"
        }
        return cell
    }
    
    @IBAction func showCallLogs(sender: AnyObject) {
    }
    
    @IBAction func showChats(sender: AnyObject) {
    }
    
    @IBAction func showContacts(sender: AnyObject) {
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
