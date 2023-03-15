//
//  ImageViewController.swift
//  MVVM Title Body
//
//  Created by Phincon on 15/03/23.
//

import UIKit

class ImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Image :UITableView!
    
    var viewModel : ImageViewModel?
    
    private var modelListImage: [ImageModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        
        self.viewModel = ImageViewModel(urlString: "https://jsonplaceholder.typicode.com/photos", apiService: GetApi()) // ini tu dari struct protocol yg result yg dari getApi
        self.viewModel?.bindImageData = { imageListData in
            if let imageListData = imageListData {
                self.modelListImage = imageListData
                self.Image.backgroundColor = .cyan
            } else {
                self.Image.backgroundColor = .systemPink
            }
            DispatchQueue.main.async {
                self.Image.reloadData()
            }
        }
        
        func registerTableView(){
            Image.delegate = self
            Image.dataSource = self
            
            Image.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: ImageTableViewCell.identifier)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.modelListImage?.count ?? 0
        print (count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Image.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        
        cell.thumbnailImage.imageFromServerURL(self.modelListImage?[indexPath.row].thumbnailImage ?? "", placeHolder: UIImage(systemName: "chevron.left"))
            cell.albumIdLabel.text = "\(String(describing: self.modelListImage?[indexPath.row].albumId ?? 0))"
            cell.idLabel.text = "\(String(describing: self.modelListImage?[indexPath.row].id ?? 0))"
            cell.titleLabel.text = self.modelListImage?[indexPath.row].title
        
//        cell.albumIdLabel.text = "albumId"
//        cell.idLabel.text = "idLabel"
//        cell.titleLabel.text = "titleLabel"
        return cell
    }
}
