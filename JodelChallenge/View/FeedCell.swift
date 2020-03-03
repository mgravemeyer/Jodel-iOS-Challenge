//
//  FeedCell.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class FeedCell : UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextField!
    
    let imageZoomContoller = ImageZoomContoller()
    
    public func configure(with image : Photo) {
        if let data = try? Data(contentsOf: image.getPhotoURL()) {
            imageView.image = UIImage(data: data)
            textView.text = image.getTitle()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                imageZoomContoller.performZoom(cellImageView: self.imageView)
            }
        }
    }
}
