//
//  EntryDatabase.swift
//  iOS_demo
//
//  Created by Emily Tan on 11/20/19.
//  Copyright © 2019 Emily Tan. All rights reserved.
//

import UIKit
import Foundation

class EntryDatabase: NSObject {
    
    //declare journal data structure
    static var journal: [Entry]! = []
    
    //add and delete functions
    static func addEntry(e: Entry) -> () {
        journal.insert(e, at: 0)
    }
    
    static func deleteEntry(row: Int) -> Entry {
        return journal.remove(at: row)
    }

}
