//
//  ViewController.swift
//  CoolSchool
//
//  Created by Syed Askari on 05/10/2017.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        IAPService.shared.getProduct()
        
//        IAPService.shared.purchase(product: .consumable)
//        IAPService.shared.purchase(product: .consumableTest)
//        IAPService.shared.purchase(product: .consumableTest2)
//        IAPService.shared.restorePurchases()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.red
        return cell
    }

    @IBAction func buyAction(_ sender: UIButton) {
        IAPService.shared.purchase(product: .consumableTest2)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        IAPService.shared.restorePurchases()
    }
}

