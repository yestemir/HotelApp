//
//  HotelModel.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import Foundation
import UIKit

enum Hotels {
    case initial
    case loading
    case success([MainData])
    case failure(Error)
    case updateImage([UIImage], [MainData])
    
    struct MainData: Decodable{
        let id: Int
        let name: String
        let address: String
        let stars: Double
        let distance: Double
        let suites_availability: String
    }
    
}



