//
//  HomeViewController.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 24/01/22.
//

import UIKit
import SnapKit
import Alamofire

class HomeViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableview = UITableView()
    let defaults = UserDefaults.standard
    var refreshControl: UIRefreshControl!
   
    
    var datas: SearchModel?
    var routes: Routes?
    
    var toCity: City?
    var fromCity: City?
    var isSelect = true
    var showInfo = false
    var type = 0
    var orient = 1
    
    
   
    let bgColor = UIColor(red: 145/255, green: 112/255, blue: 241/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        
        configureSearchBar()
        
        initSubviews()
        embedSubviews()
        addSubviewsConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

//        DispatchQueue.main.async {
//            print("1")
//            print("2")
//            DispatchQueue.main.async {
//                print("3")
//            }
//            print("4")
//            DispatchQueue.global().sync {
//                print("5")
//            }
//        }
//        print("6")
        
    }
    
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            orient = 2
        } else {
            orient = 1
        }
        tableview.reloadData()
    }
    
    @objc func refresh(_ sender: Any) {
        refreshControl.endRefreshing()
    }

    func initSubviews() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "loading...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
        tableview.addSubview(refreshControl)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        tableview.register(SelectionCell.self, forCellReuseIdentifier: "SelectionCell")
        tableview.register(FlightsCell.self, forCellReuseIdentifier: "FlightsCell")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func embedSubviews() {
        view.addSubview(tableview)
    }
    
    func addSubviewsConstraints() {
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension HomeViewController: UISearchBarDelegate {
    
    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.endEditing(true)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.placeholder = " write city name"
        searchBar.searchTextField.leftView?.tintColor = .black
        
        self.searchBar.delegate = self
       
        navigationController?.navigationBar.backgroundColor = bgColor
        navigationItem.title = " Flights around the world "
        navigationController?.navigationBar.tintColor = .black
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.barTintColor = bgColor
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func handleShowSearchBar () {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func search(shouldShow: Bool) {
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSelect = !isSelect
        tableview.reloadData()
        search(shouldShow: false)
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 1{
            search(cityQ: searchText)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelect {
            if showInfo {
                return (1 + (routes?.flights.count ?? 0))
            }
            return 1
        }
        if datas?.data?.cities.count == 0{
            return 1
        }
        return datas?.data?.cities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSelect {
            if indexPath.row >= 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightsCell") as! FlightsCell
                cell.routes = self.routes
                cell.index = indexPath.row - 1
                cell.reload(or: self.orient)
                cell.qwe = { index in
                    let controller = MapViewController()
                    self.navigationController?.pushViewController(controller, animated: true)
                    controller.routes = self.routes
                    controller.title = ""
                    controller.tabIndex = indexPath.row-1
                    controller.collIndex = index
                }
                cell.backgroundColor = .clear
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionCell")! as! SelectionCell
            cell.fromWhere.addTarget(self, action: #selector(fromtoClicked), for: .touchUpInside)
            cell.toWhere.addTarget(self, action: #selector(fromtoClicked), for: .touchUpInside)
            cell.change.addTarget(self, action: #selector(changeClicked), for: .touchUpInside)
            if fromCity != nil {
                cell.fromWhere.setTitle(fromCity?.city ?? "", for: .normal)
            }
            if toCity != nil {
                cell.toWhere.setTitle(toCity?.city ?? "", for: .normal)
            }
            if fromCity != nil && toCity != nil {
                cell.initDatas("Direct dest: \(routes?.directdist ?? 0) km")
            }
            cell.backgroundColor = .clear
            return cell
        }
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if datas?.data?.cities.count != 0 {
            cell.textLabel?.text = "\(datas?.data?.cities[indexPath.row].city ?? ""), \(datas?.data?.cities[indexPath.row].citycode ?? ""), \(datas?.data?.cities[indexPath.row].country ?? "")"
        } else {
            cell.textLabel?.text = "City not found!"
            cell.selectionStyle = .none
        }
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .black
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isSelect && datas?.data?.cities.count != 0 {
            
            if type == 1 && toCity?.city != datas?.data?.cities[indexPath.row].city {
                fromCity = datas?.data?.cities[indexPath.row]
                type = 0
                search(shouldShow: false)
                isSelect = true
                searchBar.text = ""
                
            }
            if type == 2 && fromCity?.city != datas?.data?.cities[indexPath.row].city {
                toCity = datas?.data?.cities[indexPath.row]
                type = 0
                search(shouldShow: false)
                isSelect = true
                searchBar.text = ""
                
            }
            
            tableview.reloadData()
        }
        if fromCity != nil && toCity != nil {
            searchRoutes(from: fromCity!, to: toCity!)
            showInfo = true
            tableview.reloadData()
        }
    }
    
    @objc func fromtoClicked(_ sender: UIButton) {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
        isSelect = false
        tableview.reloadData()
        type = sender.tag%10
        datas = nil
        tableview.reloadData()
        
    }
    
    @objc func changeClicked(_ sender: UIButton) {
        if fromCity != nil && toCity != nil {
            let change = fromCity
            fromCity = toCity
            toCity = change

            searchRoutes(from: fromCity!, to: toCity!)
            showInfo = true
            tableview.reloadData()
        }
        
        
       
        
        
        
    }
    
    
    
}





//     AF: fetch data...

extension HomeViewController {
    
    func search(cityQ: String) {
        let urlString = "http://routes-global.us-east-2.elasticbeanstalk.com/api/search.php"
        let parameters = ["q": cityQ,
                          "t": "city",
                          "lang" : "en"]
        AF.request(urlString, parameters: parameters).responseJSON { response in
            if let responseData = response.data{
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String:AnyObject]{
                        let obj = SearchModel.init(json)
                        self.datas = obj
                        DispatchQueue.main.async {
                            print("tugadi")
                            self.tableview.reloadData()
                        }
                        print("nimadirlar")
                    }
                    
                } catch _ as NSError {
                    
                }
            }
//            print(response)
        }
    }

    
    func searchRoutes(from: City, to: City) {
        let urlString = "http://routes-global.us-east-2.elasticbeanstalk.com/api/routes.php"

                    let parameters = ["apch": "2",
                                      "dest": to.citycode,
                                      "lang" : "en",
                                      "orig" : from.citycode,
                                      "recurs" : "4"]
        
        AF.request(urlString, parameters: parameters).responseJSON { response in
            if let responseData = response.data{
                do {
                    if let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String:AnyObject]{
                        
                        let obj = Routes.init(json)
                        self.routes = obj
                
                        self.tableview.reloadData()
                        
                    }
                    
                } catch _ as NSError {
                    
                }
            }
            print(response)
        }
    }
    
    
}

