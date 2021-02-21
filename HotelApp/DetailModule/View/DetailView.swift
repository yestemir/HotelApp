//
//  DetailView.swift
//  HotelApp
//
//  Created by Dina Yestemir on 21.02.2021.
//

import UIKit


class DetailsView: UIView {
    
    lazy var hotelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    lazy var suitesAvailabilityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
   
    var hotelsData: HotelDetail = .initial{
        didSet{
            setNeedsLayout()
        }
    }
    
    
    override init(frame: CGRect = .zero) {
        super .init(frame: frame)
        self.backgroundColor = .white
        setup()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch hotelsData {
        case .initial:
            self.activityIndicator.isHidden = false
        case .loading:
            self.activityIndicator.isHidden = false
        case .success(let success):
            self.activityIndicator.isHidden = true
            self.update(viewData: success)
        case .failure:
            self.activityIndicator.isHidden = true
        }
    }
    
    private func update(viewData: HotelDetail.MainData?){
        guard let data = viewData  else { return }
        self.hotelImage.image = HotelImage.sharedInstance.image
        titleLabel.text = data.name
        addressLabel.text = data.address
        suitesAvailabilityLabel.text = String("Available rooms: \(data.suites_availability)")
    }
    
    private func setup(){
        [hotelImage, titleLabel, addressLabel, activityIndicator, suitesAvailabilityLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        hotelImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        hotelImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        hotelImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        hotelImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: hotelImage.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    
        
        suitesAvailabilityLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        suitesAvailabilityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        suitesAvailabilityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
}
