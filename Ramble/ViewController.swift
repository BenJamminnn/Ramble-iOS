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
    
    private var chooseDriveButtonMenuOpen = false
    private var subMenuItems: Array <UIButton> = []
    
    
    override func viewDidLoad() {
        generateSubMenuItems()
        setUpSubviews()
        super.viewDidLoad()
    }
    
    func setUpSubviews() {
        view.addSubview(UIView.backgroundView())
        addBlurEffect()
        
        let fontSize: CGFloat = view.frame.height < 667 ? 42 : 56
        let labelFont = UIFont(name: "VentographyPersonalUseOnly", size: fontSize)
        
        view.addSubview(UIView.headerViewWithName("Ramble", font: labelFont))


    }
    
    func addBlurEffect() {
        let blurEffectView = UIView.blurEffectView(0.0)
        view.addSubview(blurEffectView) //if you have more UIViews on screen, use insertSubview:belowSubview: to place it underneath the lowest view instead
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
        chooseDriveButton.addTarget(self, action: Selector("chooseDriveSelected:"), forControlEvents: UIControlEvents.TouchUpInside)
        
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
    
    func chooseDriveSelected(sender: UIButton) {
       // self.presentViewController(ChooseDriveOptionsViewController(), animated: true, completion: nil)
        //1 animate choose drive up
        //2 create new labels/buttons 
        //on completion, alpha = 1 
        if chooseDriveButtonMenuOpen {
            //close
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y + 150, sender.frame.width, sender.frame.height)
                self.removeSubMenuItems()
                }) { (finished) -> Void in
                self.chooseDriveButtonMenuOpen = false
            }
        } else {
            //open
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y - 150, sender.frame.width, sender.frame.height)
                self.presentSubMenuItems()

                }) { (finished) -> Void in
                  self.chooseDriveButtonMenuOpen = true
            }
        }

    }
    
    func removeSubMenuItems() {
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            for label in self.subMenuItems {
                label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y + 100, label.frame.width, label.frame.height)
                label.alpha = 0
            }
            }) { (finished) -> Void in
                for label in self.subMenuItems {
                    label.removeFromSuperview()
                    label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y - 100, width: label.frame.width, height: label.frame.height)
                    
                }
        }
    }
    
    func presentSubMenuItems() {
        
        for label in subMenuItems {
            label.alpha = 0
            view.addSubview(label)
        }
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            for label in self.subMenuItems {
                label.alpha = 1.0
            }
        })
    }
    
    
    func generateSubMenuItems() {
        let font = UIFont(name: "BirchStd", size: 32.0)
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        let rangeLabelFrame = CGRect(x: 0, y: screenHeight/2.4, width: 300, height: 100)
        let ratingLabelFrame = CGRect(x: 0, y: screenHeight/2.05, width: 300, height: 100)
        let lengthLabelFrame = CGRect(x: 0, y: screenHeight/1.75, width: 300, height: 100)
        
        
        let rangeLabel = UIButton(frame: rangeLabelFrame)
        rangeLabel.setTitle("RANGE", forState: UIControlState.Normal)
        
        let ratingLabel = UIButton(frame: ratingLabelFrame)
        ratingLabel.setTitle("RATING", forState: UIControlState.Normal)
        
        let lengthLabel = UIButton(frame: lengthLabelFrame)
        lengthLabel.setTitle("LENGTH", forState: UIControlState.Normal)
        
        
        let labels = [rangeLabel, ratingLabel, lengthLabel]
        
        for label in labels {
            label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
            label.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            label.titleLabel?.font = font
            label.alpha = 0.0
        }
        subMenuItems = labels
    }
}


