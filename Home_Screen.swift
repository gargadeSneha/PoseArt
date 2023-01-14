//
//  Home_Screen.swift
//  GirlsPoses
//
//  Created by TryCatch Classes on 28/12/22.
//

import UIKit
import Kingfisher

class Home_Screen: UIViewController {
    
    //Outlets of collection view
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var TagsCollectionView: UICollectionView!
    @IBOutlet weak var RecentCollectionView: UICollectionView!
    @IBOutlet weak var PopularCollectionView: UICollectionView!
    
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenu: UIView!
    
    //Models
    var arrayOfCat = [CategoryModel]()
    var arrayOfTags = [TagsModel]()
    var arrayOfRecect = [RecentModel]()
    var arrayOfPopular = [PopularModel]()
    
    //Side menu
    var sideMenuArray = ["Home","About Us","More Apps","Share App"]
    
    //popularCollectionView
    var popularImg = ["Pose2","Pose3","Pose4","Pose5","Pose6","Pose7","Pose8","Pose9","Pose10","Pose11","Pose12","Pose13","Pose14","Pose15","Pose16","Pose17","Pose18","Pose19","Pose20","Pose21","Pose22","Pose23","Pose24","Pose25","Pose26","Pose27","Pose28","Pose29","Pose30","Pose31","Pose32","Pose33","Pose34","Pose35","Pose37","Pose38"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //Create header of table view
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        headerView.backgroundColor = .black
        let label = UILabel(frame: CGRect(x: 20, y: 5, width: self.tableView.frame.width, height: 45))
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.text = "POSE"
        headerView.addSubview(label)
        self.tableView.tableHeaderView = headerView
        
        //Category CollectionVew
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        //Tag CollectionVew
        TagsCollectionView.dataSource = self
        TagsCollectionView.delegate = self
        
        //Recent CollectionVew
        RecentCollectionView.dataSource = self
        RecentCollectionView.delegate = self
        
        //Popular CollectionVew
        PopularCollectionView.dataSource = self
        PopularCollectionView.delegate = self
        
        //side menu TableView
        tableView.delegate = self
        tableView.dataSource = self
        
        //API call
        getCategoryApi()
        getTagApi()
        getRecenrApi()
        
    }
    
    
    @IBAction func popularViewAllBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Popular_Screen") as! Popular_Screen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func menuBtnTapped(_ sender: UIButton) {
        sideMenu.isHidden = false
        mainView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
    }
    
    
    @IBAction func recentViewAllBtnTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Recent_Screen") as! Recent_Screen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Api Call
    func getCategoryApi() {
        guard let urlC = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_category_list")
        else{
            return
        }
        
        URLSession.shared.dataTask(with: urlC) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode([CategoryModel].self, from: data)
                    
                    print(jsondata)
                    DispatchQueue.main.async {
                        self.arrayOfCat = jsondata
                        self.categoryCollectionView.reloadData()
                        
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
    }
    func getTagApi() {
        guard let urlT = URL(string: "https://mapi.trycatchtech.com/v3/girls_poses/girls_poses_tags_list")
        else{
            return
        }
        URLSession.shared.dataTask(with: urlT) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode([TagsModel].self, from: data)
                    
                    print(jsondata)
                    DispatchQueue.main.async {
                        self.arrayOfTags = jsondata
                        self.TagsCollectionView.reloadData()
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
        
    }
    
    func getRecenrApi() {
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
                        self.arrayOfRecect = jsondata
                        self.RecentCollectionView.reloadData()
                    }
                    
                }catch {
                    print("somthing went wrong")
                }
            }
        }.resume()
    }
}
// MARK: - Collection View
extension Home_Screen: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == categoryCollectionView)
        {
            return arrayOfCat.count
        }
        else if (collectionView == TagsCollectionView)
        {
            return arrayOfTags.count
        }
        else if (collectionView == RecentCollectionView)
        {
            return arrayOfRecect.count
        }
        else
        {
            return popularImg.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == categoryCollectionView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCVC
            //Get image from Api using kingfisher
            let url = URL(string: arrayOfCat[indexPath.row].catImage)
            cell.CatImgView.kf.setImage(with: url)
            cell.CatLbl.text = arrayOfCat[indexPath.row].catName
            cell.layer.cornerRadius = 10
            return cell
            
        }
        else if (collectionView == TagsCollectionView)
        {
            let cell = TagsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TagsCVC
            cell.tags_View.addGradientBackground()
            cell.tags_Lbl.text = arrayOfTags[indexPath.row].tagName
            cell.layoutSubviews()
            cell.layoutIfNeeded()
            cell.setNeedsLayout()
            cell.tags_View.roundCorners([.bottomLeft,.bottomRight], radius: 10)
            return cell
        }
        else if (collectionView == RecentCollectionView)
        {
            let cell = RecentCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecentCVC
            //Get image from Api using kingfisher
            let url = URL(string: arrayOfRecect[indexPath.row].postImage)
            cell.recent_imgView.kf.setImage(with: url)
            cell.recent_Lbl.text = arrayOfRecect[indexPath.row].tagName
            cell.layer.cornerRadius = 10
            return cell
        }
        else
        {
            let cell = PopularCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PopularCVC
            cell.popular_imgView.image = UIImage(named: popularImg[indexPath.row])
            cell.layer.cornerRadius = 10
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == PopularCollectionView)
        {
            let width = ((TagsCollectionView.frame.width - 32 ) / 4 )
            let height = ((TagsCollectionView.frame.height - 2 ) / 1 )
            return CGSize(width: width, height: height)
        }
        let width = ((collectionView.frame.width - 22 ) / 3 )
        let height = ((collectionView.frame.height - 2 ) / 1 )
        return CGSize(width: width, height: height)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //After selection of cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == categoryCollectionView)
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "GirlsPoses_Screen") as! GirlsPoses_Screen
            vc.catID = arrayOfCat[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if (collectionView == TagsCollectionView)
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Tags_Screen") as! Tags_Screen
            vc.dataModel = arrayOfTags[indexPath.row]
            vc.name = arrayOfTags[indexPath.row].tagName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if (collectionView == PopularCollectionView)
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FullImage2_Screen") as! FullImage2_Screen
            vc.image = UIImage(named: popularImg[indexPath.row])!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
// MARK: - Table View
extension Home_Screen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTVC
        cell.imgView.image = UIImage(named: sideMenuArray[indexPath.row])
        cell.lbl.text = sideMenuArray[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sideMenu.isHidden = true
        transparentView.isHidden = false
        transparentView.backgroundColor = UIColor(white: 1, alpha: 0)
        
    }
}

// MARK: - Gradient Background
extension UIView {
    func addGradientBackground() {
        let random = UIColor.random().cgColor
        let random2 = UIColor.random().cgColor
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [random, random2]
        
        layer.insertSublayer(gradient, at: 0)
        
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
// MARK: - Background Color
extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
