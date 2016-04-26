//
//  RegisterViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/20/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // Textfield for Display Name
    @IBOutlet weak var txtDisplayName: UITextField!
    
    // Textfield for Email
    @IBOutlet weak var txtEmail: UITextField!
    
    // Textfield for Password
    @IBOutlet weak var txtPassword: UITextField!
    
    // Textfield for Date of Birth
    @IBOutlet weak var txtDateOfBirth: UITextField!
    
    // Textfield for Mobile Number
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    /**
     Called on view load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     Called on any memory related issue
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     Go Back
     
     - parameter sender: cancel Button
     */
    @IBAction func goBack(sender: AnyObject) {
        dismiss()
    }
    
    /**
     Callback for register user
     
     - parameter result: Response
     */
    func registerSuccessCallback(result: AnyObject) -> Void {
        print(result)
        dismiss()
    }
    
    /**
     Error Callback
     
     - parameter result: anyobject
     */
    func registerErrorCallback(result: AnyObject) -> Void {
        print(result)
        Utility.sharedInstance.showAlert(self, title:"Login Error", message: (result.objectForKey("message") as? String)!)
    }
    
    /**
     Called on click of register button
     
     - parameter sender: register button
     */
    @IBAction func register(sender: AnyObject) {
        let displayName:String, email:String, password:String, dateOfBirth:String, mobileNumber:String;
        
        displayName = txtDisplayName.text!;
        email = txtEmail.text!;
        password = txtPassword.text!;
        dateOfBirth = txtDateOfBirth.text!;
        mobileNumber = txtMobileNumber.text!;
        
        NetworkManager.sharedInstance.callWSRegister([
            "display_name" : displayName,
            "email" : email,
            "password" :password,
            "mobile_no" : mobileNumber,
            "date_of_birth" : dateOfBirth
            ], containerView: self.view, successCallback: registerSuccessCallback, errorCallback: registerErrorCallback)
    }
}
