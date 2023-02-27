//
//  OnBoarding.swift
//  MyLittleLemon
//
//  Created by Prashant Singh Chauhan on 2/16/23.
//

import SwiftUI

let firstNameK = "First Name Key"
let lastNameK = "Last Name Key"
let emailK = "Email Key"
let phoneNumberK = "Phone Key"
let isLoggedInK = "LoggedIn Key"

struct OnBoarding: View {
    @State var firstNameTextFieldText: String = ""
    @State var lastNameTextFieldText: String = ""
    @State var emailTextFieldText: String = ""
    @State var isLoggedIn = false
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentation
   
    var body: some View {
        NavigationView {
            VStack {
                Image("littleLemon")
                    .resizable()
                    .frame(width : 160, height: 45)
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
                }
                .padding(.horizontal, 10)
                .frame(width: 400, height: 300)
                .background(Color("Main2"))
                
                VStack (alignment: .leading){
                    Text(" First Name *")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                        
                    TextField(" Please enter your first name", text: $firstNameTextFieldText)
                        .textFieldStyle(.roundedBorder)
                        
                    Text(" Last Name *")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    TextField(" Please enter your last name", text: $lastNameTextFieldText)
                        .textFieldStyle(.roundedBorder)
                        
                    Text(" Email *")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    TextField(" Please enter your Email", text: $emailTextFieldText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                }
                .padding()
                Button("Register")
                {
                    if !firstNameTextFieldText.isEmpty && !lastNameTextFieldText.isEmpty && !emailTextFieldText.isEmpty {
                        
                        UserDefaults.standard.set(firstNameTextFieldText, forKey: firstNameK)
                        UserDefaults.standard.set(lastNameTextFieldText, forKey: lastNameK)
                        UserDefaults.standard.set(emailTextFieldText, forKey: emailK)
                        UserDefaults.standard.set(true, forKey: isLoggedInK)
                        self.isLoggedIn = true
                       
                    }
                    else {
                        self.showAlert.toggle()
                    }
                   
                }
                .frame(width: 200, height: 60)
                .background(Color.yellow)
                .cornerRadius(12)
                .padding(5)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Important message"), message: Text("Text Fields can't be empty"), dismissButton: .default(Text("Got it!")))
                  
                }
                Spacer()
                NavigationLink(
                    destination: Home(),
                    isActive: $isLoggedIn,
                    label: { EmptyView() }
                                           )
            }
            .onAppear {
                            if let loggedIn = UserDefaults.standard.object(forKey: isLoggedInK) as? Bool, loggedIn {
                                isLoggedIn = true
                            }
            }
        }

    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding( )
    }
}
