//
//  LottiView.swift
//  LottieProgressAnimation
//
//  Created by Alessio Roberto on 28/06/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import Foundation
import UIKit
import Lottie

struct LottieView {
    
    /// Create and add as subView a new LOTAnimationView based on a json file.
    ///
    /// - Parameters:
    ///   - name: The name of the JSON file with the animation
    ///   - view: The view to which to add the animation
    /// - Returns: The instance of the LOTAnimationView
    static func addAnimation(withName name: String, to view: UIView) -> LOTAnimationView? {
        guard let animationView = LOTAnimationView(name: name) else { return nil }
        
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: view.frame.size.width,
                                     height: view.frame.size.height)
        
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = false
        
        view.addSubview(animationView)
        
        return animationView
    }
}
