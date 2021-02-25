//
//  ViewController.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import UIKit

class HotelsViewController: UIViewController {
    
    var isSorted: Bool = false
    
    lazy var sortByRooms: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(sortByRoomsPressed), for: .touchUpInside)
        return button
    }()
    
    var hotelView = HotelView()
    
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hotels"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortByRoomsPressed))
        self.view.backgroundColor = .white
        hotelView.delegate = self
        viewModel.startFetching()
        setup()
        updateView()
    }
    
    private func updateView(){
        viewModel.updateViewData = { [weak self] hotelsData in
            self?.hotelView.viewData = hotelsData
        }
    }
    
    @objc func sortByRoomsPressed(){
        if !isSorted {
            viewModel.sortbyRooms()
            isSorted = true
        }else{
            viewModel.unSort()
            isSorted = false
        }
    }
    
    private func setup(){
        view.addSubview(hotelView)
        view.addSubview(sortByRooms)
        hotelView.translatesAutoresizingMaskIntoConstraints = false
        sortByRooms.translatesAutoresizingMaskIntoConstraints = false
        
        hotelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        hotelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        hotelView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        hotelView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

//MARK: - HotelDelegate

extension HotelsViewController: HotelDelegate {
    func goToDetails(hotelID: Int) {
        let detailsViewController = DetailViewController()
        detailsViewController.getHotelID(hotelID: hotelID)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
