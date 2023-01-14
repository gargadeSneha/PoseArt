//
//  Tags_Screen.swift
//  GirlsPoses
//
//  Created by TryCatch on 03/01/23.
//

import UIKit
import Kingfisher

class Tags_Screen: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var segmentCollectionView: UICollectionView!
    
    
    var itemsArray = [ItemModel]()
    var arrayOfItem = [TagsWithPose]()
    var dataModel: TagsModel?
   // var dataModel1: RecentModel?
    var catID = ""
    var name = ""
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Segment control colour
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: UIControl.State.selected)
        
        lbl.text = dataModel?.tagName
//        lbl.text = dataModel1?.tagName
        
        //segmentControl collectionView
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
      
        //API call
        getImgs()
        
    }
        
//         URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_recent_posts_by_tags_and_category?category_id=\(catID)&tag_id=\(dataModel?.id ?? "")")
  
    
//
    func getImgs() {
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_recent_posts_by_tags_and_category?category_id=1&tag_id=\(dataModel?.id ?? "")") else {
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
                        self.arrayOfItem = jsondata
                        self.segmentCollectionView.reloadData()
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
                
    }
   
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentControlSwitch(_ sender: UISegmentedControl) {
        segmentCollectionView.reloadData()
    }
   
}
// MARK: - CollectionView
extension Tags_Screen: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return arrayOfItem.count
        }
        else {
            return arrayOfItem.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SegmentTagsCVC
    
            let url = ImageResource(downloadURL: URL(string: arrayOfItem[indexPath.row].postImage)!)
            cell.imgView.kf.setImage(with: url)
            cell.layer.cornerRadius = 20
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SegmentTagsCVC
          
            cell.layer.cornerRadius = 20
            return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((segmentCollectionView.frame.width - 24 ) / 2 )
        let height = ((segmentCollectionView.frame.height - 40 ) / 3 )
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullImage_Screen") as! FullImage_Screen
        vc.imageUrl = arrayOfItem[indexPath.item].postImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

