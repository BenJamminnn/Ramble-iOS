//
//  RMBStarView.swift
//  Ramble
//
//  Created by Mac Admin on 7/20/15.
//  Copyright (c) 2015 RMB. All rights reserved.
//


class RMBStarView: UIView {
    
    private let starFilledImage = UIImage(named: "StarFilled")
    private let starEmptyImage = UIImage(named: "StarEmpty")
    
    private var stars: Array<UIImageView> = []
    private var starXIndexes: Array<CGFloat> = []
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        generateStars()

    }

    func generateStars() {
        let starWidth: CGFloat = frame.width/5.0
        let starHeight: CGFloat = frame.height
        for i in 1...5 {
            let starXIndex = CGFloat(CGFloat(i) * starWidth)
            let imageViewFrame = CGRect(x: starXIndex, y: CGFloat(0.0), width: starWidth, height: starHeight)
            let starImageView = UIImageView(frame: imageViewFrame)
            starImageView.image = starEmptyImage
            addSubview(starImageView)
            stars.append(starImageView)
            starXIndexes.append(starXIndex)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let touchLocation = touch.locationInView(self).x as CGFloat
            fillNearestStarWithLocation(touchLocation)
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    func fillNearestStarWithLocation(location: CGFloat) {
        for index in 0...4 {
            if location < starXIndexes[index] {
                fillStars(index + 1)
            }
        }
    }
    
    func fillStars(numberOfStars: Int) {
        for i in 0...numberOfStars {
            stars[i].image = starFilledImage
        }
    }
}
