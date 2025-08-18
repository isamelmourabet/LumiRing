//
//  HomeView.swift
//  LumiRing
//
//  Created by Isam El Mourabet on 18/8/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var isConected: Bool = false
    
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
                                            Image(systemName: "phone.down.fill")
                                                .frame(width: 40, height: 40)
                                                .glassEffect(.regular .interactive())
                                            
                                            Image(systemName: "phone.fill")
                                                .frame(width: 40, height: 40)
                                                .glassEffect(.regular .interactive())
                                            //.offset(x: -10)
                                        }
                                        .padding()
                                    }
                                    
                                } else {
                                    // Fallback on earlier versions
                                    HStack {
                                        Image(systemName: "phone.down.fill")
                                            .frame(width: 40, height: 40)
                                            .background(.secondary)
                                            .clipShape(Circle())
                                        
                                        Image(systemName: "phone.fill")
                                            .frame(width: 40, height: 40)
                                            .background(.secondary)
                                            .clipShape(Circle())
                                    }
                                    .padding()
                                }
                                
                                Spacer()
                                
                                if #available(macOS 26.0, *) {
                                    Image(systemName: "lock.fill")
                                        .frame(width: 40, height: 40)
                                        .glassEffect(.regular .interactive())
                                        .padding()
                                } else {
                                    // Fallback on earlier versions
                                    Image(systemName: "lock.fill")
                                        .frame(width: 40, height: 40)
                                        .background(.secondary)
                                        .clipShape(Circle())
                                        .padding()
                                }
                            }
                            
                        }
                        .frame(width: 200, height: 200)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
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
