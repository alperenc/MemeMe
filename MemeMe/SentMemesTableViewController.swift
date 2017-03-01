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
            return (UIApplication.shared.delegate as! AppDelegate).memes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentMemeCell", for: indexPath) as! SentMemeTableViewCell

        cell.meme = memes[indexPath.row]

        return cell
    }
        
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! MemeDetailViewController
            let selectedCell = sender as! SentMemeTableViewCell
            detailVC.meme = selectedCell.meme
            detailVC.memeIndex = tableView.indexPath(for: selectedCell)?.row
        }
    }
}
