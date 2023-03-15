//
//  ViewController.swift
//  MVVM Title Body
//
//  Created by Phincon on 14/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userPostViewModel: UserPostViewModel? // untuk manggil view model
    var userPosts : [UserPostModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupTableView()
    }
    
    func setupViewModel() {
//        self.userPostViewModel = UserPostViewModel (url:"https://jsonplaceholder.typicode.com/posts")
        self.userPostViewModel = UserPostViewModel(urlString: "https://jsonplaceholder.typicode.com/posts", apiService: GetApi())
        self.userPostViewModel?.bindUserPostData = bindDataToController
        self.userPostViewModel?.userDataPost()
    }
    
    func bindDataToController(userPost: [UserPostModel]?) {
        if let userPostModel = userPost {
//            print(userPostModel)
            self.userPosts = userPostModel
            self.tableView.backgroundColor = .white
            print ("reload data")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            self.tableView.backgroundColor = .blue
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: UserPostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserPostTableViewCell.identifier)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tes")
        guard let count = self.userPosts?.count else { return 0 }
        print("count ", count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserPostTableViewCell", for: indexPath) as?  UserPostTableViewCell else {
            return UITableViewCell() }
        if let userPost = self.userPosts?[indexPath.row] { // agar variabel yg baru hasilnya tidak opsional
            print(userPost)
            cell.titleLabel.text = userPost.title
            // string (interpolations)
            cell.userId.text = "\(userPost.albumId)"
            cell.id.text = "\(userPost.id)"
//            cell.body.text = userPost.
        }
        
        return cell
    }
    
}
