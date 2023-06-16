//
//  FilmDetaylarVC.swift
//  REST API Filmler
//
//  Created by Ömer Faruk Küçükahıskalı on 31.01.2023.
//

import UIKit

class FilmDetaylarVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filmAdiLabel: UILabel!
    
    @IBOutlet weak var kategoriLabel: UILabel!
    
    @IBOutlet weak var yayimYiliLabel: UILabel!
    
    @IBOutlet weak var yonetmenLabel: UILabel!
    
    var film:Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let f = film{
            if let url = URL(string: "http://omerahiskali.com.tr/Film%20Resimler/\(f.film_resim!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
            }
            
            filmAdiLabel.text = f.film_ad
            kategoriLabel.text = f.kategori?.kategori_ad
            yayimYiliLabel.text = f.film_yil
            yonetmenLabel.text = f.yonetmen?.yonetmen_ad
        }
        
    }
    


}
