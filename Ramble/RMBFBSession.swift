//
//  RMBFBSession.swift
//  Ramble
//
//  Created by Mac Admin on 7/17/15.
//  Copyright (c) 2015 RMB. All rights reserved.
//
import Foundation
import UIKit
//import FBSDKLoginKit

class RMBFBSession: NSObject {
 
  /*
    //logging in with PFFacebookUtils
    class func loginWithFacebook() {
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
    
    class func isFBSessionValid () -> Bool {
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
    
    class func loginButton () -> UIButton {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let buttonFrame = CGRect(x: 0, y: 0, width: screenWidth, height: 80)
        
        let button = FBSDKLoginButton()
        button.loginBehavior = FBSDKLoginBehavior.Native
        button.frame = buttonFrame
        
        return button
    }
    
    */
}
