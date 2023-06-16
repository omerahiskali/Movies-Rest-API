//
//  ViewController.swift
//  REST API Filmler
//
//  Created by Ömer Faruk Küçükahıskalı on 31.01.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var kategoriListe = [Kategoriler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        kategoriAl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let indeks = sender as? Int
        
        if segue.identifier == "toFilm"{
            let gidilecekVC = segue.destination as! KategoriFilmVC
            gidilecekVC.kategori = kategoriListe[indeks!]
        }
        

        
    }

    func kategoriAl(){
        AF.request("http://omerahiskali.com.tr/WebServiceFilmler/tum_kategoriler.php", method: .get).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(KategorilerCevap.self, from: data)
                    
                    if let gelenListe = cevap.kategoriler{
                        
                        self.kategoriListe = gelenListe

                    }else{
                        self.kategoriListe = [Kategoriler]()
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategoriListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gelenKategori = kategoriListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath)
        
        cell.textLabel?.text = gelenKategori.kategori_ad
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFilm", sender: indexPath.row)
    }
}
