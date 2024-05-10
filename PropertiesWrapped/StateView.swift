//
//  StateView.swift
//  PropertiesWrapped
//
//  Created by ibautista on 10/5/24.
//

import SwiftUI

class UserData: ObservableObject {  //Esta clase podrá observar cambios en las propiedades y ser observada por otras, publicando los cambios para que una vista pueda consumirlas, modificarlas y leerlas. Sus propiedades tendran el @Published
    @Published var name: String = "Inma"
    @Published var age: Int = 35
}

struct StateView: View {
    // Todos los property wrappe se repinta la vista cuando cambia su valor
    // @State se usa cuando: 1 - propiedad que va a modificar su valor, tipo por valor. 2 - Se define en la propia vista, se inicializa en la propia vista. 
    @State private var value = 0
    @State private var selection: Int?
    
    //@StateObject: para propiedades mas complejas. 2 - Se usa en la vista propietaria de la variable compleja. Se usa para actualizaciones de datos tipo ObservableObject, tipo por referencia, no por valor. Con este property wrapped podremos enviar datos a nuestra BindingView.
    @StateObject private var user = UserData()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("El valor actual es \(value)")
                Button("Suma 1") {
                    value += 1
                }
                NavigationLink(destination: BindingView(value: $value, user: user), tag: 1, selection: $selection){
                    Button("Ir a BindingView") {
                        selection = 1
                    }
                }.navigationTitle("State View")
                Spacer()
                Text("Mi nombre es \(user.name)  mi edad \(user.age)")
                Button("Actualizar datos") { // Para que funcione y se actualicen datos en text hay que usar @Published y protoco ObservableObject
                    user.name = "Inmaculada"
                    user.age = 44
                }
                Spacer()
            }
        }
       
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView().environmentObject(UserData())
    }
}
