//
//  IAPService.swift
//  CoolSchool
//
//  Created by Syed Askari on 10/22/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    private override init() {}
    static let shared = IAPService()
    
    var products = [SKProduct]()
    var paymentQueue = SKPaymentQueue.default()
    
    func getProduct() {
        let products = Set([
                IAPProduct.nonConsumableV1.rawValue,
                IAPProduct.nonConsumableV2.rawValue,
            ])
        let request: SKProductsRequest = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue}).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
    func restorePurchases() {
        paymentQueue.restoreCompletedTransactions()
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products {
            print (product.localizedTitle)
        }
    }
}

extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print (transaction.transactionState.status(), transaction.payment.productIdentifier)
            
            if transaction.transactionState.status() == "purchased" || transaction.transactionState.status() == "restored"{
                UserDefaults.standard.set(true, forKey: transaction.payment.productIdentifier)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
            }
            
            switch transaction.transactionState {
                case .purchasing: break
                default: queue.finishTransaction(transaction)
             }
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String{
        switch self {
            case .deferred:
                return ("deffered")
            case .failed:
                return ("failed")
            case .purchased:
                return ("purchased")
            case .purchasing:
                return ("purchasing")
            case .restored:
                return ("restored")
        }
    }
}
