//
//  FirstViewController.swift
//  LottieProgressAnimation
//
//  Created by Alessio Roberto on 18/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit
import Lottie

class FirstViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var valueLabel: CountingLabel!
    
    weak var animationView: LOTAnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLottieView()
        
        let progress = ProgressAnimation()
        
        valueLabel.count(fromValue: 0.0,
                         to: 5000.0,
                         withDuration: 1.5,
                         andAnimationType: .easeOut,
                         andCountingType: .int)
        
        progress.start(from: 0.0,
                       to: Float(5000.0/10000.0),
                       duration: 1.5,
                       animation: .easeOut) { (progress) in
                        self.update(with: progress)
        }
        
    }
    
    private func setupLottieView() {
        // MARK: Create a new Lottie istance and add to viewContainer
        if animationView == nil {
            animationView = LottieView.addAnimation(withName: "circular_graph", to: viewContainer)
            viewContainer.bringSubview(toFront: valueLabel)
        }
    }
    
    // MARK: - Private
    
    private func update(with value: Float) {
        animationView?.animationProgress = CGFloat(value)
    }
    
}

