//
//  DetailViewController.swift
//  iOS_demo
//
//  Created by Emily Tan on 11/20/19.
//  Copyright © 2019 Emily Tan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // instantiate a specific entry 
    var journalEntry: Entry?
    var indexPathRow: Int?
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var entryMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // load the data passed through the segue from the table view
        entryTitle.text = journalEntry?.title
        entryMessage.text = journalEntry?.message
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
