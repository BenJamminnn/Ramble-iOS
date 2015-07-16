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

class ViewController: UIViewController {
    override func viewDidLoad() {
        addBackgroundView()
        addBlurEffect()
        addTopHeaderView()
        
        super.viewDidLoad()
    }
    
    func addBlurEffect() {
        self.view.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.view.addSubview(blurEffectView) //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view instead
        
        //add auto layout constraints so that the blur fills the screen upon rotating device
        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    }
    
    func addBackgroundView() {
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image =  UIImage(named: "RambleBackground")
        self.view.addSubview(imageView)
    }
    
    func addTopHeaderView() {
        let topViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
        var topView = UIView(frame: topViewFrame)
        topView.backgroundColor = UIColor(red: 69/255, green: 205/255, blue: 248/255, alpha: 1.0)
        
        let labelFont = UIFont(name: "VentographyPersonalUseOnly", size: 56)
        
        let labelText: String = "Ramble"
        let labelTextModified = labelText as NSString
        let size: CGSize = labelTextModified.sizeWithAttributes([NSFontAttributeName: labelFont!])

        let labelFrame = CGRect(x: self.view.center.x - size.width/2, y: topViewFrame.height/1.5 - size.height/2, width: 150, height: 50)
        var label = UILabel(frame: labelFrame)
        label.text = labelText
        label.textColor = UIColor.whiteColor()
        label.font = labelFont
        topView.addSubview(label)
        
        self.view.addSubview(topView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

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


