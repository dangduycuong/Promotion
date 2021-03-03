//
//  PromotionTableViewCell.swift
//  Promotion
//
//  Created by duycuong on 4/2/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class PromotionTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var dashView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var topUpView: NSLayoutConstraint!
    
    @IBOutlet weak var bottomUnderView: NSLayoutConstraint!
    @IBOutlet weak var bottomDashView: NSLayoutConstraint!
    @IBOutlet weak var topDashView: NSLayoutConstraint!
    
    var data = AlbumModel()
    
    var closureLoadImage: ((String) -> ())?
    
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
    
    func fillData() {
        titleLabel.text = data.title
        if let id = data.id {
            idLabel.text = "    \(id) day   "
        }
        
        if let url = data.url {
            closureLoadImage?(url)
        }
    }
    
    func customLayoutView() {
        let radius = -(upView.bounds.height / 2)
        topUpView.constant = radius
        bottomUnderView.constant = radius
        topDashView.constant = -radius
        bottomDashView.constant = -radius
    }
    
    @IBAction func tapLoadImage(_ sender: Any) {
        if let url = data.url {
            closureLoadImage?(url)
        }
    }
    
    override func prepareForReuse() {
        avatarImageView.image = UIImage()
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

