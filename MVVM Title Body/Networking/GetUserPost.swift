//
//  GetUserPost.swift
//  MVVM Title Body
//
//  Created by Phincon on 14/03/23.
//

import Foundation

protocol getUserPostApiProtocol {
    var url: String {get set}
    func callApi(completion:@escaping([UserPostModel]?) -> Void )
}

struct GetUserPostApi {
    var url: String
    init(url: String){
        self.url = url
    }
    
    func callApi(completion:@escaping([UserPostModel]?) -> Void ) {
        guard let  url = URL(string: self.url) else {return}
        
        
        URLSession.shared.dataTask (with: url) { data, response, error in
            guard let data = data else { return}
            do {
                let decoder = JSONDecoder ()
                let modelData = try decoder.decode([UserPostModel].self, from: data)
                completion(modelData)
            } catch {
                completion(nil)
            }
        }.resume()
        
    }
    
}

//struct GetApi: GetApiProtocol {
//    private var url = URL(string: "")
//    mutating func get(url: URL) {
//        self.url = url
//    }
//
//    func callApi<T>(model: T.Type, completion: ()) where T : Decodable, T : Encodable {
//        guard let url = self.url else {return}
//        URLSession.shared.dataTask(with: url) { data,response, error in
//            if let data = data {
//                do {
//                    let modelData = try
//                    JSONDecoder().decode(T.self, from: data)
//                    completion(.success(modelData))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            }
//        }.resume()
//    }
//}
//
//
