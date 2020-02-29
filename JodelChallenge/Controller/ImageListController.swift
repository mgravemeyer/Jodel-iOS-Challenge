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
    var blackBackgroundView: UIView?
    
    func performZoom(startImageView: UIImageView) {
        
        startingFrame = startImageView.convert(startImageView.frame, to: nil)

        let zoomingImageView = UIImageView(frame: self.startingFrame!)
        zoomingImageView.image = startImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gestureCalled(tapGesture:))))

        if let keyWindow = UIApplication.shared.keyWindow {
    
        blackBackgroundView = UIView(frame: keyWindow.frame)
        blackBackgroundView?.backgroundColor = UIColor.black
        blackBackgroundView?.alpha = 1
            
        keyWindow.addSubview(blackBackgroundView!)
        keyWindow.addSubview(zoomingImageView)
        
            UIView.animate(withDuration: 0.5, animations: {
            
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                zoomingImageView.center = keyWindow.center
                
            }, completion: nil)
        }
    }
    @objc func gestureCalled(tapGesture:UITapGestureRecognizer) -> Void {
        if let zoomOutImageView = tapGesture.view {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView!.alpha = 0
                
            }) { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
            }
        }
    }
}
