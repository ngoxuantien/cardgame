//
//  CardModel.swift
//  The card game
//
//  Created by xuantien on 09/07/2021.
//

import Foundation
class CardModel{
    func getCard() -> [Card] {
        // Khai báo mảng rổng
        var generatedCards = [Card]()
        // Tạo ngẫu nhiên 8 cặp thẻ
        for _ in 1...10{
            
            // Sắp sếp ngẫu nhiên các thẻ trong mảng
            var randomNumber = Int.random(in: 2...14)
            let cardOne = Card()
            let cardTwo = Card()
            
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            
            generatedCards += [cardOne,cardTwo]
            
            print(randomNumber)
            
        }
        generatedCards.shuffle()
        
        return generatedCards
        
        // Trả về mảng
    }
}
