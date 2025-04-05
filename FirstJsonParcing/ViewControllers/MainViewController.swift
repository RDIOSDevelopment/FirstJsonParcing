//
//  MainViewController.swift
//  FirstJsonParcing
//
//  Created by Roman Dubovskoi on 4/4/25.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    var countries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    
    func fetchData() {
        guard let url = URL(string: "https://api-hockey.p.rapidapi.com/countries/") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("api-hockey.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue("3d271f0d5bmsh8a3f53dd082962bp17bca3jsne4b67507e440", forHTTPHeaderField: "x-rapidapi-key")
    
        
        URLSession.shared.dataTask(with: request) { [weak self ] data, response, error in
            guard let self else { return }
            guard let data = data else {
                print(error?.localizedDescription ?? "No Error Description")
                return
            }
            
            do {
                let decodedCountries = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.countries = decodedCountries.response
                    self.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
 


// MARK: - ICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(countries.count)
        return countries.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "country", for: indexPath)
        let country = countries[indexPath.item]
        guard let cell = cell as? CountryCell else { return UICollectionViewCell() }
        cell.countryLabel.text = country.name
        
        return cell
    }

    
    

}

// MARK: - UICollectionViewDelegateFlowLayou

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (UIScreen.main.bounds.width - 20 * 2 - 10 * 2) / 3, height: 100)
    }
}
