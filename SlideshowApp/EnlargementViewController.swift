//
//  EnlargementViewController.swift
//  SlideshowApp
//
//  Created by Hiroki Watanabe on 2021/08/13.
//

import UIKit

class EnlargementViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var photoId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let photoId = photoId else {
            fatalError()
        }
        self.showImage(imageView: imageView, name: photoId)
    }
    
    func trimmingImage(_ image: UIImage, trimmingArea: CGRect) -> UIImage {
        let imgRef = image.cgImage?.cropping(to: trimmingArea)
        let trimImage = UIImage(cgImage: imgRef!, scale: image.scale, orientation: image.imageOrientation)
        return trimImage
    }
    
    private func showImage(imageView: UIImageView, name: String) {
        let image = UIImage(named: "\(name).jpeg")
        imageView.image = image
            
            let clipRect = CGRect(x: image!.size.width * 0.2, y: image!.size.height * 0.4, width: image!.size.width * 0.6, height: image!.size.width * 0.6)
            let _image: UIImage = trimmingImage(image!, trimmingArea: clipRect)
            
            imageView.image = _image
            
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
