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
        
        editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MemeDetailViewController.editMeme))
        navigationItem.rightBarButtonItem = editButton
        
    }
    
    func editMeme() {
        let alertController = UIAlertController(title:nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: { (UIAlertAction) -> Void in
            if let index = self.memeIndex {
                (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: index)
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            let memeEditor = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
            memeEditor.meme = self.meme
            self.navigationController?.present(memeEditor, animated: true, completion: nil)
        }))
        
        if (alertController.responds(to: #selector(getter: UIViewController.popoverPresentationController))) {
            alertController.popoverPresentationController?.barButtonItem = editButton
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
}
