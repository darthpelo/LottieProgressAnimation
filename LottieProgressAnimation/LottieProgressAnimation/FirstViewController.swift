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
    
    let kCounterRate: Float = 3.0
    
    var start: Float = 0.0
    var end: Float = 0.0
    var timer: Timer?
    var progress: TimeInterval!
    var lastUpdate: TimeInterval!
    var duration: TimeInterval!
    var animationType: AnimationType = .EaseInOut
    var currentValue: Float {
        if (progress >= duration) {
            return end
        }
        let percent = Float(progress / duration)
        return (start + (update(counter: percent) * (end - start)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLottieView()
        
        progress = 0.0
        duration = 1.5
        lastUpdate = Date.timeIntervalSinceReferenceDate
        end = Float(5000.0/10000.0)
        
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(updateAnimation),
                                     userInfo: nil,
                                     repeats: true)
    }

    private func setupLottieView() {
        // MARK : Lottie
        if let _ = self.animationView {
            viewContainer.willRemoveSubview(self.animationView!)
        }
        guard let animationView = LOTAnimationView(name: "circular_graph_big") else {
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
    func updateAnimation() {
        // Update the progress
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        // End when timer is up
        if (progress >= duration) {
            killTimer()
            progress = duration
        }
        
        update(progress: currentValue)
    }
    
    func update(progress value: Float) {
        if value <= 0.5 {
            self.animationView?.animationProgress = CGFloat(value)
        } else {
            self.animationView?.animationProgress = 1
        }
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func update(counter t: Float) -> Float {
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
