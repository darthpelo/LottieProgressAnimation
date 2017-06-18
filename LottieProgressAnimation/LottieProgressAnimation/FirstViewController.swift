//
//  FirstViewController.swift
//  LottieProgressAnimation
//
//  Created by Alessio Roberto on 18/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import UIKit
import Lottie

enum AnimationType {
    case Linear
    case EaseIn
    case EaseOut
    case EaseInOut
}

class FirstViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    
    weak var animationView: LOTAnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLottieView()
        
        let progress = ProgressAnimation()
        
        progress.start(from: 0.0,
                       to: Float(5000.0/10000.0),
                       duration: 1.5,
                       animation: .EaseOut) { (progress) in
                        self.update(progress: progress)
        }
        
    }
    
    private func setupLottieView() {
        // MARK : Lottie
        if let _ = self.animationView {
            viewContainer.willRemoveSubview(self.animationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph") else {
            return
        }
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: viewContainer.frame.size.width,
                                     height: viewContainer.frame.size.height)
        self.animationView = animationView
        self.animationView?.contentMode = .scaleAspectFit
        self.animationView?.loopAnimation = false
        viewContainer.addSubview(animationView)
    }
    
    // MARK: - Private
    
    private func update(progress value: Float) {
        animationView?.animationProgress = CGFloat(value)
    }
    
}

class ProgressAnimation {
    private let kCounterRate: Float = 3.0
    
    private var start: Float = 0.0
    private var end: Float = 0.0
    private var timer: Timer?
    private var progress: TimeInterval!
    private var lastUpdate: TimeInterval!
    private var duration: TimeInterval!
    private var animationType: AnimationType = .EaseInOut
    private var currentValue: Float {
        if (progress >= duration) {
            return end
        }
        let percent = Float(progress / duration)
        return (start + (update(counter: percent) * (end - start)))
    }
    
    private var updateCallback: ((Float) -> Void)?
    
    func start(from: Float,
               to: Float,
               duration: TimeInterval,
               animation type: AnimationType,
               update: ((Float) -> Void)?) {
        progress = 0.0
        self.duration = duration
        lastUpdate = Date.timeIntervalSinceReferenceDate
        start = from
        end = to
        
        self.updateCallback = update
        
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(updateAnimation),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateAnimation() {
        // Update the progress
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        // End when timer is up
        if (progress >= duration) {
            killTimer()
            progress = duration
        }
        
        updateCallback?(currentValue)
    }
    
    private func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func update(counter t: Float) -> Float {
        switch animationType {
        case .Linear:
            return t
        case .EaseIn:
            return powf(t, kCounterRate)
        case .EaseOut:
            return 1.0 - powf((1.0 - t), kCounterRate)
        case .EaseInOut:
            var t = t
            var sign = 1.0;
            let r = Int(kCounterRate)
            if (r % 2 == 0) {
                sign = -1.0
            }
            t *= 2;
            if (t < 1) {
                return 0.5 * powf(t, kCounterRate)
            } else {
                return Float(sign * 0.5) * (powf(t-2, kCounterRate) + Float(sign * 2))
            }
        }
    }
}
