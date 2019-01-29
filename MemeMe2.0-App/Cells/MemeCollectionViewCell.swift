//
//  MemeCollectionViewCell.swift
//  MemeMe2.0-App
//
//  Created by Yazeed ALZahrani on 1/29/19.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topTextField: UILabel!
    @IBOutlet weak var bottomTextField: UILabel!
    @IBOutlet weak var memeImage: UIImageView!


    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(meme: Meme) {
        memeImage.image = meme.memedImage
        topTextField.text = meme.topText
        bottomTextField.text = meme.bottomText
    }
}
