//
//  ViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/19/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController?.navigationBarHidden = true
    }

    /*override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Callback for login user
     
     - parameter result: Response
     */
    func loginSuccessCallback(result: AnyObject) -> Void {
        print(result)
        //Utility.sharedInstance.showAlert(self, title:"Login Success", message: "Logged in successfully.")
        isLoggedIn = true
        AppDelegate.getAppDelegate().defaults.setObject(result, forKey: "userinfo")
        performSegueWithIdentifier("loginsegue", sender: self)
    }
    
    /**
     Error Callback
     
     - parameter result: anyobject
     */
    func loginErrorCallback(result: AnyObject) -> Void {
        print(result)
        Utility.sharedInstance.showAlert(self, title:"Login Error", message: (result.objectForKey("message") as? String)!)
    }
    
    /**
     Called on click of login button
     
     - parameter sender: btnLogin
     */
    @IBAction func login(sender: AnyObject) {
        let username = txtUsername.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password = txtPassword.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(username == ""){
            Utility.sharedInstance.showAlert(self, title: "Login Error", message: "Please enter the username")
        }else if(password == ""){
            Utility.sharedInstance.showAlert(self, title: "Login Error", message: "Please enter the password")
        }else{
            NetworkManager.sharedInstance.callWSLogin([
                "email" : username!,
                "password" :password!,
                ], containerView: self.view, successCallback: loginSuccessCallback, errorCallback: loginErrorCallback)
        }
    }
    
    
    /**
     Get the segue
     
     - parameter toViewController:   destinationViewController
     - parameter fromViewController: rootViewController
     - parameter identifier:         segue identifier
     
     - returns: <#return value description#>
     */
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        print(identifier)
        if let id = identifier {
            if id == "registersegue" {
                let unwindSegue = AppStoryBoardSegue(identifier: id, source: fromViewController, destination: toViewController)
                return unwindSegue
            }
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
    }
    /**
     perform segue operation
     
     - parameter identifier: segue name
     - parameter sender:     calling button
     
     - returns: flag to open or dismiss the action
     */
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if !isLoggedIn && identifier == "loginsegue"{
            return false
        }
        return true
    }

}

