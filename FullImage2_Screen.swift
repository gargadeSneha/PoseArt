//
//  FullImage2_Screen.swift
//  GirlsPoses
//
//  Created by Trycatch Classes on 11/01/23.
//

import UIKit

class FullImage2_Screen: UIViewController {
    
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    var image = UIImage()
    
    var option1HeartBtn: CGPoint!
    var option2DownloadBtn: CGPoint!
    var option3ShareBtn: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = image
        
        menuBtn.layer.cornerRadius = 35
        option1.layer.cornerRadius = 35
        option2.layer.cornerRadius = 35
        option3.layer.cornerRadius = 35
        
        option1HeartBtn = option1.center
        option2DownloadBtn = option2.center
        option3ShareBtn = option3.center
    }
    
    @IBAction func BackBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AddBtnTapped(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "Add") {
            sender.setImage(UIImage(named: "Cancel"), for: .normal)
            option1.isHidden = false
            option2.isHidden = false
            option3.isHidden = false
        }
        else
        {
            sender.setImage(UIImage(named: "Add"), for: .normal)
            option1.isHidden = true
            option2.isHidden = true
            option3.isHidden = true
        }
    }
    
}
