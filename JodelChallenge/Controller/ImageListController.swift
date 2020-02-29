//
//  ImageListController.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 29.02.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation

class ImageListContoller {
    
    var startingFrame: CGRect?
    
    func performZoom(startImageView: UIImageView) {
        startingFrame = startImageView.convert(startImageView.frame, to: nil)
        
        let bigImage = UIImageView(frame: self.startingFrame!)
        bigImage.image = startImageView.image
        bigImage.isUserInteractionEnabled = true
        bigImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gestureCalled(tapGesture:))))
        
        UIView.animate(withDuration: 0.5, animations: {
            if let keyWindow = UIApplication.shared.keyWindow {
                bigImage.frame = UIScreen.main.bounds
                bigImage.contentMode = .scaleAspectFill
                keyWindow.addSubview(bigImage)
            }
        }, completion: nil)
    }
    @objc func gestureCalled(tapGesture:UITapGestureRecognizer) -> Void {
        if let newImage = tapGesture.view {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                newImage.frame = self.startingFrame!
            }) { (completed: Bool) in
                newImage.removeFromSuperview()
            }
        }
    }
}
