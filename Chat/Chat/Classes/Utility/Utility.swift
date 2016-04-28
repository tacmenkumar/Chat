//
//  Utility.swift
//  Chat
//
//  Created by Niraj Kumar on 4/21/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import Foundation
import UIKit


class Utility: NSObject {

    
    // sharedInstance
    static let sharedInstance = Utility()
    
    func showAlert (vc: UIViewController, title: String, message: String){
        let aaVC = AppAlertViewController(nibName: "AppAlertViewController", bundle: nil)
        
        aaVC.alertTitle = title
        aaVC.alertMessage = message
        aaVC.modalTransitionStyle = .CrossDissolve
        aaVC.definesPresentationContext = true
        aaVC.modalPresentationStyle = .OverCurrentContext
        
        // Present View "Modally"
        vc.presentViewController(aaVC, animated: true, completion: nil)
    }
    
    func getViewControllerFromStoryboard(viewController: String) -> UIViewController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        return mainStoryboard.instantiateViewControllerWithIdentifier(viewController)
    }
}
