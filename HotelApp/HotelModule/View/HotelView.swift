//
//  HotelView.swift
//  HotelApp
//
//  Created by Dina Yestemir on 21.02.2021.
//

import UIKit

class HotelView: UIView {
    
    var viewData: Hotels = .initial{
        didSet{
            setNeedsLayout()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var hotels = [Hotels.MainData]()
    
     var delegate: HotelDelegate!
    hotel
    override init(frame: CGRect = .zero) {
        super .init(frame: frame)
        self.backgroundColor = .white
        tableView.reloadData()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch viewData {
        case .initial:
            tableView.isHidden = true
            self.activityIndicator.isHidden = false
        case .loading:
            tableView.isHidden = true
            self.activityIndicator.isHidden = false
        case .success(let success):
            tableView.isHidden = false
            self.activityIndicator.isHidden = true
            hotels = success
            tableView.reloadData()
        case .failure:
            tableView.isHidden = true
            self.activityIndicator.isHidden = true
        }
    }
    
  
    
    private func setup(){
        self.addSubview(tableView)
        self.addSubview(activityIndicator)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

//MARK: - TableViewDelegates

extension HotelView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
            HotelTableViewCell
        let hotel = hotels[indexPath.row]
        cell.titleLabel.text = hotel.name
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HotelImage.sharedInstance.image = UIImage()
        delegate?.goToDetails(hotelID: hotels[indexPath.row].id)
    }
    
}
