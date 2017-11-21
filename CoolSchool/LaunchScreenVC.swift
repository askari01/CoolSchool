//
//  LaunchScreenVC.swift
//  CoolSchool
//
//  Created by Syed Askari on 11/17/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import AVKit

class LaunchScreenVC: UIViewController {
    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadVideo() {
        
        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch _ {
            print ("error")
        }
        
        let path = Bundle.main.path(forResource: "/OpeningVideo", ofType:"mp4")
        print (path)
        let url = URL(fileURLWithPath: path!)
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        self.view.layer.addSublayer(playerLayer)
        
        // adding observable
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(note:)),
                      name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                      object: player?.currentItem)

        
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

    func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        self.performSegue(withIdentifier: "loadApp", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
