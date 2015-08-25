//
//  UIViewBackgroundExtension.swift
//  Ramble
//
//  Created by Mac Admin on 7/19/15.
//  Copyright (c) 2015 RMB. All rights reserved.
//

import UIKit

extension UIView {
    
    class func backgroundView() -> UIImageView {
        let screenFrame = UIScreen.mainScreen().bounds
        let imageView = UIImageView(frame: screenFrame)
        imageView.image =  UIImage(named: "RambleBackground")
        return imageView
    }
    
    class func blurEffectView(alpha: CGFloat) -> UIVisualEffectView {
        let screenFrame = UIScreen.mainScreen().bounds

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = screenFrame
        blurEffectView.alpha = 0.0
        return blurEffectView
    }
    
    class func headerViewWithName(name: String!, font: UIFont!) -> UIView {
        let screenFrame = UIScreen.mainScreen().bounds
        let height = screenFrame.height/10
        
        let topViewFrame = CGRect(x: 0, y: 0, width: screenFrame.width, height: height)
        var topView = UIView(frame: topViewFrame)
        topView.backgroundColor = UIColor(red: 69/255, green: 205/255, blue: 248/255, alpha: 1.0)

        let labelFont = font
        let labelText: String = name
        
        let labelTextModified = labelText as NSString
        let size: CGSize = labelTextModified.sizeWithAttributes([NSFontAttributeName: labelFont!])
        
        let labelFrame = CGRect(x: screenFrame.width/2 - size.width/2, y: topViewFrame.height/1.5 - size.height/2, width: 300, height: 50)
        let label = UILabel(frame: labelFrame)
        
        label.text = labelText
        label.textColor = UIColor.whiteColor()
        label.font = labelFont
        
        topView.addSubview(label)
        
        return topView
    }
}


extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
