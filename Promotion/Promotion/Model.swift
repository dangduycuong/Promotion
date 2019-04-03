//
//  Model.swift
//  Promotion
//
//  Created by duycuong on 4/3/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import Foundation

struct Promo {
    var point: Int?
    var code: Int?
    var data: [PromoData] = []
    var points: [POINTS] = []
    
    init(dictionary: DICT) {
        code = dictionary["code"] as? Int ?? 0
        
        
        let arrayData = dictionary["data"] as? [DICT] ?? []
        
        for promoData in arrayData {
            self.data.append(PromoData(dictionary: promoData))
        }
        
    }
    
}

struct PromoData {
    var keyString: String?
    var availableTo: String?
    
    init(dictionary: DICT) {
        keyString = dictionary["key_string"] as? String ?? ""
        availableTo = dictionary["available_to"] as? String ?? ""
        
    }
}

struct POINTS {
    var rewardPoints: Int?
    init(dictionary: DICT) {
        rewardPoints = dictionary["reward_points"] as? Int ?? 0
    }
}


