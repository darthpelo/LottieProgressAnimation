//
//  CountingLabel.swift
//  ShareDemo
//
//  Created by Sudeep Agarwal on 12/13/15.
//

import Foundation
import UIKit

public enum AnimationType {
    case linear
    case easeIn
    case easeOut
    case easeInOut
}

public enum CountingType {
    case int
    case float
    case custom
}

final class CountingLabel: UILabel {
    
    let kCounterRate: Float = 3.0
    
    var start: Float = 0.0
    var end: Float = 0.0
    var timer: Timer?
    var progress: TimeInterval = 0.0
    var lastUpdate: TimeInterval = 0.0
    var duration: TimeInterval!
    var countingType: CountingType = .int
    var animationType: AnimationType = .linear
    public var format: String?
    
    var currentValue: Float {
        if progress >= duration {
            return end
        }
        let percent = Float(progress / duration)
        return start + (update(counter: percent) * (end - start))
    }
    
    public func count(fromValue: Float,
                      to toValue: Float,
                      withDuration duration: TimeInterval,
                      andAnimationType aType: AnimationType,
                      andCountingType cType: CountingType) {
        
        // Set values
        self.start = fromValue
        self.end = toValue
        self.duration = duration
        self.countingType = cType
        self.animationType = aType
        self.progress = 0.0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        // Invalidate and nullify timer
        killTimer()
        
        // Handle no animation
        if duration == 0.0 {
            update(text: toValue)
            return
        }
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(CountingLabel.updateValue),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func update(text value: Float) {
        switch countingType {
        case .int:
            self.text = "\(Int(value))"
        case .float:
            self.text = String(format: "%.2f", value)
        case .custom:
            if let format = format {
                self.text = String(format: format, value)
            } else {
                self.text = String(format: "%.2f", value)
            }
        }
    }
    
    func updateValue() {
        
        // Update the progress
        let now = Date.timeIntervalSinceReferenceDate
        progress += (now - lastUpdate)
        lastUpdate = now
        
        // End when timer is up
        if progress >= duration {
            killTimer()
            progress = duration
        }
        
        update(text: currentValue)
        
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func update(counter: Float) -> Float {
        switch animationType {
        case .linear:
            return counter
        case .easeIn:
            return powf(counter, kCounterRate)
        case .easeOut:
            return 1.0 - powf((1.0 - counter), kCounterRate)
        case .easeInOut:
            var t = counter
            var sign = 1.0
            let r = Int(kCounterRate)
            if r % 2 == 0 {
                sign = -1.0
            }
            t *= 2
            if t < 1 {
                return 0.5 * powf(t, kCounterRate)
            } else {
                return Float(sign * 0.5) * (powf(t-2, kCounterRate) + Float(sign * 2))
            }
            
        }
    }
    
}
