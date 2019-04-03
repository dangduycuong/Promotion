//
//  PromotionTableViewCell.swift
//  Promotion
//
//  Created by duycuong on 4/2/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var dashView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var topUpView: NSLayoutConstraint!
    
    @IBOutlet weak var bottomUnderView: NSLayoutConstraint!
    @IBOutlet weak var bottomDashView: NSLayoutConstraint!
    @IBOutlet weak var topDashView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customLayoutView()
        dashView.addDashedBorder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    func customLayoutView() {
        let radius = -(upView.bounds.height / 2)
        topUpView.constant = radius
        bottomUnderView.constant = radius
        topDashView.constant = -radius
        bottomDashView.constant = -radius
    }
    
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor.groupTableViewBackground.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

