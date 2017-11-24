//
//  ViewController.swift
//  CoolSchool
//
//  Created by Syed Askari on 05/10/2017.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CellDelegate {
    
    static let shared = ViewController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let videoData = [("First Video", "YKrwe8i7XNM/0", "YKrwe8i7XNM"),
                     ("Third Video", "lEnQ-nKqkkk/0", "lEnQ-nKqkkk"),
                     ("Second Video","l6Qt7M8uGQQ/0", "l6Qt7M8uGQQ")]
    
    let identifier = ["com.DDH.CoolSchool.video0","com.DDH.CoolSchool.video1","com.DDH.CoolSchool.video2"]
    
    let imageData = ["SW","CC","C"]
    
    private var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadSound()
        UserDefaults.standard.set(true, forKey: "com.DDH.CoolSchool.video0")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reload"), object: nil)

        
        // for reset
//        UserDefaults.standard.set(false, forKey: "com.DDH.CoolSchool.video1")
//        UserDefaults.standard.set(false, forKey: "com.DDH.CoolSchool.video2")
        
        if UserDefaults.standard.value(forKey: "com.DDH.CoolSchool.video1") == nil {
            UserDefaults.standard.set(false, forKey: "com.DDH.CoolSchool.video1")
        }
        if UserDefaults.standard.value(forKey: "com.DDH.CoolSchool.video2") == nil {
            UserDefaults.standard.set(false, forKey: "com.DDH.CoolSchool.video2")
        }
        
        IAPService.shared.getProduct()
        
//        IAPService.shared.purchase(product: .consumable)
//        IAPService.shared.purchase(product: .consumableTest)
//        IAPService.shared.purchase(product: .consumableTest2)
//        IAPService.shared.restorePurchases()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("abc")
        audioPlayer!.stop()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("xyz")
        audioPlayer?.stop()
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
//        let imageURL = URL(string: "http://img.youtube.com/vi/\(token).jpg")
        
        cell.clipsToBounds = true
        cell.image.image = UIImage(named: imageData[indexPath.row])
        
        if UserDefaults.standard.value(forKey: identifier[indexPath.row]) as! Bool == true {
            cell.buyButton.isHidden = true
        }
        
//        cell.setValues(picture1: imageURL!, row: indexPath.row)
        
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
        if tag == 1 {
            IAPService.shared.purchase(product: .nonConsumableV1)
        } else if tag == 2 {
            IAPService.shared.purchase(product: .nonConsumableV2)
        }
    }

    @IBAction func buyAction(_ sender: UIButton) {
        IAPService.shared.purchase(product: .nonConsumableV2)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        IAPService.shared.restorePurchases()
    }
    
    func loadSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
        } catch _ {
            print ("error")
        }
        
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "/Bike_Rides", ofType: "aif")!)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
    
    func reload() {
        self.collectionView.reloadData()
    }
}

