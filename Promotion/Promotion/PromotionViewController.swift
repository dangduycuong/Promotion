//
//  ViewController.swift
//  Promotion
//
//  Created by duycuong on 4/2/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class PromotionViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageLabel: UILabel! {
        didSet {
            pageLabel.text = "\(suggestAlbum.count)"
        }
    }
    
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
    
    var listAlbum = [AlbumModel]()
    var suggestAlbum = [AlbumModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        
        tableView.register(PromotionTableViewCell.nib(), forCellReuseIdentifier: PromotionTableViewCell.identifier())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setDataArrayFromAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let link = "https://jsonplaceholder.typicode.com/photos"
        showLoading()
        BaseRouter.shared.getData(urlString: link, method: HTTPMethod.get, completion: { (data: [AlbumModel]) in
            self.hideLoading()
            self.listAlbum = data
            self.suggestAlbum = data
            self.pageLabel.text = "\(data.count)"
            self.tableView.reloadData()
        })
    }
    
    
    
    func setDataArrayFromAPI() {
        PromotionDataService.shared.getData{ (data) in
            print(data)
            self.dataString = "code = \(data.code ?? 0)"
            self.dataArrayFromAPI = data.data
            
            
            self.alterLayout()
            
            self.filterData = self.dataArrayFromAPI
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataArrayFromAPI.count
//        return filterData.count
        return suggestAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromotionTableViewCell.identifier(), for: indexPath) as! PromotionTableViewCell
        
        cell.data = suggestAlbum[indexPath.row]
        
        
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        
//        cell.titleLabel.text = "filterData[indexPath.row].keyString"
//        cell.timeLabel.text = "filterData[indexPath.row].availableTo"
        
        cell.timeLabel.text = listAlbum[indexPath.row].thumbnailUrl
        
        //cell.timeLabel.text = getTimeOfDate()
        cell.timeLabel.textColor = UIColor.gray
        
        cell.fillData()
        
        if let link = listAlbum[indexPath.row].url {
            cell.avatarImageView.dowloadFromServer(link: link)
        }
        
//        if listImage.count > 0 {
//            cell.avatarImageView.image = listImage[indexPath.row]
//        }
        
        cell.closureLoadImage = { data in
            
//            DispatchQueue.global().sync {
//                guard let url = URL(string: data) else {
//                    return
//                }
//                if let imageData = try? Data(contentsOf: url) {
//                    cell.avatarImageView.image = UIImage(data: imageData)
////                    DispatchQueue.main.async {
////                        cell.avatarImageView.image = UIImage(data: imageData)
////                    }
//                }
//            }
        }
        
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
    
    func filterAlbum() {
        if searchBar.text == "" {
            suggestAlbum = listAlbum
        } else {
            suggestAlbum = listAlbum.filter { (data: AlbumModel) in
                if let key = searchBar.text, let title = data.title {
                    if title.lowercased().range(of: key.lowercased()) != nil {
                        return true
                    }
                }
                return false
            }
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            filterData = dataArrayFromAPI
//            tableView.reloadData()
//            return
//
//        }
//
//        filterData = dataArrayFromAPI.filter({ canabis -> Bool in
//            canabis.keyString!.lowercased().contains(searchText.lowercased())
//        })
        
        filterAlbum()
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
    
    //MARK: SearchBar Delegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
