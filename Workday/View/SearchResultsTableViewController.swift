//
//  SearchResultsTableViewController.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    var imageData = [NasaData.Item]()
    let heightForRow: CGFloat = 120
    let searchTerm: String
    var totalHits = 0
    var pageNumber = 1
    let maxPages = 100
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        tableView?.register(UINib(nibName: "NasaImageTableViewCell", bundle: nil), forCellReuseIdentifier: "NasaImageTableViewCell")
        
        fetchData()
    }
    
    private func fetchData() {
        NetworkService.fetchNasaData(forSearch: searchTerm, pageNumber: String(pageNumber)) { [weak self] nasaData in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let nasaData = nasaData, nasaData.collection.items.count > 0 {
                    self.totalHits = nasaData.collection.metadata.total_hits
                    let items = nasaData.collection.items
                    self.imageData += items
                    self.tableView.reloadData()
                } else {
                    self.showNoDataLabel()
                }
            }
        }
    }
    
    private func showNoDataLabel() {
        let label = UILabel()
        label.textColor = .black
        label.text = "No results available. Please search again."
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self.tableView, attribute: .centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self.tableView, attribute: .centerY, multiplier: 1, constant: -100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Check for last cell to load more data
        if indexPath.row == imageData.count - 1 {
            if pageNumber < maxPages,
               imageData.count < totalHits {
                pageNumber += 1
                fetchData()
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NasaImageTableViewCell", for: indexPath) as? NasaImageTableViewCell,
           indexPath.row < imageData.count {
            let item = imageData[indexPath.row]
            cell.updateCell(item: item)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = NasaImageDetailsViewController(itemData: imageData[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
