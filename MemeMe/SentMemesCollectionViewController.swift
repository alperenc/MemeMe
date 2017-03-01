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
            return (UIApplication.shared.delegate as! AppDelegate).memes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 5.0
        let cellWidth = (view.frame.size.width - (4 * space)) / 3.0
        let cellHeight = (view.frame.size.height - (4 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space;
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemeCollectionViewCell
    
        // Configure the cell
        cell.meme = memes[indexPath.row];
    
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MemeDetailViewController
            let selectedCell = sender as! SentMemeCollectionViewCell
            detailVC.meme = selectedCell.meme
            detailVC.memeIndex = collectionView?.indexPath(for: selectedCell)?.row
        }
    }

}
