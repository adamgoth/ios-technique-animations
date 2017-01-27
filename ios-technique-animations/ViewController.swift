//
//  ViewController.swift
//  ios-technique-animations
//
//  Created by Adam Goth on 1/26/17.
//  Copyright © 2017 Adam Goth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider  = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let redBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
        redBox.translatesAutoresizingMaskIntoConstraints = false
        redBox.backgroundColor = UIColor.red
        redBox.center.y = view.center.y
        view.addSubview(redBox)
        
        animator = UIViewPropertyAnimator(duration: 20, dampingRatio: 0.5) { [unowned self, redBox] in
            redBox.center.x = self.view.frame.width
        }
        
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        let play = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playTapped))
        let flip = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(reverseTapped))
        navigationItem.rightBarButtonItems = [play, flip]
        
        animator.addCompletion { [unowned self] position in
            if position == .end {
                self.view.backgroundColor = UIColor.green
            } else {
                self.view.backgroundColor = UIColor.black
            }
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(boxTapped))
        redBox.addGestureRecognizer(recognizer)
    
    }
    
    func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    func playTapped() {
        if animator.state == .active {
            animator.stopAnimation(false)
            animator.finishAnimation(at: .end)
        } else {
            animator.startAnimation()
        }
    }

    func reverseTapped() {
        animator.isReversed = true
    }
    
    func boxTapped() {
        print("Box tapped!")
    }
}

