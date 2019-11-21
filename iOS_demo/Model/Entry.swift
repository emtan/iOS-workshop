//
//  Entry.swift
//  iOS_demo
//
//  Created by Emily Tan on 11/20/19.
//  Copyright © 2019 Emily Tan. All rights reserved.
//

import Foundation
import UIKit

struct Entry {
    
    //instantiate properties of an Entry
    let title: String!
    let message: String!
    
    //initialize an Entry
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
