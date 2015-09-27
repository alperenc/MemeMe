//
//  SentMemeTableViewCell.swift
//  MemeMe
//
//  Created by Alp Eren Can on 21/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {
    
    var meme: Meme? {
        didSet {
            self.setup()
        }
    }

    @IBOutlet weak var memeImageView: UIImageView?
    @IBOutlet weak var memeLabel: UILabel?
    
    func setup() {
        
        if let image = meme?.memedImage,
            let topText = meme?.topText,
            let bottomText = meme?.bottomText {
                memeImageView?.image = image
                memeLabel?.text = "\(topText) \(bottomText)"
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
