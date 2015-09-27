//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Alp Eren Can on 21/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        get {
            return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentMemeCell", forIndexPath: indexPath) as! SentMemeTableViewCell

        cell.meme = memes[indexPath.row]

        return cell
    }
        
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destinationViewController as! MemeDetailViewController
            let selectedCell = sender as! SentMemeTableViewCell
            detailVC.meme = selectedCell.meme
            detailVC.memeIndex = tableView.indexPathForCell(selectedCell)?.row
        }
    }
}
