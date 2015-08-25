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

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var chooseDriveButtonMenuOpen = false
    private var subMenuItems: [UIButton] = []
    private var menuItems: [UIButton] = []
    
    private var pickerView = UIPickerView()
    private let pickerData = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
    private var pickerViewToolBar = UIToolbar()
    
    private var rambleButton: UIButton? = nil
    private var isRambleButtonPresented: Bool = false
    
    override func viewDidLoad() {
        generateSubMenuItems()
        setUpSubviews()
        
        setUpPicker()
        rambleButton = generateRambleButton()
        super.viewDidLoad()
    }
    
    func setUpSubviews() {
        view.addSubview(UIView.backgroundView())
        addBlurEffect()
        
        let fontSize: CGFloat = view.frame.height < 667 ? 42 : 56
        let labelFont = UIFont(name: "VentographyPersonalUseOnly", size: fontSize)
        
        view.addSubview(UIView.headerViewWithName("Ramble", font: labelFont))


    }
    
    private func removeAllSubviews() {
        for subView in self.menuItems + self.subMenuItems {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                subView.alpha = 0.0
                    }, completion: { (finished) -> Void in
                        subView.removeFromSuperview()
                })
        }
        removeRambleButton()
        self.view.addSubview(BGRouteView(numberOfRoutes: 8))
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
            menuItems.append(button)
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
    
    //MARK: Choose Drive Selected
    
    func chooseDriveSelected(sender: UIButton) {

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
        UIView.animateWithDuration(0.3, animations: { () -> Void in
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
        dismissPickerView()
        removeRambleButton()
    }
    
    func presentSubMenuItems() {
        
        for label in subMenuItems {
            label.alpha = 0
            view.addSubview(label)
        }
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            for label in self.subMenuItems {
                label.alpha = 1.0
            }
        })
        if isRambleButtonPresented == false {
            presentLetsRambleButton()
        }
    }
    
    func generateSubMenuItems() {
        let font = UIFont(name: "BirchStd", size: 32.0)
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        let defaultLabelWidth: CGFloat = 200.0
        let defaultLabelHeight: CGFloat = 50.0
        
        let rangeLabelFrame = CGRect(x: 0, y: screenHeight/2.2, width: defaultLabelWidth, height: defaultLabelHeight)
        let ratingLabelFrame = CGRect(x: 0, y: screenHeight/1.88, width: defaultLabelWidth, height: defaultLabelHeight)
        let lengthLabelFrame = CGRect(x: 0, y: screenHeight/1.65, width: defaultLabelWidth, height: defaultLabelHeight)
        
        let rangeValueFrame = CGRect(x: view.frame.width/3.0, y: rangeLabelFrame.origin.y, width: defaultLabelWidth, height: defaultLabelHeight)
        let starViewFrame = CGRectZero
        let lengthValueFrame = CGRect(x: view.frame.width/3.0, y: lengthLabelFrame.origin.y, width: defaultLabelWidth, height: defaultLabelHeight)
        
        //RANGE LABEL AND VALUE
        let rangeLabel = UIButton(frame: rangeLabelFrame)
        rangeLabel.setTitle("RANGE", forState: UIControlState.Normal)
        
        let rangeValueLabel = UIButton(frame: rangeValueFrame)
        rangeValueLabel.setTitle("-", forState: UIControlState.Normal)
        rangeValueLabel.addTarget(self, action: Selector("presentPickerView:"), forControlEvents: UIControlEvents.TouchUpInside)
        rangeValueLabel.tag = 0
        
        //Still prototyping RMBStarView
        //RATING LABEL AND VALUE -- STARVIEW
//        let ratingLabel = UIButton(frame: ratingLabelFrame)
//        ratingLabel.setTitle("RATING", forState: UIControlState.Normal)
//        
//        let ratingValueLabelFrame =  CGRectMake(rangeValueLabel.frame.origin.x, ratingLabelFrame.origin.y, 100, 50)
//        let ratingValueLabelView = RMBStarView(frame: ratingValueLabelFrame)
//        let ratingValueLabel = UIButton(frame: ratingValueLabelFrame)
//        ratingValueLabel.setImage(UIImage.imageWithView(ratingValueLabelView), forState: UIControlState.Normal)
//        
        
        //LENGTH LABEL AND VALUE
        let lengthLabel = UIButton(frame: lengthLabelFrame)
        lengthLabel.setTitle("LENGTH", forState: UIControlState.Normal)
        
        let lengthValueLabel = UIButton(frame: lengthValueFrame)
        lengthValueLabel.setTitle("-", forState: UIControlState.Normal)
        lengthValueLabel.addTarget(self, action: Selector("presentPickerView:"), forControlEvents: UIControlEvents.TouchUpInside)
        lengthValueLabel.tag = 1

        let labelsLeft = [rangeLabel, lengthLabel]
        let labelsRight = [rangeValueLabel, lengthValueLabel]
        
        
        for label in labelsLeft {
            label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
            label.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            label.titleLabel?.font = font
            label.alpha = 0.0
        }
        
        for label in labelsRight {
            label.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
            label.titleLabel?.font = font
            label.alpha = 0.0
        }
        subMenuItems = labelsLeft + labelsRight
    }
    
    //MARK: Let's Ramble Button
    
    func generateRambleButton() -> UIButton {
        let buttonFrame = CGRectMake(0, view.frame.height, view.frame.width, 80)
        let button = UIButton(frame: buttonFrame)
        button.backgroundColor = UIColor(red: 69/255, green: 205/255, blue: 248/255, alpha: 1.0)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.titleLabel?.frame = buttonFrame
        let fontSize: CGFloat = view.frame.height < 667 ? 42 : 56
        let labelFont = UIFont(name: "VentographyPersonalUseOnly", size: fontSize)
        button.titleLabel?.frame = buttonFrame
        button.setAttributedTitle(NSAttributedString(string: "Let's Ramble", attributes: [NSFontAttributeName : labelFont!]), forState: UIControlState.Normal)
        button.showsTouchWhenHighlighted = true
        button.alpha = 1.0
        button.addTarget(self, action: Selector("letsRambleTapped"), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    func removeRambleButton() {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            for menuElement in self.subMenuItems + self.menuItems {
                menuElement.frame = CGRect(x: menuElement.frame.origin.x, y: menuElement.frame.origin.y + 100, width: menuElement.frame.size.width, height: menuElement.frame.size.height)
            }
            self.rambleButton!.frame = CGRect(x: self.rambleButton!.frame.origin.x, y: self.rambleButton!.frame.origin.y + 100, width: self.rambleButton!.frame.width, height: self.rambleButton!.frame.height)
        }) { (finished) -> Void in
            rambleButton?.removeFromSuperview()
        }
        isRambleButtonPresented = false
    }
    
    func changeButtonColor() {
        let greenBackground = UIColor(red: 73/255, green: 210/255, blue: 87/255, alpha: 1.0)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.rambleButton?.backgroundColor = greenBackground
        })
    }
    
    func presentLetsRambleButton() {
        if isRambleButtonPresented == true {
            return
        }
        var shouldBeGreen: Bool = true
        for subMenuItem in subMenuItems {
            if subMenuItem.titleLabel?.text == "-" {
                shouldBeGreen = false
            }
        }
        
        if shouldBeGreen {
            changeButtonColor()
        }

        view.addSubview(rambleButton!)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            for menuElement in self.subMenuItems + self.menuItems {
                menuElement.frame = CGRect(x: menuElement.frame.origin.x, y: menuElement.frame.origin.y - 80, width: menuElement.frame.size.width, height: menuElement.frame.size.height)
            }
            self.rambleButton!.frame = CGRect(x: self.rambleButton!.frame.origin.x, y: self.rambleButton!.frame.origin.y - 80, width: self.rambleButton!.frame.width, height: self.rambleButton!.frame.height)
        }) { (finished) -> Void in
        }
        
        isRambleButtonPresented = true
    }
    
    func letsRambleTapped() {
        removeAllSubviews()
    }
    
    //MARK: Picker View
    
    func presentPickerView(sender: UIButton) {
        if pickerView.superview == nil {
            view.addSubview(pickerView)
            view.addSubview(pickerViewToolBar)
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.pickerView.frame = CGRectMake(0, self.view.frame.height - 200, self.view.frame.width, 300)
                self.pickerViewToolBar.frame = CGRectMake(0, self.view.frame.height - 200, self.view.frame.width, 44)
            }) { (finished) -> Void in
            }
            pickerView.tag = sender.tag
        }
        
    }
    
    func setUpPicker() {
        let pickerFrame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        pickerView = UIPickerView(frame: pickerFrame)
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.alpha = 1.0
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 3
        pickerViewToolBar = pickerToolBar()
        
    }
    
    func pickerToolBar() -> UIToolbar {
        var toolbar = UIToolbar()
        toolbar.frame = CGRectMake(pickerView.frame.origin.x, view.frame.height, view.frame.width, pickerView.frame.height)
        toolbar.barStyle = .Default
        toolbar.translucent = true
        toolbar.backgroundColor = UIColor.clearColor()
        toolbar.tintColor = UIColor.blackColor()
        toolbar.alpha = 0.6
        toolbar.sizeToFit()

        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismissPickerView"))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.userInteractionEnabled = true
        return toolbar
    }
    
    func dismissPickerView() {
        let chosenIndex = pickerView.selectedRowInComponent(0)
        println("dismissing picker view, selected row:\(chosenIndex)")
        
        let animationFrame = CGRectMake(self.pickerView.frame.origin.x, self.view.frame.height, self.view.frame.width, self.pickerView.frame.height)

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.pickerView.frame = animationFrame
            self.pickerViewToolBar.frame = animationFrame
        }) { (finished) -> Void in
            self.pickerView.removeFromSuperview()
            self.pickerViewToolBar.removeFromSuperview()
        }
        let mileValue = pickerData[chosenIndex]
        let updatedButton = pickerView.tag == 0 ? subMenuItems[2] : subMenuItems[3]
        updatedButton.setTitle(String(mileValue), forState: UIControlState.Normal)
        
        var shouldBeGreen: Bool = true
        for subMenuItem in subMenuItems {
            if subMenuItem.titleLabel?.text == "-" {
                shouldBeGreen = false
            }
        }
        
        if shouldBeGreen {
            changeButtonColor()
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [NSFontAttributeName : UIFont(name: "BirchStd", size: 32.0)!]
        if row < pickerData.count - 1 {
            let attributedTitle = NSAttributedString(string: String(pickerData[row]), attributes: attributes)
            return attributedTitle
        }
        return NSAttributedString(string: String("Out of bounds"))
    }

}

extension ViewController : UIPickerViewDataSource  {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
}



