//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Hiroki Watanabe on 2021/08/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var startAndPauseButton: UIButton!
    
    private let photoIds = ["9IZwARETOMQ","wdUjA_RN-p0","jGibIXR2NVE","clriYc-Nfk0","_YHm00f5RxE"]
    private var currentIndex = 0
    // タイマ
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showImage(imageView: imageView, name: photoIds[currentIndex])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toEnlargementViewController" {

            let next = segue.destination as? EnlargementViewController
            
            //タイマーを停止する
            if self.timer?.isValid == true {
                self.timer?.invalidate()   // タイマーを停止する
                startAndPauseButton.setTitle("再生", for: .normal)
                nextButton.isEnabled = true
                prevButton.isEnabled = true
            }
            next?.photoId = self.photoIds[currentIndex]

        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    private func showImage(imageView: UIImageView, name: String) {

        let image = UIImage(named: "\(name).jpeg")
        imageView.image = image
    }
    
    private func nextImage() {
        if(currentIndex < photoIds.count-1){
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        self.showImage(imageView: imageView, name: photoIds[currentIndex])
    }
    
    private func prevImage() {
        if(0 < currentIndex){
            currentIndex -= 1
        }else{
            currentIndex = photoIds.count-1
        }
        self.showImage(imageView: imageView, name: photoIds[currentIndex])
    }
    
    @objc func updateTimer(_ timer: Timer) {
        nextImage()
    }
    
    @IBAction func NEXT(_ sender: Any) {
        self.nextImage()
    }
    
    @IBAction func PREV(_ sender: Any) {
        self.prevImage()
    }
    
    @IBAction func STARTANDPAUSE(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer?.isValid != true {
            startAndPauseButton.setTitle("停止", for: .normal)
            nextButton.isEnabled = false
            prevButton.isEnabled = false
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
        } else {
            self.timer?.invalidate()   // タイマーを停止する
            startAndPauseButton.setTitle("再生", for: .normal)
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
    }

}

