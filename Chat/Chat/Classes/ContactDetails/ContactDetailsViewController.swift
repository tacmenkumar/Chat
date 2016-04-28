//
//  ContactDetailsViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/27/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactDetailsViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI variable
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tblviewContacts: UITableView!
    @IBOutlet weak var tblviewEmails: UITableView!
    @IBOutlet weak var lblName: UILabel!
    // Class variable
    var index: Int = 0
    var contactNumbers = [CNLabeledValue]()
    var emailAddresses = [CNLabeledValue]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the array
        contactNumbers = AppDelegate.getAppDelegate().contacts[index].phoneNumbers
        emailAddresses = AppDelegate.getAppDelegate().contacts[index].emailAddresses
        let image = AppDelegate.getAppDelegate().contacts[index].imageData
        if image != nil{
                imgProfile.image = UIImage(data:image!)
        }
        
        lblName.text = "\(AppDelegate.getAppDelegate().contacts[index].givenName) \(AppDelegate.getAppDelegate().contacts[index].familyName)"
        
        // Set footer view as a blank view to remove the extra lines
        tblviewContacts.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tblviewEmails.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return (tableView == self.tblviewContacts) ? contactNumbers.count : emailAddresses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch tableView {
        case tblviewContacts:
            let cellIdentifier = "contactNumberCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactNumberTableViewCell
            let contactNumberDictionary = contactNumbers[indexPath.row]
            cell.lblContactNumber.text = (contactNumberDictionary.value as! CNPhoneNumber).stringValue
            return cell
        default:
            let cellIdentifier = "emailCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EmailTableViewCell
            let emailDictionary = emailAddresses[indexPath.row]
            cell.lblEmail.text =  emailDictionary.value as? String
            return cell
        }
    }
    
    
    @IBAction func btnUploadClicked(sender: AnyObject) {
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
