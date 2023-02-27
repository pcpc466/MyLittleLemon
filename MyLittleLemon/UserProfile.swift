//
//  UserProfile.swift
//  MyLittleLemon
//
//  Created by Prashant Singh Chauhan on 2/17/23.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: firstNameK)
    let lastName = UserDefaults.standard.string(forKey: lastNameK)
    let email = UserDefaults.standard.string(forKey: emailK)
    let phone = UserDefaults.standard.string(forKey: phoneNumberK)
    @Environment(\.presentationMode) var presentation
    @State var FirstNameTextFieldText: String = ""
    @State var LastNameTextFieldText: String = ""
    @State var EmailTextFieldText: String = ""
    @State var PhoneTextFieldText: String = ""
    let persistence = PersistenceController.shared
    var body: some View {
        NavigationView{
            ScrollView {
                VStack (alignment:.leading){
                        Text("Personal Information")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                       
                    Text("Avatar")
                        .foregroundColor(.gray)
                    HStack {
                        Image("ProfilePicture")
                            .frame(width: 50, height: 50)
                            .padding(.horizontal, 10)
                        Button {
                            
                        } label: {
                            Text("Change")
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color("Main2"))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                               
                        }
                        .padding(.horizontal)
                        Button {
                            
                        } label: {
                            Text("Remove")
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color.gray)
                                .background(Color.white)
                                .border(.gray, width: 2)
                           
                        }
                       
                    }
                    .padding()
                    VStack (alignment:.leading){
                        Text("First name")
                         .foregroundColor(.gray)
                         .fontWeight(.bold)
                         .frame(alignment: .leading)
                        TextField(firstName ??  "", text: $FirstNameTextFieldText)
                            .frame(alignment: .leading)
                            .foregroundColor(.black)
                            .textFieldStyle(.roundedBorder)
                            
                     Text("Last name")
                      .foregroundColor(.gray)
                      .fontWeight(.bold)
                        TextField(lastName ??  "", text: $LastNameTextFieldText)
                            .foregroundColor(.black)
                            .textFieldStyle(.roundedBorder)
                     Text("Email")
                      .foregroundColor(.gray)
                      .fontWeight(.bold)
                        TextField(email ??  "", text: $EmailTextFieldText)
                            .foregroundColor(.black)
                            .textFieldStyle(.roundedBorder)
                        Text("Phone Number (Optional)")
                         .foregroundColor(.gray)
                         .fontWeight(.bold)
                        TextField(phone ??  "", text: $PhoneTextFieldText)
                            .foregroundColor(.black)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Email Notifications")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    
                    }
                   
                    VStack(alignment:.leading) {
                        HStack {
                            Image(systemName: "checkmark")
                                .padding(6)
                                .foregroundColor(.white)
                                .background(Color("Main2"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Order Statuses")
                        }
                        HStack {
                            Image(systemName: "checkmark")
                                .padding(6)
                                .foregroundColor(.white)
                                .background(Color("Main2"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Order Statuses")
                        }
                        HStack {
                            Image(systemName: "checkmark")
                                .padding(6)
                                .foregroundColor(.white)
                                .background(Color("Main2"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Order Statuses")
                        }
                        HStack {
                            Image(systemName: "checkmark")
                                .padding(6)
                                .foregroundColor(.white)
                                .background(Color("Main2"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text("Order Statuses")
                        }
                        
                        Button {
                            UserDefaults.standard.set(false, forKey: isLoggedInK)
                            self.presentation.wrappedValue.dismiss()
                            PersistenceController.shared.clear()
                        } label: {
                            Text("Log out ")
                                .fontWeight(.semibold)
                                .frame(width: 340, height: 50)
                                .foregroundColor(Color.black)
                                .background(Color("Main1"))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                              
                        }
                        HStack {
                        
                            Button {
                                
                            } label: {
                                Text("Remove")
                                    .fontWeight(.semibold)
                                    .frame(width: 170, height: 50)
                                    .foregroundColor(Color.gray)
                                .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray, lineWidth: 2)
                                )
                                }
                           
                            Button {
                                    
                                    UserDefaults.standard.set(FirstNameTextFieldText, forKey: firstNameK)
                                    UserDefaults.standard.set(LastNameTextFieldText, forKey: lastNameK)
                                    UserDefaults.standard.set(EmailTextFieldText, forKey: emailK)
                                    UserDefaults.standard.set(PhoneTextFieldText, forKey: phoneNumberK)
                                
                                
                            } label: {
                                Text("Save Changes")
                                    .frame(width: 170, height: 50)
                                    .foregroundColor(Color.white)
                                    .background(Color("Main2"))
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                 
                            }
                       
                        }
                       
                    }
                    .padding(.bottom, 10)
                }
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 2)
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image("ProfilePicture")
                            .resizable()
                            .frame(width: 60 , height: 60)
                            .clipShape(Circle())
                            .padding()
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: {
                            Menu()
                        }, label: {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .padding()
                                .frame(width: 50, height: 50)
                                .background(Color("Main2"))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        })
                    }
                    ToolbarItem(placement: .automatic) {
                        Image("littleLemon")
                            .resizable()
                            .frame(width: 220, height: 50)
                            .padding()
                    }
                    
                }
            }
            .frame(height: 620)
           
        }
        .navigationBarBackButtonHidden(true)
        .environment(\.managedObjectContext, persistence.container.viewContext)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
