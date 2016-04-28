//
//  ChatNavigationController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/25/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class ChatNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sidebarVC: SideBarViewController = Utility.sharedInstance.getViewControllerFromStoryboard("SideBarViewController") as! SideBarViewController
        sidebarVC.view.backgroundColor = (UIColor.blueColor()).colorWithAlphaComponent(0.0)
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: sidebarVC, menuPosition: .Left, blurStyle: .Dark)
        
        sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = (self.view.frame.size.width) * 0.6
        sideMenu?.animationDuration = 0.8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
