//
//  ViewController.swift
//  The card game
//
//  Created by xuantien on 08/07/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var timer:Timer?
    var milliseconds:Int = 10 * 1000
    var firstFlippedCardIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
   cardsArray = model.getCard()
        // Do any additional setup after loading the view.
        ///???????
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // khởi tạo bộ đếm thời gian
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo:  nil, repeats: true)
    
        
    }
    
@objc func timerFired(){
    
    
    // Giảm bộ đếm
    milliseconds -= 1
    // cập nhật label
    let seconds:Double = Double(milliseconds)/1000.0
    
    timerLabel.text = String(format: "Time remaining: %.2f",  seconds)
    
    
    // dừng bộ đếm thời gian nếu nó đạt đến 0
    if(milliseconds == 0){
        timerLabel.textColor = UIColor.red
        timer?.invalidate()
        // kiểm tra người dùng đã xoá tất cả các thẻ,,,,,
        
        
        checkForGameEnd()
    }
    
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cardsArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
            
          
            return cell
            
        }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //. định cấu hình trạng thái của ô dựa trên các thuộc tính của thẻ mà nó đại diện cho tất cả các quyền
        
       let  cardCell = cell as?  CardCollectionViewCell
        
        
        let card = cardsArray[indexPath.row]
        
        
        cardCell?.configureCell(card: card)
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let cell =  collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false{
            cell?.flipUp(time: 0.3)
            
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
            }else{
                
                checkForMatch(indexPath)
            }
            

        }
        
    }
    
    // - Game Logic Methods
    
    func checkForMatch(_ seconFlippedCardIndex:IndexPath){
        // Get the two card object for the two indices and see if they match
        
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[seconFlippedCardIndex.row]
        
        
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell

        let cardTwoCell =  collectionView.cellForItem(at: seconFlippedCardIndex)  as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            
            checkForGameEnd()
            
        }else{
            
            cardOneCell?.flipDown(time: 0.3)
            cardTwoCell?.flipDown(time: 0.3)
        }
        firstFlippedCardIndex = nil
    }
    func checkForGameEnd()  {
        // kiểm tra xem có thẻ nào chưa khớp đúng không
        var hasWon = true
        
        for card in cardsArray{
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon == true {
            showAlert(title: "Congratulations", message: "you win game!")
        }else{
            if milliseconds <= 0 {
                showAlert(title: "Time's Up ", message: "Sorry, better luck next time!")
            }
        }
    }
    
    func showAlert(title :String , message:String){
        
        // tạo ra cảnh báo
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK!", style: .default, handler: nil)
        
        // thêm 1 nút để người dungf loại bỏ nó
        alert.addAction(okAction)
        
        // show cảnh báo 
            present(alert, animated: true, completion: nil)
    }
}

