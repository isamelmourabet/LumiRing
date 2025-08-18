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
<<<<<<< HEAD
                
=======
>>>>>>> dev
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
                    
<<<<<<< HEAD
                    
=======
>>>>>>> dev
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
<<<<<<< HEAD
=======
                                            //.offset(x: -10)
>>>>>>> dev
                                        }
                                        .padding()
                                    }
                                    
                                } else {
                                    // Fallback on earlier versions
                                    HStack {
<<<<<<< HEAD
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
=======
                                        Image(systemName: "phone.down.fill")
                                            .frame(width: 40, height: 40)
                                            .background(.secondary)
                                            .clipShape(Circle())
>>>>>>> dev
                                        
                                        Image(systemName: "phone.fill")
                                            .frame(width: 40, height: 40)
                                            .background(.secondary)
                                            .clipShape(Circle())
<<<<<<< HEAD
                                            .onTapGesture {
                                                withAnimation() {
                                                    isCalling = true
                                                }
                                            }
=======
>>>>>>> dev
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
                                            
<<<<<<< HEAD
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
=======
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
>>>>>>> dev
                                                withAnimation {
                                                    isLocked.toggle()
                                                }                                            }
                                        }
                
                                } else {
                                    // Fallback on earlier versions
<<<<<<< HEAD
                                    Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
=======
                                    Image(systemName: "lock.fill")
>>>>>>> dev
                                        .frame(width: 40, height: 40)
                                        .background(.secondary)
                                        .clipShape(Circle())
                                        .padding()
<<<<<<< HEAD
                                        .onTapGesture {
                                            withAnimation(.bouncy) {
                                                isLocked.toggle()
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                                withAnimation {
                                                    isLocked.toggle()
                                                }                                            }
                                        }
=======
>>>>>>> dev
                                }
                            }
                            
                        }
                        .frame(width: 200, height: 200)
                        .background(Color.blue)
<<<<<<< HEAD
                        .shadow(radius: 10, x: 5, y: 5)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
=======
                        .clipShape(RoundedRectangle(cornerRadius: 25))
>>>>>>> dev
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
