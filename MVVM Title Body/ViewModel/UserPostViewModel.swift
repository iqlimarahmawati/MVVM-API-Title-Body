//
//  UserPostViewModel.swift
//  MVVM Title Body
//
//  Created by Phincon on 14/03/23.
//

import Foundation

protocol UserPostViewModelProtocol {
    var urlString : String {get}
    var bindUserPostData : (([UserPostModel]?)->Void)? {get set}
    func userDataPost()
}


class UserPostViewModel: UserPostViewModelProtocol {
    var bindUserPostData: (([UserPostModel]?) -> Void)?
    
    
    //buat properti untuk get user post
//    private var getUserPost : GetUserPostApi?
    private var apiService: GetApiProtocol?
    // buat ngambil url
    var urlString : String
    
    var data: [UserPostModel]?
    
    // call back
    
//    init (url: String) {
//        self.url = url
//        self.getUserPost = GetUserPostApi(url: self.url)
//    }
    init(urlString: String, apiService:GeApiProtocol) {
        self.urlString = urlString
        self.apiService = apiService
        if let url = URL(string: urlString) {
            self.apiService?.get(url: url)
        }
            
        userDataPost()
    }
    
    
    
    func userDataPost() {
//        self.getUserPost?.callApi(completion: { userPosts in
//            if let userPostModel = userPosts {
//                self.bindUserPostData?(userPostModel)
//            } else {
//                self.bindUserPostData?(nil) // handle error
//            }
//        })
        
        self.apiService?.callApi(model: [UserPostModel].self, completion: { response in
            switch response {
            case .success(let success):
                self.bindUserPostData?(success)
            case .failure(_):
                self.bindUserPostData?(nil)
            }
        })
    }
}

