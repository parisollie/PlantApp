//
//  Home.swift
//  PlantApp
//
//  Created by Paul F on 27/02/25.
//

import SwiftUI

struct Home: View {
    // MARK: View Properties
    // Paso 2.22
    @State var currentIndex: Int = 0
    
    // MARK: Detail View Properties
    // Paso 2.38
    @State var showDetailView: Bool = false
    @State var currentDetailPlant: Plant?
    @Namespace var animation
    
    var body: some View {
        //Paso 2.0
        ScrollView(.vertical, showsIndicators: false) {
            //Paso 2.1
            VStack(spacing: 15){
                //paso 2.3 , llamamos al HeaderView
                HeaderView()
                //Paso 2.8
                SearchView()
                //Paso 2.17
                PlantsView()
            }
            .padding(15)
            // MARK: Tab Bar Padding (Since Tab View is In the ZStack)
            .padding(.bottom,50)
        }
        //Paso 2.40
        .overlay {
            //Paso 3.5
            if let currentDetailPlant,showDetailView{
                DetailView(showView: $showDetailView, animation: animation, plant: currentDetailPlant)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(x: 0.5)))
            }
        }
    }
    //Paso 2.2
    @ViewBuilder
    func HeaderView()->some View{
        HStack{
            VStack(alignment: .leading, spacing: 7) {
                Text("Welcome 🍀")
                    .font(.title)
                    .foregroundStyle(.black)
                Text("Paul")
                    .font(.title.bold())
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            //Paso 2.4
            Button {
                
            } label: {
                //Paso 2.5, la campanita
                Image(systemName: "bell")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(17)
                    .background {
                        /*
                         //asi es para color normal
                         .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.blue) // Cambia "blue" por el color deseado
                        }*/

                        //Mi color personalizado
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("blueSky"))
                    }
                    // MARK: Badge
                    //2.6,la marca verde arriba de la campana.
                    .overlay(alignment: .topTrailing) {
                        Text("1")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(6)
                            .background {
                                Circle()
                                    .fill(Color("Green"))
                            }
                            .offset(x: 5, y: -10)
                    }
            }
        }
    }
    
    //Paso 2.7
    @ViewBuilder
    func SearchView()->some View{
        HStack(spacing: 15){
            HStack(spacing: 15){
                Image("Search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                //Paso 2.9
                Divider()
                //Paso 2.12
                    .padding(.vertical,-6)
                
                TextField("Search", text: .constant(""))
                //con este aparece el color blanco del Texfield
                    .textFieldStyle(.roundedBorder)
                    
            }
            //Paso 2.11
            .padding(15)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white)
            }
            //Paso 2.13
            Button {
                
            } label: {
                //Paso 2.14
                Image("Filter")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .padding(15)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                    }
            }
        }
        //Paso 2.15
        .padding(.top,15)
    }
    
    //Paso 2.16
    // MARK: Plant Carousel
    @ViewBuilder
    func PlantsView()->some View{
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center, spacing: 15) {
                Image("Grid")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 13, height: 13)
                
                
                Text("Most Popular")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .foregroundStyle(.black)
                
                Button("Show All"){
                    
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.leading,5)
            
            //Paso 2.18
            // MARK: Snap Carousel
            // I'm going to Use My Custom Carousel Which I Build Previosuly For Movie App UI,
            // Link In the Video Description
            //Paso 2.21
            CustomCarousel(index: $currentIndex, items: plants, spacing: 25, cardPadding: 90, id: \.id) { plant, size in
                //Paso 2.24
                PlantCardView(plant: plant, size: size)
                    //Paso 2.39
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //Paso 3.12,pongo el[hideTabBar()]
                        hideTabBar()
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)){
                            currentDetailPlant = plant
                            showDetailView = true
                        }
                    }
            }
            //Paso 2.25
            .frame(height: 380)
            .padding(.top,20)
            .padding(.horizontal,10)
        }
        
        .padding(.top,22)
    }
    
    // MARK: Plant Card View
    //Paso 2.23
    @ViewBuilder
    func PlantCardView(plant: Plant,size: CGSize)->some View{
        //Paso 2.26
        ZStack{
            LinearGradient(colors: [Color("Card Top"),Color("Card Bottom")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            //Paso 2.28
            VStack{
                Button {
                    
                } label: {
                    //Paso 2.29
                    Image(systemName: "suit.heart.fill")
                        .font(.title3)
                        .foregroundColor(Color("Green"))
                        .frame(width: 50, height: 50)
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.white)
                        }
                }
                //Paso 2.30
                .frame(maxWidth: .infinity,alignment: .topTrailing)
                .padding(15)
                
                // MARK: Adding Matched Geometry Effect
                //Paso 3.20
                VStack{
                    if currentDetailPlant?.id == plant.id && showDetailView{
                        Rectangle()
                            .fill(.clear)
                    }else{
                        //Paso 2.31
                        Image(plant.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //Paso 3.21 HACK: Declare Matched Geometry Id Before All Frame And Padding
                            .matchedGeometryEffect(id: plant.id, in: animation)
                            //Paso 2.33
                            .padding(.bottom,-35)
                            .padding(.top,-40)
                    }
                }
                .zIndex(1)
                
                HStack{
                    //Paso 2.34
                    VStack(alignment: .leading, spacing: 7) {
                        Text(plant.plantName)
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        
                        Text(plant.price)
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundStyle(.black)
                    }
                    //Paso 2.35
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    //Paso 2.36
                    Button {
                        
                    } label: {
                        //Paso 2.37
                        Image("Cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.black)
                            }
                    }
                }
                //Paso 2.32
                .padding([.horizontal,.top],15)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                }
                .padding(10)
                .zIndex(0)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
