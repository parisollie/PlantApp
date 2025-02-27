//
//  DetailView.swift
//  PlantApp
//
//  Created by Paul F on 27/02/25.
//

import SwiftUI
//Paso 3.0
struct DetailView: View {
    //Paso 3.1
    @Binding var showView: Bool
    var animation: Namespace.ID
    var plant: Plant
    // For More About Hero Animation, See Animation hack Video
    // MARK: Animation Properties
    @State var showContent: Bool = false
    
    //Paso 3.2
    var body: some View {
        //Paso 3.22
        GeometryReader{
            let size = $0.size
            //Paso 3.23
            VStack(spacing: -30){
                Image(plant.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: plant.id, in: animation)
                    .frame(width: size.width - 50, height: size.height / 1.6,alignment: .bottom)
                    //Paso 3.28
                    .zIndex(1)
                //Paso 3.25
                VStack(spacing: 20){
                    HStack{
                        //paso 3.29
                        Text(plant.plantName)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .foregroundStyle(.black)
                        
                        Text(plant.price)
                            .font(.title3.bold())
                            .padding(.horizontal,12)
                            .padding(.vertical,8)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green.opacity(0.1))
                            }
                            .foregroundStyle(.black)
                    }
                    //Paso 3.30
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                    //Paso 3.31
                    Button {
                        
                    } label: {
                        //Paso 3.32
                        Text("Buy Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .leading) {
                                Image("Cart")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 26, height: 26)
                            }
                            //Paso 3.22
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(.black)
                            }
                    }
                    .padding(.top,25)
                }
                //Paso 3.26
                .padding(.top,30)
                .padding(.bottom,15)
                .padding(15)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
                //Paso 3.27
                .background(content: {
                    CustomCorner(corners: [.topLeft,.topRight], radius: 25)
                        .fill(.white)
                        .ignoresSafeArea()
                })
                .offset(y: showContent ? 0 : (size.height / 1.5))
                .zIndex(0)
            }
            //Paso 3.24
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        }
        .padding(.top,30)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        //Paso 3.19
        .overlay(alignment: .top, content: {
            //Paso 3.14
            HeaderView()
                .opacity(showContent ? 1 : 0)
        })
        //Paso 3.3
        .background {
            Rectangle()
                .fill(Color("Green").gradient)
                .ignoresSafeArea()
                //Paso 3.18
                .opacity(showContent ? 1 : 0)
        }
        .onAppear {
            //Paso 3.4
            withAnimation(.easeInOut(duration: 0.35).delay(0.05)){
                showContent = true
            }
        }
    }
    
    //Paso 3.13
    @ViewBuilder
    func HeaderView()->some View{
        //Paso 3.15
        Button {
            // MARK: Closing View And Showing Tab Bar
            //Paso 3.17
            withAnimation(.easeInOut(duration: 0.3)){
                showContent = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                showTabBar()
                withAnimation(.easeInOut(duration: 0.35)){
                    showView = false
                }
            }
        } label: {
            //Paso 3.16
            Image(systemName: "chevron.left")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(15)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
