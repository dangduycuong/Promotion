//
//  AlbumModel.swift
//  Promotion
//
//  Created by Dang Duy Cuong on 3/3/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import UIKit

struct AlbumModel: Codable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    
    var thumbnailUrl: String?
}
