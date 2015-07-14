//
//  RMBLoginViewController.swift
//  Ramble
//
//  Created by Mac Admin on 7/9/15.
//  Copyright (c) 2015 RMB. All rights reserved.
//

import FBSDKLoginKit

class RMBLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        self.addButton()

        super.viewDidLoad()
        
    }
    
    func addButton() {
        let button = FBSDKLoginButton()
        button.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: 200, height: 100)
        self.view.addSubview(button)
    }
    
}
