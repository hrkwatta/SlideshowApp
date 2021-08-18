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
        self.showImage(imageView: imageView, url: "https://source.unsplash.com/\(photoIds[currentIndex])")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toEnlargementViewController" {

            let next = segue.destination as? EnlargementViewController
            
            next?.photoId = self.photoIds[currentIndex]
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    private func showImage(imageView: UIImageView, url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            imageView.image = image
        } catch let err {
            print("Error: \(err.localizedDescription)")
        }
    }
    
    private func nextImage() {
        if(currentIndex < photoIds.count-1){
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        self.showImage(imageView: imageView, url: "https://source.unsplash.com/\(photoIds[currentIndex])")
    }
    
    private func prevImage() {
        if(0 < currentIndex){
            currentIndex -= 1
        }else{
            currentIndex = photoIds.count-1
        }
        self.showImage(imageView: imageView, url: "https://source.unsplash.com/\(photoIds[currentIndex])")
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
            nextButton.isEnabled = false
            prevButton.isEnabled = false
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
        } else {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
            self.timer?.invalidate()   // タイマーを停止する
        }
    }

}

