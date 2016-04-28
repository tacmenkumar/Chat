//
//  HomeViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/21/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import ENSwiftSideMenu

class HomeViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI Controls
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnContacts: UIButton!
    @IBOutlet weak var tblviewContacts: UITableView!
    
    var btnAddContact: UIBarButtonItem!
    var btnHomeMenu : UIBarButtonItem!
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnHomeMenu = UIBarButtonItem(image: UIImage(named: "icn-menu"), style: .Plain, target: self , action: #selector(HomeViewController.toggleSideMenu))
        btnHomeMenu.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = btnHomeMenu
        
        // Set right nav button
        btnAddContact = UIBarButtonItem(image: UIImage(named: "icn-add-contact"), style: .Plain, target: self , action: #selector(HomeViewController.openContactApp))
        btnAddContact.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = btnAddContact
        
        self.tblviewContacts.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(HomeViewController.loadAllContacts), forControlEvents: UIControlEvents.ValueChanged)
        self.tblviewContacts.addSubview(refreshControl)
        
        syncContacts();
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
     Show Contacts List in iOS app
     */
    func openContactApp() {
        // Request for access to contacts
        AppDelegate.getAppDelegate().requestForAccess(self) { (accessGranted, accessError) in
            if(accessGranted){
                let contactPickerViewController = CNContactPickerViewController()
                contactPickerViewController.definesPresentationContext = true
                contactPickerViewController.modalTransitionStyle = .PartialCurl
                self.presentViewController(contactPickerViewController, animated: true, completion: nil)
            }
        }
    }
    
    func loadAllContacts() {
        // Reset the contacts array
        AppDelegate.getAppDelegate().contacts = [CNContact]()
        
        // Request for access to contacts
        AppDelegate.getAppDelegate().requestForAccess(self) { (accessGranted, accessError) in
            if(accessGranted){
                do {
                    try  AppDelegate.getAppDelegate().contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch: [CNContactImageDataKey, CNContactThumbnailImageDataKey, CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactEmailAddressesKey,CNContactPhoneNumbersKey])) {
                        (contact, cursor) -> Void in
                        AppDelegate.getAppDelegate().contacts.append(contact)
                    }
                    print("Number of contacts: \(AppDelegate.getAppDelegate().contacts.count)")
                    self.tblviewContacts.reloadData()
                    self.refreshControl.endRefreshing()
                }
                catch{
                    Utility.sharedInstance.showAlert(self, title: "Error", message: "Handle the error please")
                }
            }
        }
    }
    
    // MARK: TableView Delegate Methods
    
    /**
     Returns number of sections
     
     - parameter tableView: tblviewContacts
     
     - returns: section numbers
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     Returns number of rows in the section
     
     - parameter tableView: tblviewContacts
     - parameter section:   section index
     
     - returns: number of rows
     */
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return AppDelegate.getAppDelegate().contacts.count
    }
    
    /**
     Populate the row with proper information
     
     - parameter tableView: tblviewContacts
     - parameter indexPath: index information
     
     - returns: tableview cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "contactCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactsTableViewCell
        
        let contactDictionary = AppDelegate.getAppDelegate().contacts[indexPath.row]
        
        if let imgProfile = cell.imgProfile {
            if (contactDictionary.thumbnailImageData != nil){
                imgProfile.image = UIImage(data: contactDictionary.thumbnailImageData!)
            }
        }
        
        if let label = cell.lblContact {
            label.text = "\(contactDictionary.givenName) \(contactDictionary.familyName)"
        }
        
        for phoneNo in contactDictionary.phoneNumbers {
            if phoneNo.label == CNLabelPhoneNumberMobile {
                if let label = cell.lblMessage{
                    label.text = (phoneNo.value as! CNPhoneNumber).stringValue
                }
                break
            }
        }
        
        return cell
    }
    
    /**
     Called on click of tableview row
     
     - parameter tableView: tblviewContacts
     - parameter indexPath: indexpath information
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc:ContactDetailsViewController = Utility.sharedInstance.getViewControllerFromStoryboard("ContactDetailsViewController") as! ContactDetailsViewController
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /**
     Called on click of call button
     
     - parameter sender: btnCall
     */
    @IBAction func showCallLogs(sender: AnyObject) {
    }
    
    /**
     Called on click of chat button
     
     - parameter sender: btnChat
     */
    @IBAction func showChats(sender: AnyObject) {
    }
    
    /**
     Called on click of contact button
     
     - parameter sender: btnContact
     */
    @IBAction func showContacts(sender: AnyObject) {
        
    }
    
    /**
     Callback for register user
     
     - parameter result: Response
     */
    func syncSuccessCallback(result: AnyObject) -> Void {
        print(result)
        // Load all contacts
        loadAllContacts()
    }
    
    /**
     Error Callback
     
     - parameter result: anyobject
     */
    func syncErrorCallback(result: AnyObject) -> Void {
        print(result)
        Utility.sharedInstance.showAlert(self, title:"Login Error", message: (result.objectForKey("message") as? String)!)
    }
    
    func syncContacts() -> Void {
        NetworkManager.sharedInstance.callWSSyncContacts([
            "userContacts" : [String]()
            ], containerView: self.view, successCallback: syncSuccessCallback, errorCallback: syncErrorCallback)
    }
    
    // MARK: View Controller Methods
    /**
     Decide whether to open view controller using segue or not
     
     - parameter identifier: segue identifier
     - parameter sender:     object
     
     - returns: flag true to open view controller and false to not open the view controller
     */
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return false
    }
}
