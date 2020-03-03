//
//  ImageListController.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 29.02.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation

class ImageZoomContoller {
    
    var cellImageFrame: CGRect?
    
    func performZoom(cellImageView: UIImageView) {
        
        cellImageFrame = cellImageView.convert(cellImageView.frame, to: nil)
        let bigImageView = UIImageView(frame: self.cellImageFrame!)
        bigImageView.image = cellImageView.image
        bigImageView.isUserInteractionEnabled = true
        bigImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gestureCalled(tapGesture:))))
        
        UIView.animate(withDuration: 0.5, animations: {
            if let keyWindow = UIApplication.shared.keyWindow {
                bigImageView.frame = UIScreen.main.bounds
                bigImageView.contentMode = .scaleAspectFill
                keyWindow.addSubview(bigImageView)
            }
        }, completion: nil)
    }
    
    @objc func gestureCalled(tapGesture:UITapGestureRecognizer) -> Void {
        if let newImage = tapGesture.view {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                newImage.frame = self.cellImageFrame!
            }) { (completed: Bool) in
                newImage.removeFromSuperview()
            }
        }
    }
}
