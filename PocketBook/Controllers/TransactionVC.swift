//
//  TransactionVC.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import UIKit

class TransactionVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var closePanel: UIView!
    @IBOutlet weak var transactionImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var mainCategoryLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var paymentTypeImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    var transaction: Transaction?
    
    let mainViewRadius = CGFloat(10)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TransactionVC.onClose))
        closePanel.isUserInteractionEnabled = true
        closePanel.addGestureRecognizer(tap)
        
             
        showTransaction()
    }
    override func viewDidAppear(_ animated: Bool) {
        let catRadius = mainCategoryLabel.bounds.height / 2
        
        mainCategoryLabel.layer.borderColor = UIColor.lightGray.cgColor
        mainCategoryLabel.layer.cornerRadius = catRadius
        mainCategoryLabel.layer.borderWidth = 1
        mainCategoryLabel.textColor = Constants.PBBlueColor
        
        subCategoryLabel.layer.borderColor = UIColor.lightGray.cgColor
        subCategoryLabel.layer.cornerRadius = catRadius
        subCategoryLabel.layer.borderWidth = 1
        
        
        
        mainView.layer.cornerRadius = mainViewRadius
        mainView.layer.borderColor = UIColor.white.cgColor
        mainView.layer.borderWidth = 0.5
        
        //
        let path = UIBezierPath(roundedRect:topView.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: mainViewRadius, height:  mainViewRadius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        topView.layer.mask = maskLayer
    }
    
    
    func showTransaction() {
        if let transaction = self.transaction {
            amountLabel.text = transaction.amount.asMoney
            dateLabel.text = transaction.date.day + " " + transaction.date.shortMonth
            mainCategoryLabel.text = transaction.mainCategory
            subCategoryLabel.text = transaction.subCategory
            
            
            nameLabel.text = transaction.name
            paymentTypeLabel.text = transaction.paymentType
            
        }
    }
    
    @objc           // swift 4
    func onClose() {
        dismiss(animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
