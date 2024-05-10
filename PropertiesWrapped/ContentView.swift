//
//  ContentView.swift
//  PropertiesWrapped
//
//  Created by ibautista on 10/5/24.
//

import SwiftUI

//Model
struct PostModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

//ViewModel
class PostViewModel: ObservableObject {
    @Published var postList = [PostModel]() // Es un observable. Cuando cambia la variable dispara la infomacion a quien está suscrito a ella. Sería necesario el protocolo ObservableObject y añadir el escuchador en la vista con @ObservedObject
    
    //Método para llamada a la API
    func initialize() async{
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url) // Network
            if let response = try? JSONDecoder().decode([PostModel].self, from: data){
                postList = response
            }
        } catch {
            print("error: ", error)
        }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = PostViewModel()  //Property wrapped escuchador
    //@StateObject se utilizaría si esta vista tuviera que pasar esos datos a otra vista.
    //EnviromentObject igual que observed pero cuando tenemos que pasar a mas de una pantalla.
    var body: some View {
        VStack {
            List{
                ForEach(viewModel.postList, id: \.id){ post in
                    Text(post.title) //Necesitamos indicarle el id para que pueda hacer la iteración para poder pintar la celda. Otra opcion sería añadir el potocolo identifible al modelo.
                }
            }.onAppear{ //Añade acción antes de que aparezca la vista
                Task{ //Unidad de trabajo asíncrono
                    await viewModel.initialize() //para que cargue los datos es necesario añadir al PostViewModel el protocolo ObservableObject y @ObservedObject a la var viewModel.
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
