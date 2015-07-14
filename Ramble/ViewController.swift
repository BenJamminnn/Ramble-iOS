//
//  ViewController.swift
//  Ramble
//
//  Created by Mac Admin on 7/8/15.
//  Copyright (c) 2015 RMB. All rights reserved.
//

import Foundation
import UIKit
import Parse
import FBSDKLoginKit
import MapKit

class ViewController: UIViewController {
        override func viewDidLoad() {
            
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.addSubview(self.mapView())
        self.authenticate()
        super.viewDidAppear(animated)

    }
    
    func mapView() -> MKMapView {
        var mapView = MKMapView(frame: self.view.frame)
        mapView.mapType = MKMapType.Satellite
        return mapView
    }
    
    func isFBSessionValid () -> Bool {
        var isSessionValid = false
        let request = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        request.startWithCompletionHandler { (connection, result, error) -> Void in
            if error != nil {
                //Success
                isSessionValid = true
            } else {
                //failure
                println(error.userInfo)
                PFFacebookUtils.unlinkUserInBackground(PFUser.currentUser()!)
            }
        }
        return isSessionValid
    }
    
    func authenticate() {
        if PFUser.currentUser() == nil {  //check if user is linked to FB
            self.addButton()
        }
    }
    
    func addButton() {
        let buttonFrame = CGRect(x: 0, y: self.view.frame.height - 80, width: self.view.frame.width, height: 80)

        let button = FBSDKLoginButton()
        button.loginBehavior = FBSDKLoginBehavior.Native
        button.frame = buttonFrame
//        button.addTarget(self, action: Selector(loginWithFacebook()), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    
    //logging in with PFFacebookUtils
    func loginWithFacebook() {
        PFFacebookUtils.initializeFacebook()
        let permissionsArray: Array<String> = ["user_about_me", "user_location"]
        PFFacebookUtils.logInWithPermissions(permissionsArray, block: { (user, error) -> Void in
            if user!.isKindOfClass(PFUser) {
                if user!.isNew {
                    println("user signed up and successfully logged in")
                } else {
                    println("user logged in")
                }
            } else if user == nil {
                println("user cancelled request")
            }
        })
        
    }
    
    
}

