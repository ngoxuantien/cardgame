//
//  CardCollectionViewCell.swift
//  The card game
//
//  Created by xuantien on 10/07/2021.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var  card:Card?
    
    func configureCell(card:Card)  {
        
        self.card = card
        
        
        frontImageView.image = UIImage(named: card.imageName)
        
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }else{
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        if card.isFlipped == true {
            flipUp(time: 0)
        }else{
            flipDown(time: 0,delay: 0)
        }
    }
    
    func flipUp(time : TimeInterval) {
        // flipUP animation
        
        
        UIView.transition(from: backImageView, to: frontImageView, duration: time, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = true
    }
    func flipDown(time:TimeInterval, delay:TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        }
        // flipUP animation
        
      
        
        card?.isFlipped = false
    }
    
    func remove(){
        // make the image view invisible
        
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
    
}
