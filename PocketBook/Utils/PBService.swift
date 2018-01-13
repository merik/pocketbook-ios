//
//  PBService.swift
//  PocketBook
//
//  Created by Chi on 12/1/18.
//  Copyright © 2018 dmc. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class PBService {
    static let shared = PBService()
    
    
    
    func fetchRecentTransactions(userId: Int) -> Promise<[Transaction]> {
        return Promise { fulfill, reject in
            // NOTE: should fetch from backend like below
            // Alamofire.request(stEndpoint, method: .get, parameters: params, encoding: URLEncoding.default)
            //.responseJSON { response in
            //
            // but for now, read data from transactions.json in the bundle
            if let filepath = Bundle.main.path(forResource: "transactions", ofType: "json") {
                do {
                    var transactions = [Transaction]()
                    let contents = try String(contentsOfFile: filepath)
                    print(contents)
                    if let json = contents.jsonStringToDictionary {
                        if let trans = json["transactions"] as? [[String: Any]] {
                            for transactionJson in trans {
                                let transaction = Transaction(json: transactionJson)
                                transactions.append(transaction)
                            }
                            fulfill(transactions)
                        }
                    }
                } catch {
                    // contents could not be loaded
                    reject(NSError())     // TODO: Implement Error handling, for now just return an general error
                }
            } else {
                reject(NSError()) // TODO: Implement Error handling
            }
            
        }
    }
}
