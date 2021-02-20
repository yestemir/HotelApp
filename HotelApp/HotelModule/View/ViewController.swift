//
//  ViewController.swift
//  HotelApp
//
//  Created by Dina Yestemir on 20.02.2021.
//

import UIKit

import UIKit

class HotelsViewController: UIViewController {
    
    var tableView = UITableView()
    var data = [HotelModel]()
    var hotelsViewModel = HotelViewModel()
    let child = SpinnerViewController()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        hotelsViewModel.fetchHotels{ [weak self] hotel in
            DispatchQueue.main.async {
                switch hotel {
                case .success(_):
                    self!.child.willMove(toParent: nil)
                    self!.child.view.removeFromSuperview()
                    self!.child.removeFromParent()
                case .failure(let error):
                    self!.child.willMove(toParent: nil)
                    self!.child.view.removeFromSuperview()
                    self!.child.removeFromParent()
                    
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self!.present(alert, animated: true, completion: nil)
                }
                self?.updateUI()
            }
        }
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

extension HotelsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelsViewModel.hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = hotelsViewModel.hotels[indexPath.row]
        cell.textLabel?.text = cellData.name
        
        return cell
    }
}

extension HotelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        let url = "https://github.com/iMofas/ios-android-test/raw/master/\(indexPath.row+1).jpg"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            guard let safedata = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                detailVC.hotelImage.image = UIImage(data: safedata)
                detailVC.hotelName.text = self.hotelsViewModel.hotels[indexPath.row].name
            }
            
        }
        
        task.resume()
    }
}


