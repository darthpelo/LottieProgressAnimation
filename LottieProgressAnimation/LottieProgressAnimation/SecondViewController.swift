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
    weak var checkSmallAnimationView: LOTAnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBigLottieView()
        setupSmallLottieView()
        setupCheckSmallLottieView()
        
        let progressBig = ProgressAnimation()
        let progressSmall = ProgressAnimation()
        
        progressBig.start(from: 0.0,
                          to: Float(2678.0/10000.0),
                          duration: 1.5,
                          animation: .EaseOut) { (progress) in
                            self.updateBig(progress: progress)
        }
        
        progressSmall.start(from: 0.0,
                            to: Float(6000.0/8000.0),
                            duration: 1.5,
                            animation: .EaseOut) { (progress) in
                                self.updateSmall(progress: progress)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.smallAnimationView?.isHidden = true
            self.checkSmallAnimationView?.isHidden = false
            self.checkSmallAnimationView?.play()
        }

    }
    
    private func setupBigLottieView() {
        // MARK : Lottie
        if let _ = self.bigAnimationView {
            bigViewContainer.willRemoveSubview(self.bigAnimationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph") else {
            return
        }
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: bigViewContainer.frame.size.width,
                                     height:bigViewContainer.frame.size.height)
        self.bigAnimationView = animationView
        self.bigAnimationView?.contentMode = .scaleAspectFit
        self.bigAnimationView?.loopAnimation = false
        if let anim = bigAnimationView {
            bigViewContainer.addSubview(anim)
        }
        
    }
    
    private func setupSmallLottieView() {
        // MARK : Lottie
        if let _ = self.smallAnimationView {
            smallViewContainer.willRemoveSubview(self.smallAnimationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph") else {
            return
        }
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: smallViewContainer.frame.size.width,
                                     height:smallViewContainer.frame.size.height)
        self.smallAnimationView = animationView
        self.smallAnimationView?.contentMode = .scaleAspectFit
        self.smallAnimationView?.loopAnimation = false
        if let anim = smallAnimationView {
            smallViewContainer.addSubview(anim)
        }
    }
    
    private func setupCheckSmallLottieView() {
        // MARK : Lottie
        if let _ = self.checkSmallAnimationView {
            smallViewContainer.willRemoveSubview(self.checkSmallAnimationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph_with_check") else {
            return
        }
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: smallViewContainer.frame.size.width,
                                     height:smallViewContainer.frame.size.height)
        self.checkSmallAnimationView = animationView
        self.checkSmallAnimationView?.contentMode = .scaleAspectFit
        self.checkSmallAnimationView?.loopAnimation = false
        self.checkSmallAnimationView?.isHidden = true
        if let anim = checkSmallAnimationView {
            smallViewContainer.addSubview(anim)
        }
    }
    
    // MARK: - Private
    
    private func updateBig(progress value: Float) {
        bigAnimationView?.animationProgress = CGFloat(value)
    }
    
    private func updateSmall(progress value: Float) {
        smallAnimationView?.animationProgress = CGFloat(value)
    }
    
}

