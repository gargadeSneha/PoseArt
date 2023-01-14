//
//  GirlsPoses_Screen.swift
//  GirlsPoses
//
//  Created by TryCatch Classes on 02/01/23.
//

import UIKit
import Kingfisher

class GirlsPoses_Screen: UIViewController {

    var selectedIndex = 0
    var arrayOfTags = [PopularModel]()
    var arrayOfPose = [TagsWithPose]()
    
    var itemsArray = [ItemModel]()
    var dataModel: TagsModel?
    var catID = ""
    var name = ""
    
    @IBOutlet weak var GirlsimgCollectionView: UICollectionView!
    @IBOutlet weak var GirlsPosesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tags CollectionView
        GirlsPosesCollectionView.delegate = self
        GirlsPosesCollectionView.dataSource = self
        
        //Image CollectionView
        GirlsimgCollectionView.dataSource = self
        GirlsimgCollectionView.delegate = self
      
        //API call
        getTagsList()
    
    }

    @IBAction func BackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
  // MARK: - API-1 WORK
    func getTagsList() {
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_recent_posts_by_tags_and_category?category_id=\(catID)&tag_id=\(dataModel?.id ?? "")")
        else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode([TagsWithPose].self, from: data)
                   
                    //print(jsondata)
                    DispatchQueue.main.async {
                    //    self.arrayOfTags = jsondata
                        if self.arrayOfPose.count > 0 {
                            self.selectedIndex = Int(self.arrayOfPose[0].id) ?? 0
                          
                            self.arrayOfPose = jsondata
                            self.GirlsPosesCollectionView.reloadData()
                        }
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
    }
   
   
  
 /* // MARK: - API-1 WORK
    func getTagsList() {
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_tags_and_post_by_category?category_id=\(catID)")
        else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode([PopularModel].self, from: data)
                   
                    //print(jsondata)
                    DispatchQueue.main.async {
                        self.arrayOfTags = jsondata
                        if self.arrayOfTags.count > 0 {
                            self.selectedIndex = Int(self.arrayOfTags[0].tags[2].id) ?? 0
                           // self.selectedBrandName = self.arrayOfTags[0].tagName
                        }
                        self.GirlsPosesCollectionView.reloadData()
                        self.gatPoseImage() 
                       
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
    }
 
  // MARK: - API-2 WORK
    func gatPoseImage() {
        
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_recent_posts_by_tags_and_category?category_id=1&tag_id=\(selectedIndex)")
        else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode([TagsWithPose].self, from: data)
                   
                    //print(jsondata)
                    DispatchQueue.main.async {
                        self.arrayOfPose = jsondata
                        self.selectedIndex = Int(self.arrayOfPose[0].postImage) ?? 0
                        self.GirlsimgCollectionView.reloadData()
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
    }*/
   
}
//collection view
extension GirlsPoses_Screen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == GirlsimgCollectionView)
        {
            return arrayOfPose.count
        } else {
          //  return Int(dataModel?.tagName.count ?? 0)
            return arrayOfTags.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       if (collectionView == GirlsPosesCollectionView)
        {
            let cell = GirlsPosesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GirlsPosesCVC
            cell.lbl.text = dataModel?.tagName
          
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let cell = GirlsimgCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GirlsImgCVC
            let url = ImageResource(downloadURL: URL(string: arrayOfPose[indexPath.row].postImage)!)
            cell.imgView.kf.setImage(with: url)
            cell.layer.cornerRadius = 20
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == GirlsimgCollectionView) {
            let width = ((GirlsimgCollectionView.frame.width - 4 ) / 2 )
            let height = ((GirlsimgCollectionView.frame.height - 5 ) / 3 )
            return CGSize(width: width, height: height)
        } else {
            let width = ((GirlsPosesCollectionView.frame.width - 5 ) / 4 )
            let height = ((GirlsPosesCollectionView.frame.height - 2 ) / 1 )
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == GirlsimgCollectionView)
        {
           let vc = storyboard?.instantiateViewController(withIdentifier: "FullImage_Screen") as! FullImage_Screen
           self.navigationController?.pushViewController(vc, animated: true)
        }

    }

}


