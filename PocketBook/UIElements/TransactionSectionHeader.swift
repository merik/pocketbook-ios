//
//  TransactionSectionHeader.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import UIKit

class TransactionSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    
    func set(date: String) {
        dateLabel.text = date
    }

}
