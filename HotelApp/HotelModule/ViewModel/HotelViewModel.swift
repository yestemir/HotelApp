//
//  HotelViewModel.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import Foundation
import UIKit

class HotelViewModel {
    // MARK: - Initialization
    init(model: [HotelModel]? = nil) {
        if let inputModel = model {
            hotels = inputModel
        }
    }
    var hotels = [HotelModel]()
}

extension HotelViewModel {
    func fetchHotels(completion: @escaping (Result<[HotelModel], Error>) -> Void) {
        
        HTTPManager.shared.get(urlString: baseUrl + hotelsExtensionURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    self.hotels = try decoder.decode([HotelModel].self, from: dta)
                    completion(.success(try decoder.decode([HotelModel].self, from: dta)))
                } catch {
                    
                }
            }
        })
    }
}
