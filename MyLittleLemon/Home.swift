//
//  Home.swift
//  MyLittleLemon
//
//  Created by Prashant Singh Chauhan on 2/16/23.
//

import SwiftUI

struct Home: View {
 @Environment(\.managedObjectContext) private var viewContext
    let persistence = PersistenceController.shared
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                   Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile",  systemImage: "square.and.pencil")
                }
                
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
