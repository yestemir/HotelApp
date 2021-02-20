//
//  HotelModel.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import Foundation

struct HotelModel : Codable {
    let id: Int
    let name : String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
}
