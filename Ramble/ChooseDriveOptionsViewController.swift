//
//  ChooseDriveOptionsViewController.swift
//  Ramble
//
//  Created by Mac Admin on 7/19/15.
//  Copyright (c) 2015 RMB. All rights reserved.
//

import UIKit

class ChooseDriveOptionsViewController: UIViewController {
    
    override func viewDidLoad() {
        setUpSubviews()
        super.viewDidLoad()
    }
    
    func setUpSubviews() {
        view.addSubview(UIView.backgroundView())
    
        //TODO: Hacky solution, fix later
        let blurEffectView = UIView.blurEffectView(0.0)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            blurEffectView.alpha = 1.0
        })
        view.addSubview(blurEffectView)
        let font = UIFont(name: "BirchStd", size: 36.0)
        view.addSubview(UIView.headerViewWithName("CHOOSE YOUR DRIVE", font: font))
        
        presentMenuItems()
    }
    
    func presentMenuItems() {
        let font = UIFont(name: "BirchStd", size: 52.0)
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        let rangeLabelFrame = CGRect(x: 0, y: screenHeight/2.5, width: 300, height: 100)
        let ratingLabelFrame = CGRect(x: 0, y: screenHeight/1.7, width: 300, height: 100)
        let lengthLabelFrame = CGRect(x: 0, y: screenHeight/1.5, width: 300, height: 100)
        
        
        let rangeLabel = UIButton(frame: rangeLabelFrame)
        rangeLabel.setTitle("RANGE", forState: UIControlState.Normal)
        
        let ratingLabel = UIButton(frame: ratingLabelFrame)
        ratingLabel.setTitle("RATING", forState: UIControlState.Normal)
        
        let lengthLabel = UIButton(frame: lengthLabelFrame)
        lengthLabel.setTitle("LENGTH", forState: UIControlState.Normal)
        
        
        let labels = [rangeLabel, ratingLabel, lengthLabel]
        
        for label in labels {
            label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
            label.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            label.titleLabel?.font = font
            view.addSubview(label)
        }
        
    }
}
