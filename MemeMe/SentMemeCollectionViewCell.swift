//
//  SentMemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Alp Eren Can on 26/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class SentMemeCollectionViewCell: UICollectionViewCell {
    
    var meme: Meme? {
        didSet {
            self.setup()
        }
    }
    
    @IBOutlet weak var memeImageView: UIImageView?
    
    func setup() {
        
        if let image = meme?.memedImage {
                memeImageView?.image = image
        }
        
    }
    
    override func awakeFromNib() {
        setup()
    }

}
