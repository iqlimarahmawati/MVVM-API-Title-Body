//
//  UIImageView.swift
//  MVVM Title Body
//
//  Created by Phincon on 15/03/23.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromServerURL(_ UrlString: String, placeHolder: UIImage?) {
        self.image = nil
        
        let imageServerUrl = UrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
