//
//  SecondViewController.swift
//  LottieProgressAnimation
//
//  Created by Alessio Roberto on 18/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit
import Lottie

class SecondViewController: UIViewController {

    @IBOutlet weak var bigViewContainer: UIView!
    @IBOutlet weak var smallViewContainer: UIView!
    
    weak var bigAnimationView: LOTAnimationView?
    weak var smallAnimationView: LOTAnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBigLottieView()
        setupSmallLottieView()
        
        bigAnimationView?.play()
        smallAnimationView?.play()
    }
    
    private func setupBigLottieView() {
        // MARK : Lottie
        if let _ = self.bigAnimationView {
            bigViewContainer.willRemoveSubview(self.bigAnimationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph_big") else {
            return
        }
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: bigViewContainer.frame.size.width,
                                     height:bigViewContainer.frame.size.height)
        self.bigAnimationView = animationView
        self.bigAnimationView?.contentMode = .scaleAspectFit
        self.bigAnimationView?.loopAnimation = false
        bigViewContainer.addSubview(animationView)
    }
    
    private func setupSmallLottieView() {
        // MARK : Lottie
        if let _ = self.smallAnimationView {
            smallViewContainer.willRemoveSubview(self.smallAnimationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph_small") else {
            return
        }
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: smallViewContainer.frame.size.width,
                                     height:smallViewContainer.frame.size.height)
        self.smallAnimationView = animationView
        self.smallAnimationView?.contentMode = .scaleAspectFit
        self.smallAnimationView?.loopAnimation = false
        smallViewContainer.addSubview(animationView)
    }

}

