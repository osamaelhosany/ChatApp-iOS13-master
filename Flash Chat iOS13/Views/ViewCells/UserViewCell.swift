//
//  UserViewCell.swift
//  Flash Chat iOS13
//
//  Created by Osama El Hussiny on 4/20/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class UserViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer : UIStackView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var profileImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        viewContainer.layer.cornerRadius =
//        viewContainer.frame.height / 8
    }


}
