//
//  EventCell.swift
//  Digital14
//
//  Created by Narendra Goojer on 21/10/21.
//

import UIKit
import SDWebImage

class EventCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!{
        didSet {
            imgLogo.clipsToBounds = true;
            imgLogo.layer.masksToBounds = true;
            imgLogo.layer.cornerRadius = 5.0;
        }
    }

    static let placeholder = UIImage(named: "huge.png")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgLogo.image = nil
    }
    
    func loadCell(cellVM: CellViewModel) {
        self.lblTitle.text = cellVM.eventTitle
        self.lblTime.text = cellVM.timeString
        self.lblLocation.text = cellVM.displayLocation
        
        let imageFav = cellVM.isFavourite ? Constants.imegeFavFilled : Constants.imegeFav
        self.imgFav.image = imageFav
        
        guard let image = cellVM.imageURL, let url = URL(string:image) else {
            self.imgLogo?.image = EventCell.placeholder
            return
        }
        self.imgLogo?.sd_setImage(with:url, placeholderImage: EventCell.placeholder, options: [], context: nil)
    }
    
}
