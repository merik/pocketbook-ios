//
//  RecentTransactionVC.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import UIKit
import SnapKit

class RecentTransactionVC: UIViewController {

    var transactionTableView: TransactionTableView!
    var tabBar: UITabBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        //transactionsTableView.transactionTableViewDelegate = self
        fetchTransactions()
    }

    func setupUI() {
        // navigation bar
        let navbar = UIView()
        self.view.addSubview(navbar)
        
        navbar.snp.makeConstraints{ (make) -> Void in
            
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            
            if #available(iOS 11, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
                make.height.equalTo(44)
            } else {
                make.height.equalTo(60)
                make.top.equalTo(self.view.snp.top)
            }
            
            
            
        }
        // TODO: Add back to a bigger uiview and handle tap event on this view for it to be easier to tap
        let back = UIImageView()
        
        navbar.addSubview(back)
        back.image = UIImage(named: "back")
        back.contentMode = .scaleAspectFit
        back.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(28)
            make.left.equalTo(navbar.snp.left).offset(8)
            make.width.equalTo(28)
            make.bottom.equalTo(navbar.snp.bottom).offset(-8)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RecentTransactionVC.backTapped))
        back.isUserInteractionEnabled = true
        back.addGestureRecognizer(tap)
        
        
        let plus = UIImageView()
        plus.contentMode = .scaleAspectFit
        navbar.addSubview(plus)
        plus.image = UIImage(named: "plus")
        plus.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(28)
            make.right.equalTo(navbar.snp.right).offset(-8)
            make.width.equalTo(28)
            make.bottom.equalTo(navbar.snp.bottom).offset(-8)
        }
        
        let titleLabel = UILabel()
        navbar.addSubview(titleLabel)
        titleLabel.text = "Recent Transactions"
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints{ (make) -> Void in
            
            make.height.equalTo(21)
            make.bottom.equalTo(navbar.snp.bottom).offset(-8)
            make.left.equalTo(back.snp.right).offset(5)
            make.right.equalTo(plus.snp.left).offset(-5)
        }
        
        // tab bar
        tabBar = UITabBar()
        
        let trackItem = UITabBarItem(title: "Track", image: UIImage(named: "track"), selectedImage: UIImage(named: "track"))
        let spendItem = UITabBarItem(title: "Safely Spend", image: UIImage(named: "safely_spend"), selectedImage: UIImage(named: "safely_spend"))
        let notificationItem = UITabBarItem(title: "Notifications", image: UIImage(named: "notifications"), selectedImage: UIImage(named: "notifications"))
        let settingsItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settings"))
       
        tabBar.items = [trackItem, spendItem, notificationItem, settingsItem]
        
        self.view.addSubview(tabBar)
        tabBar.selectedItem = trackItem
        
        tabBar.snp.makeConstraints{ (make) -> Void in

            make.bottom.equalTo(self.view.snp.bottom)
            //do not set height to support iphoneX
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        UITabBar.appearance().tintColor = Constants.PBBlueColor
        
        // table
        transactionTableView = TransactionTableView(frame: self.view.bounds)
        self.view.addSubview(transactionTableView)
        transactionTableView.transactionTableViewDelegate = self
        transactionTableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(navbar.snp.bottom)
            make.bottom.equalTo(tabBar.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.invalidateIntrinsicContentSize()
    }
    
    
    
    @objc
    func backTapped() {
        dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchTransactions() {
        PBService.shared.fetchRecentTransactions(userId: 1).then { (transactions) -> Void in
            self.transactionTableView.transactions = transactions
            }.catch { error in
                // just ignore for now. With current test data, it should never reach here
        }
    }
    

    

}
extension RecentTransactionVC: TransactionTableViewDelegate {
    
    func showDetails(transaction: Transaction) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as! TransactionVC
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve

        vc.transaction = transaction

        self.present(vc, animated: true, completion: nil)
        
       
    }
    
    func onTransactionTableViewTap(transaction: Transaction) {
        showDetails(transaction: transaction)
    }
}
