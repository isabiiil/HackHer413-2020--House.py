//
//  SubscribeViewController.swift
//  LehmanHacks2019
//
//  Created by Sabri Sönmez on 11/16/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit
import Lottie


class SubscribeViewController: UIViewController {

    @IBOutlet weak var animationView: LOTAnimatedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        playAnimation(animationName: "2497-trophy")
        // Do any additional setup after loading the view.
    }
    
    func playAnimation(animationName: String)
    {
        animationView.animationView.setAnimation(named: "\(animationName)")
        animationView.animationView.loopAnimation = true
        animationView.animationView.play()
    }
    

}
