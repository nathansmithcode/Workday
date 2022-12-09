//
//  NasaImageTableViewCell.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import UIKit

class NasaImageTableViewCell: UITableViewCell {

    @IBOutlet weak var nasaImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var date: UILabel!
    var nasaId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nasaImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(item: NasaData.Item) {

        if let item = item.data.first {
            title.text = item.title
            info.text = item.description
            date.text = item.date_created.formattedDate()
            nasaId = item.nasa_id
        }
        
        if let imageUrl = item.links.first?.href, let url = URL(string: imageUrl) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data),
                   let nasaId = item.data.first?.nasa_id,
                   nasaId == self?.nasaId {
                    DispatchQueue.main.async {
                        self?.nasaImageView.image = image
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        title.text = ""
        info.text = ""
        date.text = ""
        nasaImageView?.image = nil
    }
}
