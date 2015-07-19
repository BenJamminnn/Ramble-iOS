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
        view.addSubview(UIView.backgroundView())
        addBlurEffect()
        view.addSubview(UIView.headerViewWithName("Ramble"))
        super.viewDidLoad()
    }
    
    func addBlurEffect() {
        let blurEffectView = UIView.blurEffectView()
        self.view.addSubview(blurEffectView) //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view instead
        UIView.animateWithDuration(1, animations: { () -> Void in
            blurEffectView.alpha = 1.0
            self.presentMenuItems()
        }) { (finished) -> Void in
        }
        //no need for autolayout yet
        //add auto layout constraints so that the blur fills the screen upon rotating device
//        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: blurEffectView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    }
    
    func presentMenuItems() {
        let buttonSize = CGSize(width: 300, height: 100)
        let buttonXCoordinate = CGFloat(0)
        let buttonYCoordinate = view.frame.height + 200
        let buttonStartFrame = CGRect(x:  buttonXCoordinate, y:buttonYCoordinate , width: buttonSize.width, height: buttonSize.height)
        
        let chooseDriveButton = UIButton(frame: buttonStartFrame)
        chooseDriveButton.setTitle("CHOOSE YOUR DRIVE", forState: UIControlState.Normal)
        
        let previousDriveButton = UIButton(frame: buttonStartFrame)
        previousDriveButton.setTitle("PREVIOUS DRIVE", forState: UIControlState.Normal)
        
        let addYourOwnButton = UIButton(frame: buttonStartFrame)
        addYourOwnButton.setTitle("ADD YOUR OWN", forState: UIControlState.Normal)
        
        var buttons: [UIButton] = [chooseDriveButton, previousDriveButton, addYourOwnButton]
        
        for button in buttons {
            button.titleLabel?.font =  UIFont(name: "BirchStd", size: 40)
            button.alpha = 0
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            view.addSubview(button)
        }
        
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
}


