//
//  Spam.swift
//  Promotion
//
//  Created by duycuong on 4/3/19.
//  Copyright © 2019 duycuong. All rights reserved.
//


//class PromotionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    // MARK: - Intialization
//    var timer: Timer?
//
//    let formatter: DateFormatter = {
//        let tmpFormatter = DateFormatter()
//        //        tmpFormatter.dateFormat = "hh:mm a"
//        tmpFormatter.dateFormat = "dd MMM yyyy"
//        return tmpFormatter
//    }()
//
//    func getTimeOfDate() -> String {
//        var currentDate = Date()
//        var timeStamp = formatter.string(from: currentDate)
//        return timeStamp
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PromotionTableViewCell
//
//        cell.titleLabel.text = "Something"
//        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//
//        cell.timeLabel.text = getTimeOfDate()
//        cell.timeLabel.textColor = UIColor.gray
//
//        return cell
//    }
//}


