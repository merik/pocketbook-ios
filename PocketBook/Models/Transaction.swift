//
//  Transaction.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import Foundation

class Transaction {
    var date = Date()
    var name = ""
    var amount: Double = 0.0
    var mainCategory = ""
    var subCategory = ""
    var photos = [String]()     // for now
    var paymentType = ""        // for simplicity
    
    init(json: [String:Any]) {
        if let d = json["date"] as? String {    // should not use this in production
            self.date = d.toDate!
        }
        if let name = json["name"] as? String {
            self.name = name
        }
        if let amount = json["amount"] as? Double {
            self.amount = amount
        }
        if let mainCategory = json["main_category"] as? String {
            self.mainCategory = mainCategory
        }
        if let subCategory = json["sub_category"] as? String {
            self.subCategory = subCategory
        }
        if let paymentType = json["payment_type"] as? String {
            self.paymentType = paymentType
        }
        // ignore photos for now
    }
    init() {
        
    }
    
    var hasCategory: Bool {
        return !mainCategory.isEmpty
    }
}
