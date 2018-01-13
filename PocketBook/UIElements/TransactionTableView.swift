//
//  TransactionTableView.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import UIKit


protocol TransactionTableViewDelegate {
    func onTransactionTableViewTap(transaction: Transaction)
}
class TransactionTableView: UITableView {
    // header
    
    var transactionTableViewDelegate: TransactionTableViewDelegate?
    
    var sections = [String: [Transaction]]()
    var orderedSectionNames = [String]()
    
    
    
    var transactions: [Transaction]! {
        didSet {
            
            let mTrans = transactions.sorted(by: {$0.date.compare($1.date) == .orderedDescending})
            // create sections
            // reset
            sections.removeAll()
            orderedSectionNames.removeAll()
            
            for transaction in mTrans {
                addToSection(transaction: transaction)
            }
            self.reloadData()
        }
    }
    func addToSection(transaction: Transaction) {
        let key = transaction.date.stringToDisplay
        if let _ = sections[key] {
            // exist
            sections[key]!.append(transaction)
        } else {
            orderedSectionNames.append(key)
            sections[key] = [transaction]
        }
    }
    
    //var myOrderTableViewDelegate: MyOrderTableViewDelegate?
    
    let cellName = "TransactionCell"
    let sectionHeaderName = "TransactionSectionHeader"
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupTable()
    }
    
    func setupTable() {
        
        self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        self.register(UINib(nibName: sectionHeaderName, bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderName)
        // to remove the gap at top of a grouped style tableview
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.tableHeaderView = UIView(frame: frame)
        //
        self.separatorStyle = .singleLine
        self.tableFooterView  = UIView(frame: frame)       //  to remove empty cells
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setupTable()
        
    }
    
}
extension TransactionTableView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderedSectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = orderedSectionNames[section]
        if let transactions = sections[key] {
            return transactions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        
        let cell = self.dequeueReusableCell(withIdentifier: cellName) as! TransactionCell
        let key = orderedSectionNames[section]
        
        cell.set(transaction: sections[key]![row], isFirst: row==0)
        //cell.selectionStyle = .none
        // full lenth separator
        cell.preservesSuperviewLayoutMargins = true
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.sectionHeaderName) as! TransactionSectionHeader
        header.set(date: orderedSectionNames[section])
        return header
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let del = self.transactionTableViewDelegate {
            let section = orderedSectionNames[indexPath.section]
            let transaction = sections[section]![indexPath.row]
            del.onTransactionTableViewTap(transaction: transaction)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}



