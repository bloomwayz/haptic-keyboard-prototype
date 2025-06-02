import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var engine: CHHapticEngine?
    @State private var currentBlock: (row: Int, col: Int)? = nil
    @State private var longPressTimer: Timer?
    @State private var longPressTriggered = false
    
    // 키보드 구현을 위한 state 선언
    @State private var inputText: String = ""
    @State private var isShifted: Bool = false // Shift state

    let rows = 7
    let cols = 5

    let blockLabels: [String] = [
        "Q", "W", "⌦", "O", "P",
        "A", "S", "⌦", "K", "L",
        "Z", "X", "⇧", "N", "M",
        "E", "R", "␣", "U", "I",
        "D", "F", "␣", "H", "J",
        "C", "V", "⏎", "B", "Y",
        "T", "G", "⏎", ",", "?"
    ]

    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(inputText)
                   .font(.title)
                   .padding()
                Spacer()
                VStack(spacing: 0) {
                    ForEach(0..<rows, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<cols, id: \.self) { col in
                                let idx = row * cols + col
                                ZStack {
                                    Rectangle()
                                        .fill(self.colorFor(row: row, col: col))
                                        .frame(width: geo.size.width / CGFloat(cols),
                                               height: geo.size.width / CGFloat(cols))
                                    Text(blockLabels[idx])
                                        .font(.system(size: 24))
                                        .foregroundColor(self.colorFor(row: row, col: col) == .black ? .white : .black)
                                }
                            }
                        }
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let block = self.blockAt(location: value.location, in: geo.size)
                            if block?.row != self.currentBlock?.row || block?.col != self.currentBlock?.col {
                                self.currentBlock = block
                                self.longPressTriggered = false
                                self.longPressTimer?.invalidate()
                                if let block = block {
                                    self.prepareHaptics()
                                    self.playBlockHaptic(row: block.row, col: block.col)
                                    //self.longPressTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                    //self.longPressTriggered = true
                                    //self.prepareHaptics()
                                    //self.playBlockHaptic(row: block.row, col: block.col)
                                    //}
                                }
                            }
                        }
                        .onEnded { _ in
                            self.longPressTimer?.invalidate()
                            if let block = self.currentBlock {
                                self.prepareHaptics()
                                self.playConfirmHaptic(row: block.row, col: block.col)
                                self.handleKeyInput(row: block.row, col: block.col)
                            }
                            self.currentBlock = nil
                        }
                )
            }
        }
    }

    func blockAt(location: CGPoint, in size: CGSize) -> (row: Int, col: Int)? {
        let blockWidth = size.width / CGFloat(cols)
        let blockHeight = size.width / CGFloat(cols)
        let col = Int(location.x / blockWidth)
        let row = Int(location.y / blockHeight)
        guard row >= 0, row < rows, col >= 0, col < cols else { return nil }
        return (row, col)
    }

    func colorFor(row: Int, col: Int) -> Color {
        let idx = row * cols + col
            let label = blockLabels[idx]
            switch label {
            case "␣":
                return .yellow.opacity(0.7)
            case "⌦":
                return .red.opacity(0.7)
            case "⇧":
                return .blue.opacity(0.7)
            case "⏎":
                return .green.opacity(0.7)
            default:
                // Alternate black and white for normal keys
                return (row + col) % 2 == 0 ? .white : .black
            }
    }

    func prepareHaptics() {
        if engine == nil {
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("Engine Start Error: \(error.localizedDescription)")
            }
        }
    }

    private func playHaptics(events: [CHHapticEvent]) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error.localizedDescription)")
        }
    }

    func playBlockHaptic(row: Int, col: Int) {
        switch (row, col) {
        case (0,0): HapticManager.doHaptics_test_Q(engine: engine) // Q
        case (0,1): HapticManager.doHaptics_test_W(engine: engine) // W
        case (0,2), (1,2): HapticManager.doHaptics_test(engine: engine) // Backspace
        case (0,3): HapticManager.doHaptics_03(engine: engine) // O
        case (0,4): HapticManager.doHaptics_04(engine: engine) // P

        case (1,0): HapticManager.doHaptics_test_A(engine: engine) // A
        case (1,1): HapticManager.doHaptics_test_S(engine: engine) // S
        case (1,3): HapticManager.doHaptics_13(engine: engine) // K
        case (1,4): HapticManager.doHaptics_14(engine: engine) // L

        case (2,0): HapticManager.doHaptics_test_Z(engine: engine) // Z
        case (2,1): HapticManager.doHaptics_test_X(engine: engine) // X
        case (2,2): HapticManager.doHaptics_22(engine: engine) // shift
        case (2,3): HapticManager.doHaptics_23(engine: engine) // N
        case (2,4): HapticManager.doHaptics_24(engine: engine) // M

        case (3,0): HapticManager.doHaptics_test_E(engine: engine) // E
        case (3,1): HapticManager.doHaptics_test_R(engine: engine) // R
        case (3,2), (4,2): HapticManager.doHaptics_32(engine: engine) // space
        case (3,3): HapticManager.doHaptics_33(engine: engine) // U
        case (3,4): HapticManager.doHaptics_34(engine: engine) // I

        case (4,0): HapticManager.doHaptics_test_D(engine: engine) // D
        case (4,1): HapticManager.doHaptics_test_F(engine: engine) // F
        //case (4,2): HapticManager.doHaptics_42(engine: engine) // space
        //case (4,2): HapticManager.doHaptics_31(engine: engine) // space
        case (4,3): HapticManager.doHaptics_43(engine: engine) // H
        case (4,4): HapticManager.doHaptics_44(engine: engine) // J

        case (5,0): HapticManager.doHaptics_test_C(engine: engine) // C
        case (5,1): HapticManager.doHaptics_test_V(engine: engine) // V
        case (5,2), (6,2): HapticManager.doHaptics_52(engine: engine) // enter
        case (5,3): HapticManager.doHaptics_53(engine: engine) // B
        case (5,4): HapticManager.doHaptics_54(engine: engine) // Y

        case (6,0): HapticManager.doHaptics_test_T(engine: engine) // T
        case (6,1): HapticManager.doHaptics_test_G(engine: engine) // G
        case (6,3): HapticManager.doHaptics_63(engine: engine) // ,
        case (6,4): HapticManager.doHaptics_64(engine: engine) // ?

        default: print("Invalid input for haptic feedback: row \(row), col \(col)")
        }
    }

    func playConfirmHaptic(row: Int, col: Int) {
        HapticManager.doHaptics_onEnded(engine: engine)
    }
    
    func handleKeyInput(row: Int, col: Int) {
        let idx = row * cols + col
        guard idx < blockLabels.count else { return }
        let label = blockLabels[idx]
        switch label {
        case "␣":
            inputText.append(" ")
        case "⏎":
            inputText.append("\n")
        case "⇧":
            isShifted.toggle()
        case "⌦":
            if !inputText.isEmpty {
                inputText.removeLast()
            }
        case "":
            break
        default:
            if isShifted {
                inputText.append(label.uppercased())
                isShifted = false
            } else {
                inputText.append(label.lowercased())
            }
        }
    }
}

#Preview {
    ContentView()
}
