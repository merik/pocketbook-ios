//
//  SignInVC.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import UIKit
import SnapKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        // logo
        let logo = UIImageView()
        self.view.addSubview(logo)
        logo.image = UIImage(named: "pocketbook")
        logo.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(100)
            make.width.height.equalTo(100)
            make.centerX.equalTo(self.view)
        }
        
        // prompt
        let prompt = UILabel()
        self.view.addSubview(prompt)
        prompt.text = "Glad to see you back"
        prompt.textAlignment = .center
        prompt.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(280)
            make.top.equalTo(logo.snp.bottom).offset(40)
        }
        
        // dont have an account? sign up
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(260)
            make.height.equalTo(30)
            
            
            if #available(iOS 11, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).offset(-10)
            } else {
                make.bottom.equalTo(self.view.snp.bottom).offset(-10)
            }
            make.centerX.equalTo(self.view)
        }
        
        let dontLabel = UILabel()
        bottomView.addSubview(dontLabel)
        dontLabel.text = "Don't have an account?"
        dontLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(bottomView.snp.top)
            make.bottom.equalTo(bottomView.snp.bottom)
            make.left.equalTo(bottomView.snp.left)
            make.width.equalTo(180)
        }
        let signUpLabel = UILabel()
        bottomView.addSubview(signUpLabel)
        signUpLabel.text = "Sign Up"
        signUpLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        signUpLabel.textColor = Constants.PBBlueColor
        
        signUpLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(bottomView.snp.top)
            make.bottom.equalTo(bottomView.snp.bottom)
            make.left.equalTo(dontLabel.snp.right).offset(5)
            make.right.equalTo(bottomView.snp.right)
        }
        
        // separator
        let separator = UIView()
        self.view.addSubview(separator)
        separator.backgroundColor = UIColor.gray
        separator.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(bottomView.snp.top).offset(-10)
            make.height.equalTo(1)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        // sign in button
        
        let signInButton = UIButton()
        self.view.addSubview(signInButton)
        
        signInButton.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(separator.snp.top).offset(-70)
        }
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.backgroundColor = Constants.PBBlueColor
        signInButton.layer.cornerRadius = 2
        signInButton.titleLabel?.textColor = UIColor.white
        
        signInButton.addTarget(self, action: #selector(SignInVC.signInTapped), for: .touchUpInside)
        
       
    }
    @objc
    func signInTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecentTransactionVC") as! RecentTransactionVC
        self.present(vc, animated: true, completion: nil)
    }

   
    

}
