//
//  DetailViewModel.swift
//  HotelApp
//
//  Created by Dina Yestemir on 21.02.2021.
//

import Foundation
import Moya
import UIKit

protocol DetailViewModelProtocol {
    var updateViewData: ((HotelDetail)->())? { get set }
    func startFetching(hotelID: Int)
}

final class DetailsViewModel: DetailViewModelProtocol{
    var updateViewData: ((HotelDetail) -> ())?
    let provider = MoyaProvider<APIService>()
    
    init() {
        updateViewData?(.initial)
    }
    
    func startFetching(hotelID: Int) {
        updateViewData?(.loading)
        provider.request(.getHotelDetails(hotelID: hotelID)) { (result) in
            switch result{
            case .success(let response):
                do {
                    let hotelResponse = try JSONDecoder().decode(HotelDetail.MainData.self, from: response.data)
                    guard let image = hotelResponse.image else {
                        self.updateViewData?(.success(hotelResponse))
                        return
                    }
                    self.fetchingImage(imageName: image, hotelResponse: hotelResponse)
                } catch let error {
                    print("Error in parsing: \(error)")
                    self.updateViewData?(.failure(error))
                }
            case .failure(let error):
                print("Request Error message: \(error.localizedDescription)")
                self.updateViewData?(.failure(error))
            }
        }
    }
    
    func fetchingImage(imageName: String, hotelResponse: HotelDetail.MainData) {
        provider.request(.getHotelImage(imageName: imageName)) { (result) in
            print(result)
            switch result{
            case .success(let response):
                do {
                    let image = UIImage(data: response.data) ?? UIImage(named: "image")
                    self.updateViewData?(.updateImage(image!, hotelResponse))
                    
                }
            case .failure(let error):
                print("Request Error message: \(error.localizedDescription)")
                self.updateViewData?(.failure(error))
            }
        }
    }
    
}
