//
//  HomeView.swift
//  LumiRing
//
//  Created by Isam El Mourabet on 18/8/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var isConected: Bool = false
    @State var isCalling: Bool = false
    @State var isLocked: Bool = true
    @State var ringAlert: Bool = false
    
    @State var status: String = "Esperando para conectar dispositivo..."
    
    private let service = WebService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.5)

                VStack {
                    Text(status)
                        .padding()
                    
                    Button(isConected ? "Desconectar" : "Conectar") {
                        isConected.toggle()
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                            Task {
                                do {
                                    if isConected {
                                        try await status = service.getStatus()
                                    } else {
                                        status = "Esperando para conectar dispositivo..."
                                    }
                                    
                                } catch {
                                    status = "Error: \(error)"
                                }
                            }
                        }
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
                                
                                if #available(iOS 26.0, *) {
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
                                if #available(iOS 26.0, *) {
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
                                
                                if #available(iOS 26.0, *) {
                                    Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                                        .frame(width: 40, height: 40)
                                        .glassEffect(.regular .interactive())
                                        .padding()
                                        .onTapGesture {
                                            withAnimation {
                                                isLocked.toggle()
                                                
                                                Task {
                                                    do {
                                                        try await service.openDoor()
                                                        print("Puerta abierta")
                                                    } catch {
                                                        print("Error al abrir la puerta: \(error)")
                                                    }
                                                }
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                                    isLocked.toggle()
                                                }
                                            }
                                        }
                
                                } else {
                                    // Fallback on earlier versions
                                    Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                                        .frame(width: 40, height: 40)
                                        .background(.secondary)
                                        .clipShape(Circle())
                                        .padding()
                                        .onTapGesture {
                                            isLocked.toggle()
                                            
                                            Task {
                                                do {
                                                    try await service.openDoor()
                                                    print("Puerta abierta")
                                                } catch {
                                                    print("Error al abrir la puerta: \(error)")
                                                }
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                                withAnimation {
                                                    isLocked.toggle()
                                                }
                                            }
                                        }
                                }
                            }
                            
                        }
                        .frame(width: 200, height: 200)
                        .background(Color.blue)
                        .shadow(radius: 10, x: 5, y: 5)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                        .alert("Tienes un visitante", isPresented: $ringAlert) {
                            Button("OK", role: .cancel) {}
                        }
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                                Task {
                                    if let isRinging = try? await service.checkRing(), isRinging {
                                        ringAlert = true
                                    }
                                }
                            }
                        }
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
