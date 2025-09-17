//
//  MainViewModel.swift
//  ToDosApp
//
//  Created by Sümeyye Sert on 11.09.2025.
//

import Foundation

// viewmodeller içerisinde return değeri olan fonksiyonlar olmaz
@MainActor
class MainViewModel : ObservableObject {
    private let repository = ToDosRepository()
    @Published var toDosList = [ToDos]()
    
    func loadToDos() async {
        do {
            toDosList = try await repository.loadToDos()
        } catch {
            // hata olduğunda boş liste
            toDosList = [ToDos]()
        }
    }
    
    func search(searchText: String) async {
        do {
            toDosList = try await repository.search(searchText: searchText)
        } catch {
            toDosList = [ToDos]()
        }
    }
    
    func delete(id: Int) async {
        do {
            try await repository.delete(id: id)
            await loadToDos()
        } catch {
            
        }
    }
    
}
