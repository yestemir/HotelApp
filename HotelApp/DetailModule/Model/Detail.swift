//
//  Detail.swift
//  HotelApp
//
//  Created by Dina Yestemir on 21.02.2021.
//

import Foundation
import UIKit

enum HotelDetail {
    case initial
    case loading
    case success(MainData)
    case failure(Error)
    case updateImage(UIImage, MainData)
    
    struct MainData: Codable{
        let id: Int
        let name: String
        let address: String
        let stars: Double
        let distance: Double
        let suites_availability: String
        let image: String?
    }
}
