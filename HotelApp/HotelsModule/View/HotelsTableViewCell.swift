//
//  HotelTableViewCell.swift
//  HotelApp
//
//  Created by Dina Yestemir on 21.02.2021.
//

import UIKit

class HotelsTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var imgView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.addSubview(titleLabel)
        self.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        

        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}

