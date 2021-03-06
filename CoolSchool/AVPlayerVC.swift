//
//  AVPlayerVC.swift
//  CoolSchool
//
//  Created by Syed Askari on 06/10/2017.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import AVKit

class AVPlayerVC: AVPlayerViewController, AVPlayerViewControllerDelegate {

    var videoURL: URL!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if videoURL == nil {
            videoURL = URL(string: "https://www.youtube.com/watch?v=8ueYlFT0G0c")!
        }
        let player = AVPlayer(url: videoURL!)
        self.player = player
        self.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
