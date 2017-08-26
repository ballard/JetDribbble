//
//  ShotCollectionViewCell.swift
//  JetDribble
//
//  Created by Ivan Lazarev on 26.08.17.
//  Copyright © 2017 Ivan Lazarev. All rights reserved.
//

import UIKit
import SDWebImage

class ShotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: Item! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
        let url = URL(string: item.image!)
        imageView?.sd_setImage(with: url, completed: nil)
        titleLabel?.text = item.title
        let details = item.details?.htmlToString
        let detailsIsEmpty = details?.isEmpty ?? true
        descriptionLabel?.text = detailsIsEmpty ? "no description..." : details
    }
}
