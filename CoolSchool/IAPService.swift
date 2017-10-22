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
    
    func getProduct() {
        let products: Set = [IAPProduct.consumable.rawValue]
        print ("***************")
        print (products)
        let request: SKProductsRequest = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
    }
    
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print ("***************")
        print (response.products)
        print ("***************")
        for product in response.products {
            print ("***************")
            print (product.localizedTitle)
            print ("***************")
        }
    }
}
