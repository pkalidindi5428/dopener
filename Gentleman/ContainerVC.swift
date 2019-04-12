
//
//  ViewController.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 3/6/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//
import UIKit
import Alamofire

class ContainerVC: UIViewController {
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var sideMenuOpen = false
    
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
}
