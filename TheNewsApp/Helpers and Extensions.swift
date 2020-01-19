

import Foundation
import UIKit

extension UIView {

    func setGradientBackground(colors: [UIColor]) {
        
        let newColors = colors.map { (color) -> CGColor in
            return color.cgColor
        }
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = newColors
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
       
    }
    
    
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(urlString: String) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = UIImage(data: data!)
                }
                
            }
            
            }.resume()
        
    }
    
}
