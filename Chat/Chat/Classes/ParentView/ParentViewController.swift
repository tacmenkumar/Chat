//
//  ParentViewController.swift
//  Chat
//
//  Created by Niraj Kumar on 4/20/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class ParentViewController: UIViewController, ENSideMenuDelegate {

    /**
     Called on successfully view load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnBack = UIBarButtonItem(image: UIImage(named: "icn-left-arrow"), landscapeImagePhone: UIImage(named: "icn-arrow-white-left"),
                                      style: .Plain, target: self, action: #selector(ParentViewController.goBack))
        btnBack.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItem(btnBack, animated: true);
        
        self.sideMenuController()?.sideMenu?.delegate = self
    }

    /**
     Called on memory issue
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Close the current view controller
     */
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
        self.view.userInteractionEnabled = false
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
        self.view.userInteractionEnabled = true
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }

}
