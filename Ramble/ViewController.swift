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
        blurEffectView.alpha = 0.0
        self.view.addSubview(blurEffectView) //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view instead
        UIView.animateWithDuration(1, animations: { () -> Void in
            blurEffectView.alpha = 1.0
        }) { (finished) -> Void in
            self.presentMenuItems()
        }
        //no need for autolayout yet
        //add auto layout constraints so that the blur fills the screen upon rotating device
//        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    }
    
    
    func addBackgroundView() {
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image =  UIImage(named: "RambleBackground")
        self.view.addSubview(imageView)
    }
    
    func addTopHeaderView() {
        let height = self.view.frame.height/10
        let topViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
        var topView = UIView(frame: topViewFrame)
        topView.backgroundColor = UIColor(red: 69/255, green: 205/255, blue: 248/255, alpha: 1.0)
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        let fontSize: CGFloat = screenHeight < 667 ? 42 : 56
        
        let labelFont = UIFont(name: "VentographyPersonalUseOnly", size: fontSize)
        
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
    
    func presentMenuItems() {
        let buttonSize = CGSize(width: 200, height: 100)
        let buttonXCoordinate = view.frame.width/8
        let buttonYCoordinate = view.frame.height + 200
        
        let buttonFrame = CGRect(x:  buttonXCoordinate, y:buttonYCoordinate , width: buttonSize.width, height: buttonSize.height)
        let chooseDriveButton = UIButton(frame: buttonFrame)
        chooseDriveButton.setTitle("Choose Drive", forState: UIControlState.Normal)
        chooseDriveButton.alpha = 0
        
        let previousDriveFrame = CGRect(x:buttonXCoordinate , y: buttonYCoordinate, width: buttonSize.width, height: buttonSize.height)
        let previousDriveButton = UIButton(frame: previousDriveFrame)
        previousDriveButton.setTitle("Previous Drive", forState: UIControlState.Normal)
        previousDriveButton.alpha = 0
        
        let addYourOwnFrame = CGRect(x: buttonXCoordinate, y: buttonYCoordinate, width: buttonSize.width, height: buttonSize.height)
        let addYourOwnButton = UIButton(frame: addYourOwnFrame)
        addYourOwnButton.setTitle("Add Your Own", forState: UIControlState.Normal)
        addYourOwnButton.alpha = 0
        
        view.addSubview(previousDriveButton)
        view.addSubview(addYourOwnButton)
        view.addSubview(chooseDriveButton)
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            chooseDriveButton.alpha = 1.0
            chooseDriveButton.frame = CGRect(x: buttonXCoordinate, y: self.view.frame.height - 300, width: buttonSize.width, height: buttonSize.height)
            
            previousDriveButton.alpha = 1.0
            previousDriveButton.frame = CGRect(x: buttonXCoordinate, y: self.view.frame.height - 200, width: buttonSize.width, height: buttonSize.height)
            
            addYourOwnButton.alpha = 1.0
            addYourOwnButton.frame = CGRect(x: buttonXCoordinate, y: self.view.frame.height - 100, width: buttonSize.width, height: buttonSize.height)
            
            
        }, completion: nil )
        
        
    }
    
    func chooseRouteSelected() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
}


