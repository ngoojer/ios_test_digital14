//
//  DetailViewController.swift
//  Digital14
//
//  Created by Narendra Goojer on 22/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnFavorite: UIBarButtonItem!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgLog: UIImageView! {
        didSet{
            imgLog.layer.cornerRadius = 10
            imgLog.layer.masksToBounds = true
        }
    }
    static var identifier: String {
        return String(describing: self)
    }
    var viewModel: CellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func actionFavourite(_ sender: Any) {
        guard let viewModel = viewModel else { return }

        if viewModel.isFavourite {
            viewModel.isFavourite = false
            self.btnFavorite.image = Constants.imegeFav
        }
        else{
            viewModel.isFavourite = true
            self.btnFavorite.image = Constants.imegeFavFilled
        }
    }
    
    private func setupView()  {
        guard let viewModel = viewModel else { return }
        self.title = viewModel.eventTitle
        self.lblTime.text = viewModel.timeString
        self.lblLocation.text = viewModel.displayLocation
        
        let imageFav = viewModel.isFavourite ? Constants.imegeFavFilled : Constants.imegeFav
        self.btnFavorite.image = imageFav
        guard let image = viewModel.imageURL, let url = URL(string:image) else {
            self.imgLog?.image = EventCell.placeholder
            return
        }
        self.imgLog?.sd_setImage(with:url, placeholderImage: EventCell.placeholder, options: [], context: nil)
    }
}
