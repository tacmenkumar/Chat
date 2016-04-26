//
//  AppAlertViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/21/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit

class AppAlertViewController: UIViewController {
    
    @IBOutlet weak var viewAlertBox: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblAlertTitle: UILabel!
    @IBOutlet weak var txtviewAlertMessage: UITextView!
    
    var alertTitle: String?
    var alertMessage: String?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame)
        
        if (alertTitle?.isEmpty) != nil{
            lblAlertTitle.text = alertTitle
        }else{
            lblAlertTitle.text = "Chat App"
        }
        
        
        if (alertMessage?.isEmpty) != nil{
            txtviewAlertMessage.text = alertMessage
        }else{
            txtviewAlertMessage.text = "Chat App"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
    
    @IBAction func hideAlertView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }   

}
