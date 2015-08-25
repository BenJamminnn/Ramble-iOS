//
//  BGRouteView.swift
//  CollectionView
//
//  Created by Mac Admin on 7/23/15.
//  Copyright (c) 2015 BG. All rights reserved.
//

import UIKit

class BGRouteView: UIView {
    
    var numberOfRoutes: Int = 0
    var subViews = [UIView?]()
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(numberOfRoutes: Int) {
        self.init()
        self.backgroundColor = UIColor.clearColor() 
        self.frame = UIScreen.mainScreen().bounds   
        self.numberOfRoutes = numberOfRoutes
        generateViews()
        addSubViewsToView()
        animateSubViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubViewsToView() {

        let subViewHeight = CGFloat(Double(frame.height)/Double(numberOfRoutes))
        for i in 0...numberOfRoutes {
            var subView = subViews[i]
            
            let subViewFrame = CGRect(x: 0, y: CGFloat(i * 100) + UIScreen.mainScreen().bounds.height, width: UIScreen.mainScreen().bounds.width, height: subViewHeight - 20)
            subView = addAnnotationToView(subView!)
            subView?.layer.cornerRadius = 5.0
            subView?.layer.borderWidth = 3.0
            subView?.layer.borderColor = UIColor.whiteColor().CGColor
            subView?.frame = CGRectInset(subViewFrame, 10.0, 20.0)
            subView?.alpha = 0.0
            addSubview(subView!)
        }
    }
    
    private func animateSubViews() {
        let subViewHeight = CGFloat(Double(frame.height)/Double(numberOfRoutes))
        let startInset = CGFloat(70)
        
        for i in 0...numberOfRoutes {
            var subView = subViews[i]
            let subViewFrame = CGRect(x: 0, y: CGFloat(i * 100) + startInset, width: UIScreen.mainScreen().bounds.width, height: subViewHeight + 40)

            UIView.animateWithDuration(2.0, animations: { () -> Void in
                subView?.frame = CGRectInset(subViewFrame, 10.0, 20.0)
            })
            
            UIView.animateWithDuration(3.0, animations: { () -> Void in
                subView?.alpha = 1.0
            })
        }
    }
    
    //random mileage from 0-70, just for show
    func addAnnotationToView(view: UIView) -> UIView! {
        let font = UIFont(name: "BirchStd", size: 32.0)
        let lengthLabelFrame = CGRect(x: 10, y: view.frame.height/3, width: view.frame.width, height: view.frame.height/2)
        let lengthLabel = UILabel(frame:lengthLabelFrame)
        let lengthText = arc4random_uniform(70)
        lengthLabel.text = "\(String(lengthText)) miles"
        lengthLabel.attributedText = NSAttributedString(string: lengthLabel.text!, attributes: [NSFontAttributeName : font!] )
        lengthLabel.textColor = UIColor.whiteColor()
        view.addSubview(lengthLabel)
        return view
    }
    
    private func generateViews() {
        for tempRoute in 0...numberOfRoutes {
            subViews.append(generateContentView(tempRoute))
        }
    }
    
    func generateContentView(index: Int) -> UIView? {
        let image = UIImage.imageWithImage(UIImage(named: "image\(index)"), size: CGSize(width: UIScreen.mainScreen().bounds.width, height: 100))
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func addBackground() {
        let bgImage = UIImage(named: "RambleBackground")
        let imageView = UIImageView(image: bgImage)
        imageView.frame = UIScreen.mainScreen().bounds
        let blurEffectView = UIView.blurEffectView(0.0)
        addSubview(imageView)
        addSubview(blurEffectView)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            blurEffectView.alpha = 1.0
        })
    }

}

extension UIImage {
    class func imageWithImage(image: UIImage!, size: CGSize) -> UIImage! {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.drawInRect(CGRectMake(0.0, 0.0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

