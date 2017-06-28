
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
    @IBOutlet weak var valueBigLabel: CountingLabel!
    @IBOutlet weak var valueSmallLabel: CountingLabel!
    
    weak var bigAnimationView: LOTAnimationView?
    weak var checkSmallAnimationView: LOTAnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBigLottieView()
        setupCheckSmallLottieView()
        
        let progressBig = ProgressAnimation()
        
        valueBigLabel.count(fromValue: 0, to: 2678, withDuration: 1.5, andAnimationType: .easeOut, andCountingType: .int)
        progressBig.start(from: 0.0,
                          to: Float(2678.0/10000.0),
                          duration: 1.5,
                          animation: .easeOut) { (progress) in
                            self.updateBig(progress: progress)
        }
        valueSmallLabel.count(fromValue: 0, to: 6000, withDuration: 1.0, andAnimationType: .easeOut, andCountingType: .int)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.checkSmallAnimationView?.play()
        }
        
    }
    
    private func setupBigLottieView() {
        // MARK : Lottie
        if bigAnimationView == nil {
            bigAnimationView = LottieView.addAnimation(withName: "circular_graph", to: bigViewContainer)
            bigViewContainer.bringSubview(toFront: valueBigLabel)
        }
    }
    
    private func setupCheckSmallLottieView() {
        // MARK : Lottie
        if checkSmallAnimationView == nil {
            checkSmallAnimationView = LottieView.addAnimation(withName: "circular_graph_with_check", to: smallViewContainer)
            smallViewContainer.sendSubview(toBack: valueSmallLabel)
        } else {
            checkSmallAnimationView?.animationProgress = 0.0
        }
    }
    
    // MARK: - Private
    
    private func updateBig(progress value: Float) {
        bigAnimationView?.animationProgress = CGFloat(value)
    }
}

