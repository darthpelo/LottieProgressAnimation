//
//  ProgressAnimation.swift
//  LottieProgressAnimation
//
//  Created by Alessio Roberto on 18/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation

class ProgressAnimation {
    private let kCounterRate: Float = 3.0
    
    private var start: Float = 0.0
    private var end: Float = 0.0
    private var timer: Timer?
    private var progress: TimeInterval!
    private var lastUpdate: TimeInterval!
    private var duration: TimeInterval!
    private var animationType: AnimationType = .easeInOut
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
        case .linear:
            return t
        case .easeIn:
            return powf(t, kCounterRate)
        case .easeOut:
            return 1.0 - powf((1.0 - t), kCounterRate)
        case .easeInOut:
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
