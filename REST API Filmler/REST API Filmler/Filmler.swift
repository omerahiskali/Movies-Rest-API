//
//  Filmler.swift
//  REST API Filmler
//
//  Created by Ömer Faruk Küçükahıskalı on 31.01.2023.
//

import Foundation

class Filmler: Codable{
    var film_id:String?
    var film_ad:String?
    var film_yil:String?
    var film_resim:String?
    var kategori:Kategoriler?
    var yonetmen:Yonetmenler?
    
    init(film_id: String? = nil, film_ad: String? = nil, film_yil: String? = nil, film_resim: String? = nil, kategori: Kategoriler? = nil, yonetmen: Yonetmenler? = nil) {
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_yil = film_yil
        self.film_resim = film_resim
        self.kategori = kategori
        self.yonetmen = yonetmen
    }
    
    init() {
        
    }
}
