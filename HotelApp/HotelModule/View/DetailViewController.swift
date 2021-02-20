//
//  DetailViewController.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import UIKit

//protocol DetailDelegate {
//    func setDetail(hotel: Hotels)
//}

class DetailViewController: UIViewController {
    
    let hotelImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let hotelName = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = false
        
        setup()
    }
    
    
    func setup() {
        hotelImage.translatesAutoresizingMaskIntoConstraints  = false
        hotelName.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hotelImage)
        view.addSubview(hotelName)
        
        hotelImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        hotelImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hotelImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hotelImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        hotelName.topAnchor.constraint(equalTo: hotelImage.bottomAnchor, constant: 40).isActive = true
        hotelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hotelName.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hotelName.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }

}
