//
//  LocationSearchViewController.swift
//  weatherDemo
//
//  Created by Andre Creighton on 1/29/21.
//

import UIKit
import MapKit


class LocationSearchViewController: UIViewController, UISearchTextFieldDelegate  {
  
  @IBOutlet weak var locationSearchBar: UISearchBar!
  @IBOutlet weak var locationTableView: UITableView!
  
  var searchCompleter = MKLocalSearchCompleter()
  var searchResults = [MKLocalSearchCompletion]()
  
  var delegate: LocationSearchDelegate? = nil
  
  var city = ""
  var state = ""
  var country = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    searchCompleter.delegate = self
    locationSearchBar.delegate = self
    locationSearchBar.searchTextField.delegate = self
    locationTableView.delegate = self
    locationTableView.dataSource = self
    locationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    locationSearchBar.searchTextField.becomeFirstResponder()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC = segue.destination as! MainWeatherViewController
    destVC.city = city
    destVC.state = state
    destVC.country = country
    
  }
}

extension LocationSearchViewController : UISearchBarDelegate, MKLocalSearchCompleterDelegate {
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    dismiss(animated: true, completion: nil)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchCompleter.queryFragment = searchText
  }
  
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    
    searchResults = completer.results
    locationTableView.reloadData()
  }
  
  
}
extension LocationSearchViewController : UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = locationTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = searchResults[indexPath.row].title
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let result = searchResults[indexPath.row]
    let searchRequest = MKLocalSearch.Request(completion: result)
    
    let search = MKLocalSearch(request: searchRequest)
    search.start { [weak self](response, error) in
      
      guard let postalAdd = response?.mapItems[0].placemark else{
        return
      }
      
      let fixedCity = (postalAdd.locality?.components(separatedBy: " "))?.joined()
      
      guard let city = fixedCity, let state = postalAdd.administrativeArea, let country = postalAdd.countryCode else {
        print("Problem here")
        return
      }
      
      self!.delegate?.locationInfo(city, state, country)
      self!.dismiss(animated: true, completion: nil)
    }
    
    
  }
  
}
