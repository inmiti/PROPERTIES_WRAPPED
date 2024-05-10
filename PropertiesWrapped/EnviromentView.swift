//
//  EnviromentView.swift
//  PropertiesWrapped
//
//  Created by ibautista on 10/5/24.
//

import SwiftUI

//Similar a ObservedObject pero aplicado a propiedades que tenemos que pasar a mas de una pantalla.Importante añadir en la preview .enviromentObject(UserData()) con el objeto que queremos traer a la view.
struct EnviromentView: View {
    @EnvironmentObject var user: UserData
    
    var body: some View {
        Text(user.name)
    }
}

struct EnviromentView_Previews: PreviewProvider {
    static var previews: some View {
        EnviromentView().environmentObject(UserData())
    }
}
