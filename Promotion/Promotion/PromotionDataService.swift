//
//  PromotionDataService.swift
//  Promotion
//
//  Created by duycuong on 4/3/19.
//  Copyright © 2019 duycuong. All rights reserved.
//


import UIKit

typealias DICT = Dictionary<AnyHashable,Any>

class PromotionDataService {
    static var shared: PromotionDataService = PromotionDataService()
    
    func getData(completedHandler: @escaping(Promo) -> Void) {
        //        let url = "https://159.65.135.188:9670/client/login"
        let url = "http://159.65.135.188:9670/promo/list/0/20"
        //        let body = """
        //            {
        //                "phone_number": "+84924586555",
        //                "password": "123456",
        //                "latitude": 21.0335302,
        //                "longtitude":105.7678049,
        //                "device_id":"dx9ge4XZza8:APA91bFB-wPXpzbnKL-k9apPbAwqxkKbfj-pjX7dG5iL5vcpDVrvYKchZoyEUP3hYPo_cnoBf3Pr242NwHtIqT9kW4wOAQ5EgVN9ALIn6qIsQU4p9FlQhh2x9gs1dxVmUiD8F6uw6lb6"
        //            }
        //        """
        
        
        guard let urlString = URL(string: url) else {return}
        var urlRequest = URLRequest(url: urlString)
        //        urlRequest.httpMethod = "GET"
        //        urlRequest.httpBody = body.data(using: .utf8)
        //        let downloadTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
        //            <#code#>
        //        }
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do {
                if let jSonObject = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                    DispatchQueue.main.async {
                        completedHandler(Promo(dictionary: jSonObject))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        downloadTask.resume()
    }
}
