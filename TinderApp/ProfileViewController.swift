//
//  ViewController.swift
//  TinderApp
//
//  Created by Jae on 14/05/18.
//  Copyright © 2018 Jae. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileData = [Profile]()
    var profileViewData = [ProfileView]()
    var divisor: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        divisor = view.frame.width / 2 / -0.61
        profileData = [Profile.init(name: "Alodia Babe", image: #imageLiteral(resourceName: "Alodia"), isWishlist: false)]
        setupProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupProfile() {
        for profileView in profileViewData {
            profileView.removeFromSuperview()
            self.view.willRemoveSubview(profileView)
        }
        
        profileViewData.removeAll()
        
        for profile in profileData {
            let profileView = ProfileView()
            profileView.name = profile.name
            profileView.img = profile.image
            profileView.isWishlist = profile.isWishlist
            profileView.clipsToBounds = true
            
            profileViewData.append(profileView)
            self.view.addSubview(profileView)
            
            let leadingConstraint = NSLayoutConstraint(item: profileView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: self.view.frame.width * 0.05)
            let topConstraint = NSLayoutConstraint(item: profileView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: self.view.frame.height * 0.05)
            self.view.addConstraints([leadingConstraint, topConstraint])
        }
        
        for profileView in profileViewData {
            addPanGesture(view: profileView)
        }
    }
    
    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ProfileViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        print("swipped...")
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        let scale = min(100 / abs(xFromCenter), 1)
        
        let viewIndex = profileViewData.index(of: card as! ProfileView)!
        profileViewData[viewIndex].updateStatOpacity(opacity: xFromCenter / view.center.x)
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor).scaledBy(x: scale, y: scale)
        
        if sender.state == UIGestureRecognizerState.ended {
            if card.center.x < view.center.x * 0.5 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x - 500, y: card.center.y + 75)
                }
                return
            } else if card.center.x > view.center.x * 1.5 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: card.center.x + 500, y: card.center.y + 75)
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                card.transform = CGAffineTransform.identity
                self.profileViewData[viewIndex].nopeView.alpha = 0.0
                self.profileViewData[viewIndex].likeView.alpha = 0.0
            }
        }
    }
}

