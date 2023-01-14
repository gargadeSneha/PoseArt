//
//  Popular_Screen.swift
//  GirlsPoses
//
//  Created by TryCatch Classes on 07/01/23.
//

import UIKit

class Popular_Screen: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lbl: UILabel!
   
    var popularImg = ["Pose2","Pose3","Pose4","Pose5","Pose6","Pose7","Pose8","Pose9","Pose10","Pose11","Pose12","Pose13","Pose14","Pose15","Pose16","Pose17","Pose18","Pose19","Pose20","Pose21","Pose22","Pose23","Pose24","Pose25","Pose26","Pose27","Pose28","Pose29","Pose30","Pose31","Pose32","Pose33","Pose34","Pose35","Pose37","Pose38"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
      
    }
    
    @IBAction func BackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
//
extension Popular_Screen: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PopularScreenCVC
        cell.imgView.image = UIImage(named: popularImg[indexPath.row])
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullImage2_Screen") as! FullImage2_Screen
        vc.image = UIImage(named: popularImg[indexPath.row])!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


