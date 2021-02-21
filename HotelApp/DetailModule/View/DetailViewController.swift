//
//  DetailViewController.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var viewModel = DetailsViewModel()
    var detailsView = DetailsView()
    
    var mainVC = HotelViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateView()
    }
    
    public func getHotelID(hotelID: Int){
        viewModel.startFetching(hotelID: hotelID)
    }
    
    func updateView(){
        viewModel.updateViewData = { [weak self] viewData in
            self?.detailsView.hotelsData = viewData
        }
    }
    
    func updateImage(){
        viewModel.updateViewData = { [weak self] viewData in
            self?.detailsView.hotelsData = viewData
        }
    }
    
    private func setup(){
        self.view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        detailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
