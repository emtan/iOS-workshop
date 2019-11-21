//
//  ComposeViewController.swift
//  iOS_demo
//
//  Created by Emily Tan on 11/20/19.
//  Copyright © 2019 Emily Tan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    // instantiate the entry to be created
    var newEntry: Entry?
    
    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newDraft: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.newEntry = Entry(title: newTitle.text!, message: newDraft.text!)
    }
    
}
