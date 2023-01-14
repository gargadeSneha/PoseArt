//
//  Favorite_Screen.swift
//  GirlsPoses
//
//  Created by TryCatch Classes on 08/01/23.
//

import UIKit

class Recent_Screen: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var arrayOfRecent = [RecentModel]()
    var arrayOfTags = [TagsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
       
        getRecentApi()
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getRecentApi() {
        guard let urlR = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_recent_uploads")
        else{
            return
        }
        
        URLSession.shared.dataTask(with: urlR) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode([RecentModel].self, from: data)
                   
                    print(jsondata)
                    DispatchQueue.main.async {
                        self.arrayOfRecent = jsondata
                        self.collectionView.reloadData()
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
    }
   
}
extension Recent_Screen: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfRecent.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecentScreenCVC
        let url = URL(string: arrayOfRecent[indexPath.row].postImage)
        cell.imgView.kf.setImage(with: url)
        cell.lbl.text = arrayOfRecent[indexPath.row].tagName
        cell.layer.cornerRadius = 20
               return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 24 ) / 2 )
        let height = ((collectionView.frame.height - 40 ) / 3 )
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
   
}

