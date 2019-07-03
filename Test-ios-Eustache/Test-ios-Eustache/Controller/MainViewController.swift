//
//  MainViewController.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 02/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import UIKit

class MainViewController: UIViewController  {
    
    var currentPage : Int = 0
    var isDataLoading : Bool = false
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColor.mainColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        return tableView
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var errorLabel : UILabel =  {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = label.font.withSize(30)
        label.text = "error in loading deliveries"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    var refreshButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10

        button.setTitle("Refresh", for: .normal)
        
        button.setTitleColor(AppColor.mainColor, for: .normal)
        
        button.addTarget(self, action: #selector(tapRefresh(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    fileprivate let reuseIdentifier = "cellId"
    
    var delivery = [Delivery]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        loadData()
    }
    
    func setupViews(){
        
        navigationItem.title = "Things to deliver"
        tableView.separatorStyle = .none
        view.backgroundColor = AppColor.mainColor
        
        view.addSubview(tableView)
        setupTableViewConstraint()
        
        view.addSubview(activityIndicator)
        setupActivityIndicatorConstraint()
        
        view.addSubview(errorLabel)
        setupErrorlabelConstraint()
        
        view.addSubview(refreshButton)
        setupRefreshButtonConstraint()
        
    }
    
    func setupTableViewConstraint(){
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupActivityIndicatorConstraint(){
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupErrorlabelConstraint(){
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupRefreshButtonConstraint(){
        refreshButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10).isActive = true
        refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        refreshButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func tapRefresh(sender: UIButton) {
        self.loadData()
    }
    
    
    func loadData(_ pageNumber: Int = 0){
        
        self.refreshButton.isHidden = true
        self.errorLabel.isHidden = true
        self.isDataLoading = false
        self.activityIndicator.isHidden = false
        
        //To see the activity over the white cells
        if pageNumber > 1 {
            activityIndicator.color = UIColor.black
        }
        activityIndicator.startAnimating()
        self.view.bringSubviewToFront(activityIndicator)
        
        //Load the deliveries
        getDeliveries(withOffset: pageNumber*numberOfDataPerPages, limit: numberOfDataPerPages, completion: { (result) in
            
            switch result {
            case .success(let delivery):
                self.delivery += delivery
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.isHidden = false
                
            case .failure(let error):
                
                //if error use cache
                if self.delivery.count > 0 {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.tableView.isHidden = false
                } else {
                    print("error: \(error.localizedDescription)")
                    self.errorLabel.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.tableView.isHidden = true
                    self.refreshButton.isHidden = false
                }
            }
        })
    }
    
    
    //Pagination
    func loadMoreItemsForList(){
        currentPage += 1
        loadData(currentPage)
    }
}


extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delivery.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath) as! DeliveryTableViewCell
        cell.nameLabel.text = self.delivery[indexPath.row].description
        
        if let imageUrl = self.delivery[indexPath.row].imageUrl {
            cell.imageViewCell.imageFromServer(urlString:imageUrl, placeholder:  UIImage(named: "placeholder"))
        }
        
        return cell
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapViewController = MapViewController()
        
        mapViewController.delivery = delivery[indexPath.row]
        
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height && !isDataLoading) {
            self.isDataLoading = true
            self.loadMoreItemsForList()
        }
    }
}

