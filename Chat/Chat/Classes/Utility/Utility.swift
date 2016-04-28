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
    
    /**
     *  + (void) showCustomAlertViewWithTitle : (NSString*)title msg:(NSString*)Message :(UIViewController*)viewController{
     CustomPopOverViewController * cpo = [[CustomPopOverViewController alloc]initWithNibName:@"CustomPopOverViewController" bundle:[NSBundle mainBundle]];
     cpo.desciptionText = Message;
     cpo.titleText = title;
     cpo.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     cpo.definesPresentationContext = YES;
     cpo.modalPresentationStyle = UIModalPresentationOverCurrentContext;
     [viewController presentViewController:cpo animated:YES completion:^{
     NSLog(@"Custom alert shown");
     }];
     }
     */
    
}
