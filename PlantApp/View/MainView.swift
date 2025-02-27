//
//  MainView.swift
//  PlantApp
//
//  Created by Paul F on 27/02/25.
//

import SwiftUI

struct MainView: View {
    // MARK: View Properties
    //Paso 1.5
    @State var currentTab: Tab = .home
    //Paso 1.8,variable para la animacion de los TapBars
    @Namespace var animation
    
    //Paso 1.18
    init(){
        // MARK: For Hiding Native Tab Bar
        // As of Xcode 14.1 Beta .toolbar(.hidden) is broken for Native SwiftUI TabView
        UITabBar.appearance().isHidden = true
    }
    //Paso 3.8, pongo(   @State var showTabBar: Bool = true)
    @State var showTabBar: Bool = true
    var body: some View {
        //Paso 1.2, ponemos el Z
        ZStack(alignment: .bottom) {
            //Paso 1.17
            TabView(selection: $currentTab) {
                //Paso 1.19,pondremos las ventanitas
                Home()
                    /*Paso 1.22, con esto vamos cambiando entre los tabs,para que sea
                    el correcto*/
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.home)
                
                Text("Scan")
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.scan)
                
                Text("File's")
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.folder)
                
                Text("Cart")
                    .setTabBarBackground(color: Color("BG"))
                    .tag(Tab.cart)
            }
            
            //Paso 1.7
            TabBar()
                //Paso 3.11
                .offset(y: showTabBar ? 0 : 130)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: showTabBar)
        }
        //Paso 2.10
        .ignoresSafeArea(.keyboard, edges: .bottom)
        //Paso 3.5 ,Instead Of Passing Reference We're Going to Use NotificationCenter to Post Notification
        .onReceive(NotificationCenter.default.publisher(for: .init("SHOWTABBAR"))) { _ in
            //Paso 3.9
            showTabBar = true
        }
        .onReceive(NotificationCenter.default.publisher(for: .init("HIDETABBAR"))) { _ in
            //Paso 3.10
            showTabBar = false
        }
    }
    
    // MARK: Custom Tab Bar
    //Paso 1.3
    @ViewBuilder
    func TabBar()->some View{
        HStack(spacing: 0){
            //Paso 1.4
            ForEach(Tab.allCases,id: \.rawValue){tab in
                //Paso 1.6
                Image(tab.rawValue)
                    //Ponemos sus modifiers
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.5))
                    //Paso 1.15
                    .offset(y: currentTab == tab ? -30 : 0)
                    .background(content: {
                        //Paso 1.9
                        if currentTab == tab{
                            Circle()
                                .fill(.black)
                                .scaleEffect(2.5)
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 5, y: 10)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                                //Paso 1.14
                                .offset(y: currentTab == tab ? -30 : 0)
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.top,15)
                    .padding(.bottom,10)
                    //Paso 1.16
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currentTab = tab
                    }
            }
        }
        .padding(.horizontal,15)
        //Paso 1.10
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.65), value: currentTab)
        .background {
            // MARK: Custom Corner
            //Paso 1.13
            CustomCorner(corners: [.topLeft,.topRight], radius: 25)
                .fill(Color("Tab"))
                .ignoresSafeArea()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        //Paso 1.1
        ContentView()
    }
}

// MARK: Extension for Setting Tab View Background
// Paso 1.20
extension View{
    //Paso 3.6, Global View Access For Show/Hide Tab Bar
    func showTabBar(){
        NotificationCenter.default.post(name: NSNotification.Name("SHOWTABBAR"), object: nil)
    }
    //Paso 3.7
    func hideTabBar(){
        NotificationCenter.default.post(name: NSNotification.Name("HIDETABBAR"), object: nil)
    }
    
    //Paso 1.21
    @ViewBuilder
    func setTabBarBackground(color: Color)->some View{
        self
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background {
                color
                    .ignoresSafeArea()
            }
    }
}
