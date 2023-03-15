//
//  ImageViewModel.swift
//  MVVM Title Body
//
//  Created by Phincon on 15/03/23.
//

import Foundation

protocol ImageViewModelProtocol {
    var urlString : String {get}
    var bindImageData : (([ImageModel]?)-> Void)? {get set}
    func imageData()
}

class ImageViewModel: ImageViewModelProtocol {
    var bindImageData: (([ImageModel]?) -> Void)?
    
    private var apiService: GetApiProtocol?
    
    var urlString: String
    
    var data : [ImageModel]?
    
    init(urlString: String, apiService: GetApiProtocol) {
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString) {
            self.apiService?.get(url: url)
        }
        imageData()
    }
    
    func imageData() {
        self.apiService?.callApi(model: [ImageModel].self, completion: {response in
            switch response {
                case .success(let success):
                    self.bindImageData?(success)
                case .failure(let fail):
                    self.bindImageData?(nil)
                }
            
        })
        }
}
