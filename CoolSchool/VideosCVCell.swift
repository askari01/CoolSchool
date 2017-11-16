//
//  VideosCVCell.swift
//  CoolSchool
//
//  Created by Syed Askari on 11/13/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import Kingfisher

// For Button Action
protocol CellDelegate : class {
    func didPressButton(_ tag: Int)
}

class VideosCVCell: UICollectionViewCell {
    
    weak var cellDelegate: CellDelegate?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var viualEffect: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.cornerRadius = 5
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        viualEffect.layer.cornerRadius = 15
        viualEffect.clipsToBounds = true
        
    }
    
    @IBAction func buyAction(_ sender: UIButton) {
        cellDelegate?.didPressButton(self.tag)
        viualEffect.isHidden = true
        buyButton.isHidden = true
    }
    
    func setValues(picture1: URL, row: Int ) {
        if row == 0 {
            viualEffect.isHidden = true
            buyButton.isHidden = true
        }
        self.image.kf.indicatorType = .activity
        self.image.kf.setImage(with: picture1)
    }
    
}
