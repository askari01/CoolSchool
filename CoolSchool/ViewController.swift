//
//  ViewController.swift
//  CoolSchool
//
//  Created by Syed Askari on 05/10/2017.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let videoData = [("First Video", "YKrwe8i7XNM/0", "YKrwe8i7XNM"),
                     ("Second Video","l6Qt7M8uGQQ/0", "l6Qt7M8uGQQ"),
                     ("Third Video", "DEVVdu2jSlo/0", "DEVVdu2jSlo")]
    
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideosCVCell
        cell.cellDelegate = self
        cell.tag = indexPath.row
        let (name, token, video) = videoData[indexPath.row]
        print ("http://img.youtube.com/vi/\(token).jpg")
        let imageURL = URL(string: "http://img.youtube.com/vi/\(token).jpg")
        cell.clipsToBounds = true
        cell.setValues(picture1: imageURL!, row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath.row)
        performSegue(withIdentifier: "video", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "video" {
            if let selectedIndexPath = collectionView?.indexPathsForSelectedItems {
                let selectedIndexPathRow = selectedIndexPath.first?.row
                if let vc = segue.destination as? WebVC {
                    let (name, token, video) = videoData[selectedIndexPathRow!]
                    vc.videoURL = URL(string: "https://www.youtube.com/embed/\(video)?rel=0&amp;showinfo=0;autoplay=1&amp")!
                    print (vc.videoURL)
                }
            }
        }
    }
    
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        IAPService.shared.purchase(product: .nonConsumableV1)
    }

    @IBAction func buyAction(_ sender: UIButton) {
        IAPService.shared.purchase(product: .nonConsumableV2)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        IAPService.shared.restorePurchases()
    }
}

