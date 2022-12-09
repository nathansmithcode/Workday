//
//  NasaImageDetailsViewController.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import UIKit

class NasaImageDetailsViewController: UIViewController {
    
    let itemData: NasaData.Item
    
    init(itemData: NasaData.Item) {
        self.itemData = itemData
        super.init(nibName: "NasaImageDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var nasaImageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = itemData.data.first {
            name.text = data.title
            details.text = data.description
            location.text = data.location
            date.text = data.date_created.formattedDate()
        }
        
        if let imageUrl = itemData.links.first?.href, let url = URL(string: imageUrl) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.nasaImageView.image = image
                    }
                }
            }
        }
    }

}
