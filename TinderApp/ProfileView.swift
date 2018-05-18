//
//  ProfileView.swift
//  TinderApp
//
//  Created by Jae on 14/05/18.
//  Copyright © 2018 Jae. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    var img: UIImage?
    var name: String?
    var isWishlist: Bool?
    var shouldSetupConstraints: Bool = true
    
    var nameView: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var buttonView: UIButton = {
        let buttonView = UIButton(type: UIButtonType.custom)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.addTarget(self, action: #selector(ProfileView.updateWishlistButton(sender:)), for: .touchUpInside)
        return buttonView
    }()
    
    var likeView: UIImageView = {
        let likeView = UIImageView()
        likeView.image = UIImage(named: "LikeStamp")
        likeView.translatesAutoresizingMaskIntoConstraints = false
        likeView.alpha = 0.0
        return likeView
    }()
    
    var nopeView: UIImageView = {
        let nopeView = UIImageView()
        nopeView.image = UIImage(named: "NopeStamp")
        nopeView.translatesAutoresizingMaskIntoConstraints = false
        nopeView.alpha = 0.0
        return nopeView
    }()
    
    let screenSize = UIScreen.main.bounds.size
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1.0
        
        self.addSubview(nameView)
        self.addSubview(imageView)
        self.addSubview(buttonView)
        self.addSubview(likeView)
        self.addSubview(nopeView)
        
        updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let name = name {
            nameView.text = name
        }
        if let image = img {
            imageView.image = image
        }
        if let isWishlist = isWishlist {
            buttonView.isSelected = isWishlist
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {

        if (shouldSetupConstraints) {
            // update constraints here
            shouldSetupConstraints = false
            
            likeView.bringSubview(toFront: likeView)
            likeView.contentMode = .scaleToFill
            likeView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.4).isActive = true
            likeView.heightAnchor.constraint(equalToConstant: screenSize.width * 0.2).isActive = true
            
            nopeView.bringSubview(toFront: nopeView)
            nopeView.contentMode = .scaleToFill
            nopeView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.4).isActive = true
            nopeView.heightAnchor.constraint(equalToConstant: screenSize.width * 0.3).isActive = true
            
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.9).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: screenSize.height * 0.7).isActive = true
            imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: self.nameView.topAnchor).isActive = true

            nameView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            nameView.rightAnchor.constraint(equalTo: self.buttonView.leftAnchor).isActive = true

            buttonView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            buttonView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            buttonView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            buttonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            buttonView.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            buttonView.setImage(#imageLiteral(resourceName: "EmptyHeart"), for: .normal)
            buttonView.setImage(#imageLiteral(resourceName: "FilledHeart"), for: .selected)
            buttonView.setImage(#imageLiteral(resourceName: "SelectedHeart"), for: .highlighted)
            buttonView.setImage(#imageLiteral(resourceName: "SelectedHeart"), for: [.highlighted, .selected])
            
            print(self.center)
        }
        super.updateConstraints()
    }
    
    @objc func updateWishlistButton(sender: UIButton) {
        if let isWishlist = isWishlist {
            self.isWishlist = !isWishlist
            sender.isSelected = self.isWishlist!
        }
    }
    
    public func updateStatOpacity(opacity: CGFloat) {
        if opacity < 0 {
            nopeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
            nopeView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
            nopeView.transform = CGAffineTransform(rotationAngle: 1.01)
            nopeView.alpha = abs(opacity)
        } else if opacity > 0 {
            likeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
            likeView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
            likeView.transform = CGAffineTransform(rotationAngle: -0.61)
            likeView.alpha = abs(opacity)
        }
    }
}
