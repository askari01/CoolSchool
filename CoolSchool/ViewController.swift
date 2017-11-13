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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideosCVCell
        let videoData = [("First Video", "8ueYlFT0G0c/0"), ("Second Video","kQkzHhFC0cc/0"), ("Third Video", "DEVVdu2jSlo/0"), ("First Video", "8ueYlFT0G0c/0"), ("Second Video","kQkzHhFC0cc/0"), ("Third Video", "DEVVdu2jSlo/0")]
        let (name, token) = videoData[indexPath.row]
        print ("http://img.youtube.com/vi/\(token).jpg")
        let imageURL = URL(string: "http://img.youtube.com/vi/\(token).jpg")
        let imageData = NSData(contentsOf: imageURL! as URL)
        if imageData != nil {
            cell.image.image = UIImage(data: imageData! as Data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath.row)
    }

    @IBAction func buyAction(_ sender: UIButton) {
        IAPService.shared.purchase(product: .consumableTest2)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        IAPService.shared.restorePurchases()
    }
}

