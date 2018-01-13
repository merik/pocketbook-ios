//
//  TransactionCell.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

   
    
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(transaction: Transaction, isFirst: Bool) {
       
        dayLabel.text = transaction.date.day
        monthLabel.text = transaction.date.shortMonth
        nameLabel.text = transaction.name
        if transaction.hasCategory {
            categoryLabel.text = transaction.subCategory
            categoryLabel.textColor = Constants.PBGrayColor
            infoImageViewWidth.constant = 0
            infoImageView.isHidden = true
            
        } else {
            infoImageView.isHidden = false
            infoImageViewWidth.constant = 22
            categoryLabel.text = "Uncategorised"
            categoryLabel.textColor = Constants.PBAmberColor
        }
        amountLabel.text = transaction.amount.asMoney
        if isFirst {
            amountLabel.textColor = Constants.PBGreenColor
        } else {
            amountLabel.textColor = UIColor.black
        }
        
    }
    
}
