import Foundation

public final class Console {
    internal let cpu: CPU

    public var controller1: Buttons {
        get {
            cpu.controller1.pressed
        }
        set {
            cpu.controller1.pressed = newValue
        }
    }

    public var controller2: Buttons {
        get {
            cpu.controller2.pressed
        }
        set {
            cpu.controller2.pressed = newValue
        }
    }

    public var frames: Int {
        ppu.frame
    }

    internal let ppu: PPU

    public var screenData: Data {
        Data(bytesNoCopy: ppu.frontBuffer.pixels.baseAddress!, count: ppu.frontBuffer.pixels.count, deallocator: .none)
    }

    public convenience init(cartridge: Cartridge, initialAddress: UInt16? = nil) {
        precondition(cartridge.mapper == 000 || cartridge.mapper == 002)

        let mapper = Mapper002(cartridge: cartridge)

        self.init(mapper: mapper)

        if let pc = initialAddress {
            cpu.pc = pc
        }
    }

    init(mapper: Mapper) {
        cpu = CPU(mapper: mapper)
        ppu = PPU(mapper: mapper)

        cpu.ppu = ppu
        ppu.cpu = cpu

        cpu.pc = cpu.read16(0xFFFC)
    }

    deinit {
        cpu.ppu = nil
        ppu.cpu = nil
    }

    public func step() {
        let before = cpu.cycles

        cpu.step()

        let after = cpu.cycles

        ppu.step(steps: 3 * (after - before))

        if ppu.nmiTriggered {
            ppu.nmiTriggered = false
            cpu.triggerNMI()
        }
    }

    public static let frequency = 1789773.0

    public func step(time: TimeInterval) {
        let target = cpu.cycles + Int(time * Console.frequency)

        while cpu.cycles < target {
            step()
        }
    }

    public var cycles: Int {
        cpu.cycles
    }

    // Add these extensions to Console.swift
extension Console {
    public struct CPUState {
        public let pc: UInt16
        public let a: UInt8
        public let x: UInt8
        public let y: UInt8
        public let status: UInt8
        public let sp: UInt8
    }
    
    public struct PPUState {
        public let scanline: Int
        public let cycle: Int
        public let frame: Int
    }
    
    public func getCPUState() -> CPUState {
        return CPUState(
            pc: cpu.pc,
            a: cpu.a,
            x: cpu.x,
            y: cpu.y,
            status: cpu.status,
            sp: cpu.sp
        )
    }
    
    public func getPPUState() -> PPUState {
        return PPUState(
            scanline: ppu.scanline,
            cycle: ppu.cycle,
            frame: ppu.frame
        )
    }
    
    public func debugDump() -> String {
        let cpuState = getCPUState()
        let ppuState = getPPUState()
        
        return """
        CPU State:
          PC: \(cpuState.pc.hex)  A: \(cpuState.a.hex)  X: \(cpuState.x.hex)  Y: \(cpuState.y.hex)
          Status: \(String(cpuState.status, radix: 2).pad(to: 8))  SP: \(cpuState.sp.hex)
        PPU State:
          Scanline: \(ppuState.scanline)  Cycle: \(ppuState.cycle)  Frame: \(ppuState.frame)
        """
    }
}

extension UInt16 {
    var hex: String { String(format: "%04X", self) }
}

extension UInt8 {
    var hex: String { String(format: "%02X", self) }
}

extension String {
    func pad(to length: Int, with character: Character = "0") -> String {
        String(repeating: character, count: max(0, length - count)) + self
    }
}
}
