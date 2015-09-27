//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Alp Eren Can on 21/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

private let reuseIdentifier = "sentMemeCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        get {
            return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 5.0
        let cellWidth = (view.frame.size.width - (4 * space)) / 3.0
        let cellHeight = (view.frame.size.height - (4 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space;
        flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SentMemeCollectionViewCell
    
        // Configure the cell
        cell.meme = memes[indexPath.row];
    
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destinationViewController as! MemeDetailViewController
            let selectedCell = sender as! SentMemeCollectionViewCell
            detailVC.meme = selectedCell.meme
        }
    }

}
