//
//  ViewController.swift
//  Promotion
//
//  Created by duycuong on 4/2/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var timer = Timer?.self
    var dataString: String?
    var dataArrayFromAPI: [PromoData] = []
    var filterData: [PromoData] = []
    
    
    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        //tmpFormatter.dateFormat = "hh:mm a"
        //tmpFormatter.dateFormat = "yyyy MMM dd HH:mm:ss z"
        tmpFormatter.dateFormat = "dd MMM yyyy"
        
        return tmpFormatter
    }()
    
    func getTimeOfDate() -> String {
        let curDate = Date()
        let timeString = formatter.string(from: curDate)
        return timeString
        
    }
    
    let url = "http://159.65.135.188:9670/promo/list/0/20"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDataArrayFromAPI()
    }
    
    func setDataArrayFromAPI() {
        PromotionDataService.shared.getData{ (data) in
            print(data)
            self.dataString = "code = \(data.code ?? 0)"
            self.dataArrayFromAPI = data.data
            
            self.setUpSearchBar()
            self.alterLayout()
            
            self.filterData = self.dataArrayFromAPI
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataArrayFromAPI.count
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PromotionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        print("--------------")
        
        cell.titleLabel.text = filterData[indexPath.row].keyString
        cell.timeLabel.text = filterData[indexPath.row].availableTo
        
        //cell.timeLabel.text = getTimeOfDate()
        cell.timeLabel.textColor = UIColor.gray
        
        return cell
    }
    
    // MARK: - Method for search
    func searchBarEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchBarEmpty() == true
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func alterLayout() {
        tableView.tableHeaderView = UIView()
        
        //search bar in section header
        //tableView.estimatedSectionHeaderHeight = 150
        
        //search bar in navigation bar
        navigationItem.titleView = searchBar
        
        searchBar.showsScopeBar = false
        searchBar.placeholder = "Search by Name"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterData = dataArrayFromAPI
            tableView.reloadData()
            return
            
        }
        
        filterData = dataArrayFromAPI.filter({ canabis -> Bool in
            canabis.keyString!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            filterData = dataArrayFromAPI
        default:
            break
        }
        tableView.reloadData()
    }

}
