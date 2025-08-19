//
//  TestView.swift
//  LumiRing
//
//  Created by Isam El Mourabet on 18/8/25.
//

import SwiftUI

struct TestView: View {
    @State private var status: String = "Esperando..."
    @State private var ringAlert: Bool = false
    private let service = WebService()
        
    var body: some View {
        VStack(spacing: 20) {
            Text(status)
                .font(.headline)
                .padding()
                
            Button("🔓 Abrir puerta") {
                Task {
                    do {
                        try await service.openDoor()
                        status = "Puerta abierta ✅"
                    } catch {
                        status = "Error abriendo puerta ❌"
                    }
                }
            }
            .buttonStyle(.borderedProminent)
                
            Button("📊 Consultar estado") {
                Task {
                    do {
                        status = try await service.getStatus()
                    } catch {
                        status = "Error al consultar estado ❌"
                    }
                }
            }
            .buttonStyle(.bordered)
        }
        .alert("🚨 Timbre sonando", isPresented: $ringAlert) {
            Button("OK", role: .cancel) {}
        }
        .onAppear {
            // 🔄 Polling cada 2s para ver si suena el timbre
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

#Preview {
    TestView()
}
