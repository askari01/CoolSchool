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
                     ("Second Video","kKIj7B1uxeo/0", "kKIj7B1uxeo"),
                     ("Third Video", "DEVVdu2jSlo/0", "DEVVdu2jSlo"),
                     ("First Video", "8ueYlFT0G0c/0", "8ueYlFT0G0c"),
                     ("Second Video","kQkzHhFC0cc/0", "kQkzHhFC0cc"),
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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideosCVCell
        cell.cellDelegate = self
        cell.tag = indexPath.row
        let (name, token, video) = videoData[indexPath.row]
        print ("http://img.youtube.com/vi/\(token).jpg")
        let imageURL = URL(string: "http://img.youtube.com/vi/\(token).jpg")
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
                    vc.videoURL = URL(string: "https://www.youtube.com/embed/\(video)")!
                    print (vc.videoURL)
                }
            }
        }
    }
    
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
        IAPService.shared.purchase(product: .consumableTest)
    }

    @IBAction func buyAction(_ sender: UIButton) {
        IAPService.shared.purchase(product: .consumableTest2)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        IAPService.shared.restorePurchases()
    }
}

