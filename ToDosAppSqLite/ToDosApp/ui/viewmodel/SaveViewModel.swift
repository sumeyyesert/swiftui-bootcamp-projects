//
//  SaveViewModel.swift
//  ToDosApp
//
//  Created by Sümeyye Sert on 11.09.2025.
//

import Foundation

// mainactor kullanmazsan performans kaybı yaşarsın
// asenkron bir işlem yapıyorsan kullanmalısın
// uikitte DispetchQueue
@MainActor
class SaveViewModel {
    private let repository = ToDosRepository()
    
    // asenkron fonksiyon çalıştırmak istersen await kullanmalısın
    func save(name: String, image: String) async {
        do {
            // hata bulursan cathe fırlat
            try await repository.save(name: name, image: image)
        }catch {
            // hata olursa burda kodlama yap
        }
    }
}
