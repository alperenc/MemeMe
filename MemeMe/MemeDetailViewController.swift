//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Alp Eren Can on 27/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme?
    var memeIndex: Int?
    var editButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = meme?.memedImage
        
        editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editMeme")
        navigationItem.rightBarButtonItem = editButton
        
    }
    
    func editMeme() {
        let alertController = UIAlertController(title:nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            if let index = self.memeIndex {
                (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(index)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            let memeEditor = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
            memeEditor.meme = self.meme
            self.navigationController?.presentViewController(memeEditor, animated: true, completion: nil)
        }))
        
        if (alertController.respondsToSelector("popoverPresentationController")) {
            alertController.popoverPresentationController?.barButtonItem = editButton
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
