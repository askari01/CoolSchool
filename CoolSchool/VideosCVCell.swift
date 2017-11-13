//
//  VideosCVCell.swift
//  CoolSchool
//
//  Created by Syed Askari on 11/13/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import Kingfisher

class VideosCVCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setValues(picture1: URL ) {
        self.image.kf.indicatorType = .activity
        self.image.kf.setImage(with: picture1)
    }
    
}
