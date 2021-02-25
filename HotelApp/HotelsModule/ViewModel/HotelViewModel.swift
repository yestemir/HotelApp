//
//  HotelViewModel.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import Foundation
import Moya
import UIKit

protocol HomeViewModelProtocol {
    var updateImage: ((UIImage, Int)->())? { get set }
    var updateViewData: ((Hotels)->())? { get set }
    func startFetching()
}

final class HomeViewModel: HomeViewModelProtocol{
    var updateViewData: ((Hotels) -> ())?
    var updateImage: ((UIImage, Int) -> ())?
    let provider = MoyaProvider<APIService>()
    
    var hotels = [Hotels.MainData]()
    var images = [UIImage]()
    var unsorted = [Hotels.MainData]()
    
    init() {
        updateViewData?(.initial)
    }
    
    
    func startFetching() {
        updateViewData?(.loading)
        provider.request(.getHotels) { (result) in
            switch result{
            case .success(let response):
                
                do {
                    let hotelResponse = try JSONDecoder().decode([Hotels.MainData].self, from: response.data)
                    
                    self.hotels = hotelResponse
                    self.unsorted = self.hotels
                    for i in 0..<self.hotels.count {
                        self.startFetchingDetail(hotelID: self.hotels[i].id)
                    }
                    self.updateViewData?(.success(hotelResponse))
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
    
    func startFetchingDetail(hotelID: Int) {
        updateViewData?(.loading)
        provider.request(.getHotelDetails(hotelID: hotelID)) { (result) in
            switch result{
            case .success(let response):
                do {
                    let hotelResponse = try JSONDecoder().decode(HotelDetail.MainData.self, from: response.data)
                    guard let image = hotelResponse.image else {
//                        self.updateViewData?(.success(hotelResponse))
                        return
                    }
                    self.fetchingImage(imageName: image)
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
    
    func fetchingImage(imageName: String)
    {
        provider.request(.getHotelImage(imageName: imageName)) { (result) in
            print(result)
            switch result{
            case .success(let response):
                do {
                    self.images.append(UIImage(data: response.data) ?? UIImage(named: "image")!)
                    self.updateViewData?(.updateImage(self.images, self.hotels))
                }
            case .failure(let error):
                print("Request Error message: \(error.localizedDescription)")
                self.updateViewData?(.failure(error))
            }
            
        }
    }
    
    
    func sortbyRooms(){
        hotels.sort {
            $0.suites_availability.components(separatedBy: ":").count > $1.suites_availability.components(separatedBy: ":").count
        }
        self.updateViewData?(.success(hotels))
    }
    
    func unSort(){
        hotels = unsorted
        self.updateViewData?(.success(hotels))
    }
    
    
}

