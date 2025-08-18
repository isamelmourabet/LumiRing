//
//  HomeView.swift
//  LumiRing
//
//  Created by Isam El Mourabet on 18/8/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var isConected: Bool = true
    @State var isCalling: Bool = false
    @State var isLocked: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.5)
                
                VStack {
                    if !isConected {
                        Text("No se ha encontrado el dispositivo")
                            .padding()
                    }
                    
                    Button(isConected ? "Desconectar" : "Conectar") {
                        isConected.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    
                    if isConected {
                        VStack  {
                            HStack {
                                Text("Entrada")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding()
                                
                                Spacer()
                                
                                if #available(macOS 26.0, *) {
                                    Image(systemName: "ellipsis")
                                        .frame(width: 30, height: 30)
                                        .glassEffect(.regular .interactive())
                                        .padding()
                                        .onTapGesture {
                                            print("Configuracion activada")
                                        }
                                } else {
                                    // Fallback on earlier versions
                                    Image(systemName: "ellipsis")
                                        .frame(width: 30, height: 30)
                                        .background(.secondary)
                                        .clipShape(Circle())
                                        .padding()
                                }
                            }
                            
                            Spacer()
                            
                            HStack {
                                if #available(macOS 26.0, *) {
                                    GlassEffectContainer {
                                        HStack {
                                            if isCalling {
                                                Image(systemName: "phone.down.fill")
                                                    .frame(width: 40, height: 40)
                                                    .glassEffect(.regular .interactive())
                                                    .onTapGesture {
                                                        withAnimation() {
                                                            isCalling = false
                                                        }
                                                    }
                                                    
                                            }
                                            
                                            Image(systemName: "phone.fill")
                                                .frame(width: 40, height: 40)
                                                .glassEffect(.regular .interactive())
                                                .onTapGesture {
                                                    withAnimation() {
                                                        isCalling = true
                                                    }
                                                }
                                        }
                                        .padding()
                                    }
                                    
                                } else {
                                    // Fallback on earlier versions
                                    HStack {
                                        if isCalling {
                                            Image(systemName: "phone.down.fill")
                                                .frame(width: 40, height: 40)
                                                .background(.secondary)
                                                .clipShape(Circle())
                                                .onTapGesture {
                                                    withAnimation() {
                                                        isCalling = false
                                                    }
                                                }
                                                
                                        }
                                        
                                        Image(systemName: "phone.fill")
                                            .frame(width: 40, height: 40)
                                            .background(.secondary)
                                            .clipShape(Circle())
                                            .onTapGesture {
                                                withAnimation() {
                                                    isCalling = true
                                                }
                                            }
                                    }
                                    .padding()
                                }
                                
                                Spacer()
                                
                                if #available(macOS 26.0, *) {
                                    Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                                        .frame(width: 40, height: 40)
                                        .glassEffect(.regular .interactive())
                                        .padding()
                                        .onTapGesture {
                                            withAnimation(.bouncy) {
                                                isLocked.toggle()
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                withAnimation {
                                                    isLocked.toggle()
                                                }                                            }
                                        }
                
                                } else {
                                    // Fallback on earlier versions
                                    Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                                        .frame(width: 40, height: 40)
                                        .background(.secondary)
                                        .clipShape(Circle())
                                        .padding()
                                        .onTapGesture {
                                            withAnimation(.bouncy) {
                                                isLocked.toggle()
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                                withAnimation {
                                                    isLocked.toggle()
                                                }                                            }
                                        }
                                }
                            }
                            
                        }
                        .frame(width: 200, height: 200)
                        .background(Color.blue)
                        .shadow(radius: 10, x: 5, y: 5)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                    }
                }
            }
            .ignoresSafeArea(.all)
            .navigationTitle("Inicio")
        }
    }
}

#Preview {
    HomeView()
}
