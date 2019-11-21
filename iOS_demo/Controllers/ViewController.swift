//
//  ViewController.swift
//  iOS_demo
//
//  Created by Emily Tan on 11/19/19.
//  Copyright © 2019 Emily Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of entries in journal
        return EntryDatabase.journal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create the cell at each respective row
        let entryCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        // configure the cell
        entryCell.titleLabel.text = EntryDatabase.journal[indexPath.row].title
        
        return entryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // display journal entry of entry selected out of table
        // find the Entry selected
        let entrySelected = EntryDatabase.journal[indexPath.row]
        performSegue(withIdentifier: "ToDetailSegue", sender: entrySelected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // upload the Entry in preparation for the segue
        if (segue.identifier == "ToDetailSegue") {
            if let senderEntry = sender as? Entry {
                let viewC = segue.destination as! DetailViewController
                viewC.journalEntry = senderEntry
            }
        }
    }
    
    @IBAction func saveDraft(segue: UIStoryboardSegue) {
        // add a new Entry
        if let composeEntryViewControllerInstance = segue.source as? ComposeViewController {
            if let entry = composeEntryViewControllerInstance.newEntry {
                
                // update the model
                EntryDatabase.addEntry(e: entry)
                
                // insert into our table view
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    @IBAction func cancelDraft(segue: UIStoryboardSegue) {
        // nothing happens we just unwind
    }
    
}

