//
//  Menu.swift
//  MyLittleLemon
//
//  Created by Prashant Singh Chauhan on 2/16/23.
//

import SwiftUI

struct Menu: View {
    
    @State var searchText = ""
    @State var showSearchBar = false 
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image("littleLemon")
                        .resizable()
                        .frame(width : 190, height: 50, alignment: .leading)
                    NavigationLink {
                        UserProfile()
                    } label: {
                        Image("ProfilePicture")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 10)
                VStack(alignment: .leading) {
                    Text("Little Lemon")
                        .font(.system(size: 40, design: .serif))
                        .foregroundColor(Color("Main1"))
                        .fontWeight(.bold)
                    HStack (alignment: .top){
                        VStack (alignment: .leading){
                            Text("Chicago")
                                .font(.system(size: 36, design: .serif))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Text("We are a family owned Meditarian Restaurant, focsed on traditional recipie served with a modern twist.")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(.white)
                        }
                        
                        Image("ChickenDijon")
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: 130)
                    }
                    .frame(height: 150)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color("Main2"))
                            .clipShape(Circle())
                            .onTapGesture {
                                self.showSearchBar.toggle()
                            }
                        TextField("What you looking for ?", text: $searchText)
                            .opacity(showSearchBar ? 1.0 : 0.0)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                    }
                    
                }
                .padding(.horizontal, 10)
                .frame(width: 400, height: 300)
                .background(Color("Main2"))
                VStack  {
                    
                    FetchedObjects(predicate : buildPredicate(),sortDescriptors: buildSortDescriptors()){ (dishes: [Dish]) in
                        
                        List {
                            VStack (alignment: .leading){
                                
                                Text("ORDER FOR DELIVERY!")
                                    .fontWeight(.bold)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        
                                        Button {
                                            
                                        } label: {
                                            Text("Starters")
                                                .frame(width: 80, height: 20)
                                                .padding()
                                                .fontWeight(.bold)
                                                .background(Color.gray.opacity(0.1))
                                                .foregroundColor(Color("Main2"))
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }
                                        Button {
                                            
                                        } label: {
                                            Text("Mains")
                                                .frame(width: 80, height: 20)
                                                .padding()
                                                .fontWeight(.bold)
                                                .background(Color.gray.opacity(0.1))
                                                .foregroundColor(Color("Main2"))
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }
                                        Button {
                                            
                                        } label: {
                                            Text("Desserts")
                                                .frame(width: 80, height: 20)
                                                .padding()
                                                .fontWeight(.bold)
                                                .background(Color.gray.opacity(0.1))
                                                .foregroundColor(Color("Main2"))
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }
                                        Button {
                                            
                                        } label: {
                                            Text("Drinks")
                                                .frame(width: 80, height: 20)
                                                .padding()
                                                .fontWeight(.bold)
                                                .background(Color.gray.opacity(0.1))
                                                .foregroundColor(Color("Main2"))
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            ForEach(dishes, id: \.self) { dish in
                                HStack {
                                    VStack (alignment: .leading) {
                                        Text(dish.title!)
                                            .fontWeight(.bold)
                                        Text(dish.detail!)
                                            .italic()
                                            .foregroundColor(Color("Main2"))
                                        Text("$\(dish.price!)")
                                            .foregroundColor(Color("Main2"))
                                            .fontWeight(.bold)
                                        
                                    }
                                    .frame(alignment: .leading)
                                    
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image!)) { image in
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                
                            }
                        }
                        .onAppear{
                            if dishes.isEmpty {
                                getMenuData()
                            }
                        }
                        .listStyle(.plain)
                        
                    }
                }
               
            }
        }
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .navigationBarBackButtonHidden(true)
        
    }
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let menuList = try JSONDecoder().decode(menuList.self, from: data)
                DispatchQueue.main.async {
                    
                    for item in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.image = item.image
                        dish.price = item.price
                        dish.detail = item.detail
                        try? viewContext.save()
                        
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
}


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
