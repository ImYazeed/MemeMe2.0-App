//
//  MemeTableViewCell.swift
//  MemeMe2.0-App
//
//  Created by Yazeed ALZahrani on 1/28/19.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(meme: Meme) {
        memeImage.image = meme.memedImage
        memeText.text = "\(meme.topText)...\(meme.bottomText)"
    }

}
