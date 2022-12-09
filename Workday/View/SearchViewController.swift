//
//  SearchViewController.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nasaLogo: UIImageView!
    var imageData = [NasaData.Item]()

    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.setTitleColor(.white, for: .normal)
        
        searchButton.backgroundColor = .systemPink
        searchButton.layer.cornerRadius = 8
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        updateButtonState()
        
        UIView.animate(withDuration: 1.0) {
            self.searchBar.alpha = 1.0
            self.searchButton.alpha = 1.0
            self.nasaLogo.alpha = 1.0
        }
    }
    
    @objc private func dismissKeyboard(gesture: UITapGestureRecognizer) {
        searchBar.endEditing(true)
    }
    
    // MARK: Search Button

    @IBAction func searchButtonClicked(_ sender: Any) {
        guard let searchText = searchBar.text else { return }
        let tableViewVC = SearchResultsTableViewController(searchTerm: searchText)
        self.navigationController?.pushViewController(tableViewVC, animated: false)
    }
    
    
    private func updateButtonState() {
        if searchBar.text == "" {
            searchButton.isEnabled = false
            searchButton.backgroundColor = .lightGray

        } else {
            searchButton.isEnabled = true
            searchButton.backgroundColor = .systemPink
        }
    }

    // MARK: Search functionality
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateButtonState()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateButtonState()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonClicked(self)
    }

}
