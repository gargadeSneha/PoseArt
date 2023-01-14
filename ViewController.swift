//
//  ViewController.swift
//  GirlsPoses
//
//  Created by TryCatch Classes on 28/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logo_img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
       UIImageView.animate(withDuration: 4, delay: 1, options: .curveEaseInOut, animations: {
                self.logo_img.frame.size.width += 169
                self.logo_img.frame.size.height += 209
                
            }, completion: nil)
        logo_img.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home_Screen")
            self.navigationController?.pushViewController(secondViewController!, animated: true)
        }

    }
    
}
