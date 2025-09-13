//
//  ContentView.swift
//  ToDosApp
//
//  Created by Sümeyye Sert on 4.09.2025.
//

import SwiftUI

// left - leading
// right - trailing
// maxWidth: .infinity, maxHeight: .infinity -> match constraint (bulunduğu alan kadar yayıl)

struct MainScreen: View {
    
    init() {
        // bunu yaparsak bu tüm uyuglamada uygulanıyor tekrar tekrar yazmana gerek kalmıyor
        // başka bir sayfa oluştursak şu an bunun sayesinde arkaplanda bu sayfadaki oluşturduğumuz renk olacak
        NavigationBarStyle.setuptNavigationBar()
    }
    
    @State private var searchText: String = ""
    @ObservedObject var viewModel = MainViewModel()
    
    var body: some View {
        // navigationstack bir altyapıdır. sayfa geçişine yardımcı olur.
        NavigationStack {
            
            Group {
                if viewModel.toDosList.isEmpty {
                    Text("No ToDos Yet!").foregroundStyle(AppColors.textColor)
                }else {
                    List {
                        // Kullanmak istediğimiz sınıfa bir protokol eklememiz gerekiyor: Identifiable
                        ForEach(viewModel.toDosList) { toDo in
                            NavigationLink(destination: UpdateScreen(toDo: toDo)){
                                ToDoListItem(toDo: toDo)
                            }
                        }.onDelete(perform: delete)
                        
                    }
                }
            }
            .navigationTitle("ToDos")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SaveScreen()) {
                            Image(systemName: "plus")
                                .foregroundColor(AppColors.white)
                        }
                    }
                }
                .onAppear() {
                    Task {
                       await viewModel.loadToDos()
                        
                    }
                }
        }
        .tint(AppColors.white)
        .searchable(text: $searchText, prompt: "Search")
        .onChange(of: searchText) { _, result in
            Task {
                await viewModel.search(searchText: result)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        let toDo = viewModel.toDosList[offsets.first!]
        Task {
            await viewModel.delete(id: toDo.id!)
        }
    }
}

#Preview {
    MainScreen()
}

/*
 // class referans tipli, struct value tipli
 // ContentView class ismi, View kalıtım olduğunu gösteriyor
 
 VStack(alignment: .trailing, spacing: 32) {
     Rectangle().fill(.red).frame(width: 100, height: 100).padding()
     Rectangle().fill(.green).frame(width: 75, height: 75).padding(8)
     Spacer().frame(width: 50, height: 50)
     Rectangle().fill(.blue).frame(width: 50, height: 50).padding(.top)
     // spacing: öğeler arası boşluğu ayarlıyor (8'in katları tercih edilir)
     
     // Spacer() Vstackteyse bulunudğu yer kadar aşağıda yukaroya, Hstackteyse bulunuduğu yer kadar sağ ve solda alan kaplar frame gibi komple değil
     
     Rectangle().fill(.yellow).frame(width: 50, height: 50).padding(.vertical, 8)
     Rectangle().fill(.orange).frame(width: 50, height: 50).padding([.leading, .top], 10)

 }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // bunu yapınca vstack tüm sayfayı kapladı

 
 */

/*
    .onAppear() {
        print("onappear metodu çalıştı.")
        // sayfa her görüldüğünde çalışır.
        // bu sayfaya geri dönüldüğünde çalışır.
    }
    .onDisappear() {
        print("ondisappear metodu çalıştı.")
        // sayfa her görünmez olduğunda çalışır.
    }
*/

// private: oluşturulan değişken sadece tanımlandığı sınıfta geçerli
// state: arayüzde hangi değeri çalıştırıacaksak değişimi görebiliyoruz state sayesinde
// @State private var sayfaGecisKontrol = false
