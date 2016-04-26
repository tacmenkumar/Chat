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
        let sidebarVC =  Utility.sharedInstance.getViewControllerFromStoryboard("SideBarViewController")
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
    
    // MARK: - ENSideMenu Delegate
    /**
     Called when the the menu is about to appear
     */
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    /**
     Called when menu is about to close
     */
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    /**
     Called when the menu is closed
     */
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    /**
     Called when the menu is opened
     */
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
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
