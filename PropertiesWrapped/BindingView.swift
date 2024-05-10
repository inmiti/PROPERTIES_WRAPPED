//
//  BindingView.swift
//  PropertiesWrapped
//
//  Created by ibautista on 10/5/24.
//

import SwiftUI

struct BindingView: View {
    // Todos los property wrappe se repinta la vista cuando cambia su valor
    // @Biding se usa cuando: 1 - propiedad que va a modificar su valor, tipo por valor. 2 - No se ha creado en la vista que va a utilizar. Hay que crear la navegación desde la otra vista, usando $nombrevariable.
    @Binding var value: Int //No se inicializa porque le llega el valor de otra vista
    
    // @ObservedObject se usa en la vista que recibe el envío de la variable. Tipo por referencia
    @ObservedObject var user: UserData
    
    @State private var selection: Int?
    
    var body: some View {
        VStack {
            Text("El valor actual es \(value)")
            Button("Suma 2") {
                value += 2
            }
            Text("El valor actual del username es \(user.name)")
            Button("Actualizar datos del user") {
                user.name = "M. Inmaculada Bautista"
                user.age = 45
            }
            
            NavigationLink(destination: EnviromentView(), tag: 1, selection: $selection){
                Button("Ir a EnviromentView") {
                    selection = 1
                }
            }
        }
    }
}

struct BindingView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView(value: .constant(5), user: UserData())
    }
}
