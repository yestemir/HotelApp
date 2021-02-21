//
//  HotelViewModel.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import Foundation
import Moya

protocol HomeViewModelProtocol {
    var updateViewData: ((Hotels)->())? { get set }
    func startFetching()
}

final class HomeViewModel: HomeViewModelProtocol{
    var updateViewData: ((Hotels) -> ())?
    let provider = MoyaProvider<APIService>()
    
    var hotels = [Hotels.MainData]()
    
    init() {
        updateViewData?(.initial)
    }
    
    func sortbyRooms(){
        hotels.sort {
            $0.suites_availability.components(separatedBy: ":").count > $1.suites_availability.components(separatedBy: ":").count
        }
        
        
        self.updateViewData?(.success(hotels))
    }
    
    
    func startFetching() {
        updateViewData?(.loading)
        provider.request(.getHotels) { (result) in
            switch result{
            case .success(let response):
                do {
                    let hotelResponse = try JSONDecoder().decode([Hotels.MainData].self, from: response.data)
                    self.updateViewData?(.success(hotelResponse))
                    self.hotels = hotelResponse
                } catch let error {
                    print(error)
                    self.updateViewData?(.failure(error))
                }
            case .failure(let error):
                print("Request Error message: \(error.localizedDescription)")
                self.updateViewData?(.failure(error))
            }
        }
    }
    
    
}

