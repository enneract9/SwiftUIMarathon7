//
//  FoldingView.swift
//  SwiftUIMarathon7
//
//  Created by @_@ on 19.12.2024.
//

import SwiftUI

struct FoldingView: View {
    
    @Namespace private var namespace
    
    enum FoldingState {
        case folded
        case expanded
        
        mutating func toggle() {
            self = switch self {
            case .folded: .expanded
            case .expanded: .folded
            }
        }
    }
    
    @State var state: FoldingState = .folded
    
    private var alignment: Alignment {
        switch state {
        case .folded: return .center
        case .expanded: return .topLeading
        }
    }
    
    private var size: CGSize {
        switch state {
        case .folded: return CGSize(width: 90, height: 60)
        case .expanded: return CGSize(width: CGFloat.infinity, height: 360)
        }
    }
    
    var body: some View {
        if state == .expanded {
            foldingView()
        } else {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    foldingView()
                }
            }
        }
    }
    
    @ViewBuilder
    private func foldingView() -> some View {
        ZStack(alignment: alignment) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue)
                .matchedGeometryEffect(id: "frame", in: namespace, properties: .frame)

            Button {
                withAnimation {
                    state.toggle()
                }
            } label: {
                buttonLabel()
                    .matchedGeometryEffect(id: "position", in: namespace, properties: .position)
            }
        }
        .frame(maxWidth: size.width, maxHeight: size.height)
    }
    
    @ViewBuilder
    private func buttonLabel() -> some View {
        Group {
            switch state {
            case .folded:
                Text("Open")
            case .expanded:
                Label("Back", systemImage: "arrowshape.backward.fill")
            }
        }
        .font(.title3)
        .bold()
        .foregroundColor(.white)
        .padding()
    }
}

#Preview {
    FoldingView()
}
