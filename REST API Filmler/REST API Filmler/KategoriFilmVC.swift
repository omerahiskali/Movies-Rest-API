//
//  KategoriFilmVC.swift
//  REST API Filmler
//
//  Created by Ömer Faruk Küçükahıskalı on 31.01.2023.
//

import UIKit
import Alamofire

class KategoriFilmVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var kategori:Kategoriler?
    
    var filmListesi = [Filmler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleYaz()
        filmGetir()
        
        let tasarim :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let genislik = self.collectionView.frame.size.width
        
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let hucreGenislik = (genislik-30)/2
        
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
        
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = tasarim
        
        collectionView.delegate = self
        collectionView.dataSource = self
               
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let gidilecekVC = segue.destination as! FilmDetaylarVC
        gidilecekVC.film = filmListesi[indeks!]
    }
    
    func titleYaz(){
        if let k = kategori {
                navigationItem.title = k.kategori_ad
        }
    }
    
    func filmGetir(){
        if let k = kategori{
            kategoriFilmGetir(kategori_id: k.kategori_id!)
        }
    }
    
    func kategoriFilmGetir(kategori_id:String){
        let params:Parameters = ["kategori_id":kategori_id] // Web Service e gidecek veriler
        
        AF.request("http://omerahiskali.com.tr/WebServiceFilmler/kategori_film.php", method: .post, parameters: params).response { response in
            
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(FilmCevap.self, from: data)
                    
                    if let gelenFilmListesi = cevap.filmler{
                        self.filmListesi = gelenFilmListesi
                    }else{
                        self.filmListesi = [Filmler]()
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension KategoriFilmVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gelenFilm = filmListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CollectionViewCell
        
        cell.filmAdiLabel.text = gelenFilm.film_ad
        
        if let url = URL(string: "http://omerahiskali.com.tr/Film%20Resimler/\(gelenFilm.film_resim!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                }
            }
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}
